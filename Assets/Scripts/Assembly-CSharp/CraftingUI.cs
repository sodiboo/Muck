using System;
using UnityEngine;

public class CraftingUI : InventoryExtensions
{
	[Serializable]
	public class Tab
	{
		public InventoryItem[] items;
	}

	public int nCells;
	public RectTransform cellsParent;
	public RectTransform cellsParentParent;
	public RectTransform cellsParentParentParent;
	public GameObject cellPrefab;
	public GameObject requirementPrefab;
	public Tab[] tabs;
	public Transform tabParent;
	public Color selectedTabColor;
	public Color unselectedTabColor;
	public Color selectedTextColor;
	public Color unselectedTextColor;
	public bool handCrafts;
}
