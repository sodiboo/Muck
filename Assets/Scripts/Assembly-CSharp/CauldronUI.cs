using UnityEngine;
using UnityEngine.UI;

public class CauldronUI : InventoryExtensions
{
    public InventoryCell[] ingredientCells;

    public InventoryCell fuelCell;

    public InventoryCell resultCell;

    public InventoryItem.ProcessType processType;

    public InventoryItem[] processableFood;

    private bool processing;

    private float currentProcessTime;

    private float totalProcessTime;

    private float timeToProcess;

    public RawImage processBar;

    public static CauldronUI Instance;

    public InventoryCell[] synchedCells;

    private float closedTime;

    private float closedProgress;

    private void Awake()
    {
        Instance = this;
        base.gameObject.SetActive(value: false);
    }

    public void CopyChest(Chest c)
    {
        if (!base.gameObject.activeInHierarchy)
        {
            return;
        }
        InventoryItem[] cells = OtherInput.Instance.currentChest.cells;
        for (int i = 0; i < cells.Length; i++)
        {
            if (i < synchedCells.Length)
            {
                if (c.locked[i])
                {
                    synchedCells[i].enabled = false;
                }
                else
                {
                    synchedCells[i].enabled = true;
                }
                if (cells[i] != null)
                {
                    synchedCells[i].currentItem = Object.Instantiate(cells[i]);
                }
                else
                {
                    synchedCells[i].currentItem = null;
                }
                synchedCells[i].UpdateCell();
            }
        }
        processBar.transform.localScale = new Vector3(((CauldronSync)OtherInput.Instance.currentChest).ProgressRatio(), 1f, 1f);
    }

    public override void UpdateCraftables()
    {
    }

    private void OnDisable()
    {
    }

    private void OnEnable()
    {
    }

    private void Update()
    {
    }

    private void StopProcessing()
    {
    }

    public void ProcessItem()
    {
    }

    private void UseMaterial(InventoryCell cell)
    {
    }

    private void UseFuel(InventoryCell cell)
    {
    }

    private void AddMaterial(InventoryCell cell, InventoryItem processedItem)
    {
    }

    public InventoryItem CanProcess()
    {
        return null;
    }

    public InventoryItem FindItemByIngredients(InventoryCell[] iCells)
    {
        return null;
    }

    private bool NoIngredients()
    {
        return false;
    }
}
