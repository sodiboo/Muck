using UnityEngine;
using UnityEngine.UI;

public class FurnaceUI : InventoryExtensions
{
    public InventoryCell metalCell;

    public InventoryCell fuelCell;

    public InventoryCell resultCell;

    public InventoryItem.ProcessType processType;

    private bool processing;

    private float currentProcessTime;

    private float totalProcessTime;

    private float timeToProcess;

    public RawImage processBar;

    private InventoryItem currentFuel;

    private InventoryItem currentMetal;

    public static FurnaceUI Instance;

    private float closedTime;

    private float closedProgress;

    public InventoryCell[] synchedCells;

    private void Awake()
    {
        Instance = this;
        base.gameObject.SetActive(value: false);
    }

    public override void UpdateCraftables()
    {
    }

    private void StartProcessing()
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

    public void CopyChest(Chest c)
    {
        if (!base.gameObject.activeInHierarchy)
        {
            return;
        }
        InventoryItem[] cells = OtherInput.Instance.currentChest.cells;
        for (int i = 0; i < cells.Length; i++)
        {
            if (c.locked[i])
            {
                synchedCells[i].enabled = false;
            }
            else
            {
                synchedCells[i].enabled = true;
            }
            if (i < synchedCells.Length)
            {
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
        processBar.transform.localScale = new Vector3(((FurnaceSync)OtherInput.Instance.currentChest).ProgressRatio(), 1f, 1f);
    }

    private void AddMaterial(InventoryCell cell, int processedItemId)
    {
    }

    public bool CanProcess()
    {
        return false;
    }
}
