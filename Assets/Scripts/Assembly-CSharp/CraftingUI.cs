using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

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

    private Rect rect;

    public GameObject cellPrefab;

    public GameObject requirementPrefab;

    private List<InventoryCell> cells = new List<InventoryCell>();

    private int tabSelected;

    public Tab[] tabs;

    public Transform tabParent;

    private RawImage[] tabImgs;

    private TextMeshProUGUI[] tabTexts;

    public Color selectedTabColor;

    public Color unselectedTabColor;

    public Color selectedTextColor;

    public Color unselectedTextColor;

    public bool handCrafts;

    private void Awake()
    {
        if (!handCrafts)
        {
            tabImgs = new RawImage[tabs.Length];
            tabTexts = new TextMeshProUGUI[tabs.Length];
            for (int i = 0; i < tabs.Length; i++)
            {
                tabImgs[i] = tabParent.GetChild(i).GetComponent<RawImage>();
                tabTexts[i] = tabParent.GetChild(i).GetComponentInChildren<TextMeshProUGUI>();
            }
        }
    }

    private void Start()
    {
        UpdateCraftables();
        UpdateTabs();
    }

    private void OnEnable()
    {
    }

    public void OpenTab(int i)
    {
        tabSelected = i;
        UpdateTabs();
        UpdateCraftables();
    }

    private void UpdateTabs()
    {
        if (tabImgs == null)
        {
            return;
        }
        for (int i = 0; i < tabs.Length; i++)
        {
            if (i == tabSelected)
            {
                tabImgs[i].color = selectedTabColor;
                tabTexts[i].color = selectedTextColor;
            }
            else
            {
                tabImgs[i].color = unselectedTabColor;
                tabTexts[i].color = unselectedTextColor;
            }
        }
    }

    public override void UpdateCraftables()
    {
        for (int i = 0; i < cells.Count; i++)
        {
            if ((bool)cells[i].gameObject)
            {
                UnityEngine.Object.Destroy(cells[i].gameObject);
            }
        }
        cells = new List<InventoryCell>();
        InventoryItem[] items = tabs[tabSelected].items;
        foreach (InventoryItem inventoryItem in items)
        {
            if (UiEvents.Instance.IsSoftUnlocked(inventoryItem.id))
            {
                InventoryCell component = UnityEngine.Object.Instantiate(cellPrefab, cellsParent).GetComponent<InventoryCell>();
                component.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
                component.currentItem.Copy(inventoryItem, 1);
                component.cellType = InventoryCell.CellType.Crafting;
                InventoryItem.CraftRequirement[] requirements = component.currentItem.requirements;
                foreach (InventoryItem.CraftRequirement craftRequirement in requirements)
                {
                    GameObject obj = UnityEngine.Object.Instantiate(requirementPrefab);
                    obj.GetComponent<Image>().sprite = craftRequirement.item.sprite;
                    obj.transform.SetParent(component.transform.GetChild(component.transform.childCount - 2));
                }
                cells.Add(component);
                component.SetColor(component.idle);
                if (!InventoryUI.Instance.IsCraftable(inventoryItem))
                {
                    component.SetOverlayAlpha(0.6f);
                }
            }
        }
        if (handCrafts)
        {
            nCells = cells.Count;
        }
    }
}
