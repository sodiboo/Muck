using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200001D RID: 29
public class CraftingUI : InventoryExtensions
{
	// Token: 0x060000AB RID: 171 RVA: 0x00005394 File Offset: 0x00003594
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

	// Token: 0x060000AC RID: 172 RVA: 0x00005415 File Offset: 0x00003615
	private void Start()
	{
		this.UpdateCraftables();
		this.UpdateTabs();
	}

	// Token: 0x060000AD RID: 173 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnEnable()
	{
	}

	// Token: 0x060000AE RID: 174 RVA: 0x00005423 File Offset: 0x00003623
	public void OpenTab(int i)
	{
		this.tabSelected = i;
		this.UpdateTabs();
		this.UpdateCraftables();
	}

	// Token: 0x060000AF RID: 175 RVA: 0x00005438 File Offset: 0x00003638
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

	// Token: 0x060000B0 RID: 176 RVA: 0x000054B8 File Offset: 0x000036B8
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

	// Token: 0x040000AF RID: 175
	public int nCells;

	// Token: 0x040000B0 RID: 176
	public RectTransform cellsParent;

	// Token: 0x040000B1 RID: 177
	public RectTransform cellsParentParent;

	// Token: 0x040000B2 RID: 178
	public RectTransform cellsParentParentParent;

	// Token: 0x040000B3 RID: 179
	private Rect rect;

	// Token: 0x040000B4 RID: 180
	public GameObject cellPrefab;

	// Token: 0x040000B5 RID: 181
	public GameObject requirementPrefab;

	// Token: 0x040000B6 RID: 182
	private List<InventoryCell> cells = new List<InventoryCell>();

	// Token: 0x040000B7 RID: 183
	private int tabSelected;

	// Token: 0x040000B8 RID: 184
	public CraftingUI.Tab[] tabs;

	// Token: 0x040000B9 RID: 185
	public Transform tabParent;

	// Token: 0x040000BA RID: 186
	private RawImage[] tabImgs;

	// Token: 0x040000BB RID: 187
	private TextMeshProUGUI[] tabTexts;

	// Token: 0x040000BC RID: 188
	public Color selectedTabColor;

	// Token: 0x040000BD RID: 189
	public Color unselectedTabColor;

	// Token: 0x040000BE RID: 190
	public Color selectedTextColor;

	// Token: 0x040000BF RID: 191
	public Color unselectedTextColor;

	// Token: 0x040000C0 RID: 192
	public bool handCrafts;

	// Token: 0x02000140 RID: 320
	[Serializable]
	public class Tab
	{
		// Token: 0x04000887 RID: 2183
		public InventoryItem[] items;
	}
}
