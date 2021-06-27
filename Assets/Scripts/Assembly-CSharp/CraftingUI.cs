using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CraftingUI : InventoryExtensions
{
	private void Awake()
	{
		if (this.handCrafts)
		{
			return;
		}
		this.tabImgs = new RawImage[this.tabs.Length];
		this.tabTexts = new TextMeshProUGUI[this.tabs.Length];
		for (int i = 0; i < this.tabs.Length; i++)
		{
			this.tabImgs[i] = this.tabParent.GetChild(i).GetComponent<RawImage>();
			this.tabTexts[i] = this.tabParent.GetChild(i).GetComponentInChildren<TextMeshProUGUI>();
		}
	}

	private void Start()
	{
		this.UpdateCraftables();
		this.UpdateTabs();
	}

	private void OnEnable()
	{
	}

	public void OpenTab(int i)
	{
		this.tabSelected = i;
		this.UpdateTabs();
		this.UpdateCraftables();
	}

	private void UpdateTabs()
	{
		if (this.tabImgs == null)
		{
			return;
		}
		for (int i = 0; i < this.tabs.Length; i++)
		{
			if (i == this.tabSelected)
			{
				this.tabImgs[i].color = this.selectedTabColor;
				this.tabTexts[i].color = this.selectedTextColor;
			}
			else
			{
				this.tabImgs[i].color = this.unselectedTabColor;
				this.tabTexts[i].color = this.unselectedTextColor;
			}
		}
	}

	public override void UpdateCraftables()
	{
		for (int i = 0; i < this.cells.Count; i++)
		{
			if (this.cells[i].gameObject)
			{
				Destroy(this.cells[i].gameObject);
			}
		}
		this.cells = new List<InventoryCell>();
		foreach (InventoryItem inventoryItem in this.tabs[this.tabSelected].items)
		{
			if (UiEvents.Instance.IsSoftUnlocked(inventoryItem.id))
			{
				InventoryCell component = Instantiate<GameObject>(this.cellPrefab, this.cellsParent).GetComponent<InventoryCell>();
				component.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
				component.currentItem.Copy(inventoryItem, 1);
				component.cellType = InventoryCell.CellType.Crafting;
				foreach (InventoryItem.CraftRequirement craftRequirement in component.currentItem.requirements)
				{
					GameObject gameObject = Instantiate<GameObject>(this.requirementPrefab);
					gameObject.GetComponent<Image>().sprite = craftRequirement.item.sprite;
					gameObject.transform.SetParent(component.transform.GetChild(component.transform.childCount - 2));
				}
				this.cells.Add(component);
				component.SetColor(component.idle);
				if (!InventoryUI.Instance.IsCraftable(inventoryItem))
				{
					component.SetOverlayAlpha(0.6f);
				}
			}
		}
		if (this.handCrafts)
		{
			this.nCells = this.cells.Count;
		}
	}

	public int nCells;

	public RectTransform cellsParent;

	public RectTransform cellsParentParent;

	public RectTransform cellsParentParentParent;

	private Rect rect;

	public GameObject cellPrefab;

	public GameObject requirementPrefab;

	private List<InventoryCell> cells = new List<InventoryCell>();

	private int tabSelected;

	public CraftingUI.Tab[] tabs;

	public Transform tabParent;

	private RawImage[] tabImgs;

	private TextMeshProUGUI[] tabTexts;

	public Color selectedTabColor;

	public Color unselectedTabColor;

	public Color selectedTextColor;

	public Color unselectedTextColor;

	public bool handCrafts;

	[Serializable]
	public class Tab
	{
		public InventoryItem[] items;
	}
}
