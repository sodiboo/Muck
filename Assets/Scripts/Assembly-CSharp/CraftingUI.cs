using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000015 RID: 21
public class CraftingUI : InventoryExtensions
{
	// Token: 0x06000071 RID: 113 RVA: 0x000045A4 File Offset: 0x000027A4
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

	// Token: 0x06000072 RID: 114 RVA: 0x00004625 File Offset: 0x00002825
	private void Start()
	{
		this.UpdateCraftables();
		this.UpdateTabs();
	}

	// Token: 0x06000073 RID: 115 RVA: 0x0000276E File Offset: 0x0000096E
	private void OnEnable()
	{
	}

	// Token: 0x06000074 RID: 116 RVA: 0x00004633 File Offset: 0x00002833
	public void OpenTab(int i)
	{
		this.tabSelected = i;
		this.UpdateTabs();
		this.UpdateCraftables();
	}

	// Token: 0x06000075 RID: 117 RVA: 0x00004648 File Offset: 0x00002848
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

	// Token: 0x06000076 RID: 118 RVA: 0x000046C8 File Offset: 0x000028C8
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

	// Token: 0x0400006C RID: 108
	public int nCells;

	// Token: 0x0400006D RID: 109
	public RectTransform cellsParent;

	// Token: 0x0400006E RID: 110
	public RectTransform cellsParentParent;

	// Token: 0x0400006F RID: 111
	public RectTransform cellsParentParentParent;

	// Token: 0x04000070 RID: 112
	private Rect rect;

	// Token: 0x04000071 RID: 113
	public GameObject cellPrefab;

	// Token: 0x04000072 RID: 114
	public GameObject requirementPrefab;

	// Token: 0x04000073 RID: 115
	private List<InventoryCell> cells = new List<InventoryCell>();

	// Token: 0x04000074 RID: 116
	private int tabSelected;

	// Token: 0x04000075 RID: 117
	public CraftingUI.Tab[] tabs;

	// Token: 0x04000076 RID: 118
	public Transform tabParent;

	// Token: 0x04000077 RID: 119
	private RawImage[] tabImgs;

	// Token: 0x04000078 RID: 120
	private TextMeshProUGUI[] tabTexts;

	// Token: 0x04000079 RID: 121
	public Color selectedTabColor;

	// Token: 0x0400007A RID: 122
	public Color unselectedTabColor;

	// Token: 0x0400007B RID: 123
	public Color selectedTextColor;

	// Token: 0x0400007C RID: 124
	public Color unselectedTextColor;

	// Token: 0x0400007D RID: 125
	public bool handCrafts;

	// Token: 0x02000109 RID: 265
	[Serializable]
	public class Tab
	{
		// Token: 0x04000729 RID: 1833
		public InventoryItem[] items;
	}
}
