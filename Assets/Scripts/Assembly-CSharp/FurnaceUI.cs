using System;
using UnityEngine;
using UnityEngine.UI;

public class FurnaceUI : InventoryExtensions
{
	private void Awake()
	{
		FurnaceUI.Instance = this;
		base.gameObject.SetActive(false);
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
				this.synchedCells[i].enabled = false;
			}
			else
			{
				this.synchedCells[i].enabled = true;
			}
			if (i < this.synchedCells.Length)
			{
				if (cells[i] != null)
				{
					this.synchedCells[i].currentItem = Instantiate<InventoryItem>(cells[i]);
				}
				else
				{
					this.synchedCells[i].currentItem = null;
				}
				this.synchedCells[i].UpdateCell();
			}
		}
		this.processBar.transform.localScale = new Vector3(((FurnaceSync)OtherInput.Instance.currentChest).ProgressRatio(), 1f, 1f);
	}

	private void AddMaterial(InventoryCell cell, int processedItemId)
	{
	}

	public bool CanProcess()
	{
		return false;
	}

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
}
