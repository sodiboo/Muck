using System.Collections.Generic;
using UnityEngine;

public class CauldronSync : Chest
{
    private int fuelCellId;

    private int resultCellId = 5;

    private int[] ingredientCells = new int[4] { 1, 2, 3, 4 };

    private bool processing;

    private float currentProcessTime;

    private float totalProcessTime;

    private float timeToProcess = 1f;

    public float ProgressRatio()
    {
        return currentProcessTime / timeToProcess;
    }

    public override void UpdateCraftables()
    {
        InventoryItem inventoryItem = CanProcess();
        if (!processing && inventoryItem != null)
        {
            ItemFuel fuel = cells[fuelCellId].fuel;
            totalProcessTime = 0f;
            currentProcessTime = 0f;
            timeToProcess = inventoryItem.processTime / fuel.speedMultiplier;
            processing = true;
        }
        if ((bool)CauldronUI.Instance && OtherInput.Instance.currentChest == this)
        {
            CauldronUI.Instance.CopyChest(OtherInput.Instance.currentChest);
            CauldronUI.Instance.processBar.transform.localScale = new Vector3(currentProcessTime / timeToProcess, 1f, 1f);
        }
    }

    private void Update()
    {
        if (!processing)
        {
            return;
        }
        if (!CanProcess())
        {
            StopProcessing();
            return;
        }
        currentProcessTime += Time.deltaTime;
        totalProcessTime += Time.deltaTime;
        if ((bool)CauldronUI.Instance && OtherInput.Instance.currentChest == this)
        {
            CauldronUI.Instance.processBar.transform.localScale = new Vector3(currentProcessTime / timeToProcess, 1f, 1f);
        }
        if (currentProcessTime >= timeToProcess)
        {
            ProcessItem();
            currentProcessTime = 0f;
        }
    }

    private void StopProcessing()
    {
        processing = false;
        if ((bool)CauldronUI.Instance)
        {
            CauldronUI.Instance.processBar.transform.localScale = Vector3.zero;
        }
    }

    public void ProcessItem()
    {
        if (!LocalClient.serverOwner)
        {
            return;
        }
        InventoryItem inventoryItem = CanProcess();
        int[] array = ingredientCells;
        foreach (int num in array)
        {
            if (cells[num] == null)
            {
                continue;
            }
            InventoryItem.CraftRequirement[] requirements = inventoryItem.requirements;
            for (int j = 0; j < requirements.Length; j++)
            {
                if (requirements[j].item.id == cells[num].id)
                {
                    UseMaterial(cells[num], num);
                    break;
                }
            }
        }
        UseFuel(cells[fuelCellId]);
        AddMaterial(cells[resultCellId], inventoryItem.id);
        UpdateCraftables();
        if ((bool)CauldronUI.Instance && OtherInput.Instance.currentChest == this)
        {
            CauldronUI.Instance.CopyChest(OtherInput.Instance.currentChest);
        }
    }

    private void UseMaterial(InventoryItem materialItem, int cellId)
    {
        materialItem.amount--;
        if (materialItem.amount <= 0)
        {
            materialItem = null;
            ClientSend.ChestUpdate(base.id, cellId, -1, 0);
        }
        else
        {
            ClientSend.ChestUpdate(base.id, cellId, materialItem.id, materialItem.amount);
        }
    }

    private void UseFuel(InventoryItem fuelItem)
    {
        ItemFuel fuel = fuelItem.fuel;
        fuel.currentUses--;
        if (fuel.currentUses <= 0)
        {
            fuelItem.amount--;
            fuel.currentUses = fuel.maxUses;
            ClientSend.ChestUpdate(base.id, 0, fuelItem.id, fuelItem.amount);
        }
        if (fuelItem.amount <= 0)
        {
            fuelItem = null;
            ClientSend.ChestUpdate(base.id, 0, -1, 0);
        }
    }

    private void AddMaterial(InventoryItem item, int processedItemId)
    {
        if (cells[resultCellId] == null)
        {
            cells[resultCellId] = Object.Instantiate(ItemManager.Instance.allItems[processedItemId]);
            cells[resultCellId].amount = 1;
        }
        else
        {
            cells[resultCellId].amount++;
        }
        ClientSend.ChestUpdate(base.id, resultCellId, processedItemId, cells[resultCellId].amount);
    }

    public InventoryItem CanProcess()
    {
        if (NoIngredients() || !cells[fuelCellId])
        {
            return null;
        }
        InventoryItem inventoryItem = FindItemByIngredients(ingredientCells);
        if (inventoryItem == null)
        {
            return null;
        }
        if (cells[resultCellId] != null)
        {
            if (inventoryItem.id != cells[resultCellId].id)
            {
                return null;
            }
            if (cells[resultCellId].amount + inventoryItem.craftAmount > cells[resultCellId].max)
            {
                return null;
            }
        }
        if (cells[fuelCellId].tag == InventoryItem.ItemTag.Fuel)
        {
            return inventoryItem;
        }
        return null;
    }

    public InventoryItem FindItemByIngredients(int[] iCells)
    {
        List<InventoryItem> list = new List<InventoryItem>();
        foreach (int num in iCells)
        {
            if (cells[num] != null)
            {
                list.Add(cells[num]);
            }
        }
        InventoryItem[] processableFood = CauldronUI.Instance.processableFood;
        foreach (InventoryItem inventoryItem in processableFood)
        {
            int count = list.Count;
            int num2 = 0;
            if (inventoryItem.requirements.Length != count)
            {
                continue;
            }
            bool flag = false;
            InventoryItem.CraftRequirement[] requirements = inventoryItem.requirements;
            foreach (InventoryItem.CraftRequirement craftRequirement in requirements)
            {
                foreach (InventoryItem item in list)
                {
                    if (item.id == craftRequirement.item.id)
                    {
                        if (item.amount < craftRequirement.amount)
                        {
                            flag = true;
                        }
                        else
                        {
                            num2++;
                        }
                        break;
                    }
                }
            }
            if (!flag && num2 == count)
            {
                return inventoryItem;
            }
        }
        return null;
    }

    private bool NoIngredients()
    {
        int[] array = ingredientCells;
        foreach (int num in array)
        {
            if (cells[num] != null)
            {
                return false;
            }
        }
        return true;
    }
}
