using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;
using TMPro;

public class InventoryUI : MonoBehaviour
{
	public Transform inventoryParent;
	public Transform hotkeysTransform;
	public Transform armorTransform;
	public Transform leftTransform;
	public InventoryCell[] armorCells;
	public InventoryCell[] hotkeyCells;
	public InventoryCell[] allCells;
	public InventoryCell leftHand;
	public InventoryCell arrows;
	public Hotbar hotbar;
	public List<InventoryCell> cells;
	public InventoryItem currentMouseItem;
	public Image mouseItemSprite;
	public TextMeshProUGUI mouseItemText;
	public GameObject backDrop;
	public InventoryExtensions CraftingUi;
}
