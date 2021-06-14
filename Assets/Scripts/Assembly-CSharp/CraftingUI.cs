using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000018 RID: 24
public class CraftingUI : InventoryExtensions
{
	// Token: 0x06000078 RID: 120 RVA: 0x00009320 File Offset: 0x00007520
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

	// Token: 0x06000079 RID: 121 RVA: 0x00002524 File Offset: 0x00000724
	private void Start()
	{
		this.UpdateCraftables();
		this.UpdateTabs();
	}

	// Token: 0x0600007A RID: 122 RVA: 0x00002147 File Offset: 0x00000347
	private void OnEnable()
	{
	}

	// Token: 0x0600007B RID: 123 RVA: 0x00002532 File Offset: 0x00000732
	public void OpenTab(int i)
	{
		this.tabSelected = i;
		this.UpdateTabs();
		this.UpdateCraftables();
	}

	// Token: 0x0600007C RID: 124 RVA: 0x000093A4 File Offset: 0x000075A4
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

	// Token: 0x0600007D RID: 125 RVA: 0x00009424 File Offset: 0x00007624
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
				InventoryCell component =Instantiate<GameObject>(this.cellPrefab, this.cellsParent).GetComponent<InventoryCell>();
				component.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
				component.currentItem.Copy(inventoryItem, 1);
				component.cellType = InventoryCell.CellType.Crafting;
				foreach (InventoryItem.CraftRequirement craftRequirement in component.currentItem.requirements)
				{
					GameObject gameObject =Instantiate<GameObject>(this.requirementPrefab);
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

	// Token: 0x0400007A RID: 122
	public int nCells;

	// Token: 0x0400007B RID: 123
	public RectTransform cellsParent;

	// Token: 0x0400007C RID: 124
	public RectTransform cellsParentParent;

	// Token: 0x0400007D RID: 125
	public RectTransform cellsParentParentParent;

	// Token: 0x0400007E RID: 126
	private Rect rect;

	// Token: 0x0400007F RID: 127
	public GameObject cellPrefab;

	// Token: 0x04000080 RID: 128
	public GameObject requirementPrefab;

	// Token: 0x04000081 RID: 129
	private List<InventoryCell> cells = new List<InventoryCell>();

	// Token: 0x04000082 RID: 130
	private int tabSelected;

	// Token: 0x04000083 RID: 131
	public CraftingUI.Tab[] tabs;

	// Token: 0x04000084 RID: 132
	public Transform tabParent;

	// Token: 0x04000085 RID: 133
	private RawImage[] tabImgs;

	// Token: 0x04000086 RID: 134
	private TextMeshProUGUI[] tabTexts;

	// Token: 0x04000087 RID: 135
	public Color selectedTabColor;

	// Token: 0x04000088 RID: 136
	public Color unselectedTabColor;

	// Token: 0x04000089 RID: 137
	public Color selectedTextColor;

	// Token: 0x0400008A RID: 138
	public Color unselectedTextColor;

	// Token: 0x0400008B RID: 139
	public bool handCrafts;

	// Token: 0x02000019 RID: 25
	[Serializable]
	public class Tab
	{
		// Token: 0x0400008C RID: 140
		public InventoryItem[] items;
	}
}
