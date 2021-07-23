using UnityEngine;

public class FurnaceSync : Chest
{
    public InventoryItem.ProcessType processType;

    private bool processing;

    private float currentProcessTime;

    private float totalProcessTime;

    private float timeToProcess = 1f;

    private InventoryItem currentFuel;

    private InventoryItem currentMetal;

    public float ProgressRatio()
    {
        return currentProcessTime / timeToProcess;
    }

    public override void UpdateCraftables()
    {
        if (processing && CanProcess() && (currentFuel.id != cells[0].id || currentMetal.id != cells[1].id))
        {
            StartProcessing();
        }
        if (!processing && CanProcess())
        {
            StartProcessing();
        }
        if (FurnaceUI.Instance != null && OtherInput.Instance.currentChest == this)
        {
            FurnaceUI.Instance.CopyChest(OtherInput.Instance.currentChest);
            FurnaceUI.Instance.processBar.transform.localScale = new Vector3(currentProcessTime / timeToProcess, 1f, 1f);
        }
    }

    private void StartProcessing()
    {
        currentFuel = cells[0];
        currentMetal = cells[1];
        ItemFuel fuel = currentFuel.fuel;
        totalProcessTime = 0f;
        currentProcessTime = 0f;
        timeToProcess = currentMetal.processTime / fuel.speedMultiplier;
        processing = true;
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
            MonoBehaviour.print("stopped due to one of these conditions");
            return;
        }
        currentProcessTime += Time.deltaTime;
        totalProcessTime += Time.deltaTime;
        if ((bool)FurnaceUI.Instance && OtherInput.Instance.currentChest == this)
        {
            FurnaceUI.Instance.processBar.transform.localScale = new Vector3(currentProcessTime / timeToProcess, 1f, 1f);
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
        if ((bool)FurnaceUI.Instance)
        {
            FurnaceUI.Instance.processBar.transform.localScale = Vector3.zero;
        }
    }

    public void ProcessItem()
    {
        if (LocalClient.serverOwner)
        {
            int processedItemId = cells[1].processedItem.id;
            UseMaterial(cells[1]);
            UseFuel(cells[0]);
            AddMaterial(cells[2], processedItemId);
            UpdateCraftables();
        }
    }

    private void UseMaterial(InventoryItem materialItem)
    {
        materialItem.amount--;
        if (materialItem.amount <= 0)
        {
            materialItem = null;
            ClientSend.ChestUpdate(base.id, 1, -1, 0);
        }
        else
        {
            ClientSend.ChestUpdate(base.id, 1, materialItem.id, materialItem.amount);
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
        if (cells[2] == null)
        {
            cells[2] = Object.Instantiate(ItemManager.Instance.allItems[processedItemId]);
            cells[2].amount = 1;
        }
        else
        {
            cells[2].amount++;
        }
        ClientSend.ChestUpdate(base.id, 2, processedItemId, cells[2].amount);
    }

    public bool CanProcess()
    {
        if (!cells[1] || !cells[0])
        {
            return false;
        }
        if (cells[2] != null)
        {
            if (cells[1].processedItem == null || cells[1].processedItem.id != cells[2].id)
            {
                return false;
            }
            if (cells[2].amount >= cells[2].max)
            {
                return false;
            }
        }
        if (cells[1].processable && cells[1].processType == processType && cells[0].tag == InventoryItem.ItemTag.Fuel)
        {
            return true;
        }
        return false;
    }
}
