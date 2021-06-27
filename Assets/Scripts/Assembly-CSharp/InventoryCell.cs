using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x020000A1 RID: 161
public class InventoryCell : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
	// Token: 0x060003FE RID: 1022 RVA: 0x0001454D File Offset: 0x0001274D
	private void Start()
	{
		if (this.spawnItem)
		{
			this.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
			this.currentItem.Copy(this.spawnItem, this.spawnItem.amount);
		}
		this.UpdateCell();
	}

	// Token: 0x060003FF RID: 1023 RVA: 0x0001458C File Offset: 0x0001278C
	public void UpdateCell()
	{
		if (this.currentItem == null)
		{
			this.amount.text = "";
			this.itemImage.sprite = null;
			this.itemImage.color = Color.clear;
		}
		else
		{
			this.amount.text = this.currentItem.GetAmount();
			this.itemImage.sprite = this.currentItem.sprite;
			this.itemImage.color = Color.white;
		}
		this.SetColor(this.idle);
	}

	// Token: 0x06000400 RID: 1024 RVA: 0x0001461D File Offset: 0x0001281D
	public void ForceAddItem(InventoryItem item, int amount)
	{
		this.currentItem = Instantiate<InventoryItem>(item);
		this.currentItem.amount = amount;
		this.UpdateCell();
	}

	// Token: 0x06000401 RID: 1025 RVA: 0x00014640 File Offset: 0x00012840
	public InventoryItem SetItem(InventoryItem pointerItem, PointerEventData eventData)
	{
		InventoryItem inventoryItem = this.currentItem;
		int num = pointerItem.amount;
		if (eventData.button == PointerEventData.InputButton.Right)
		{
			num = 1;
		}
		InventoryItem inventoryItem2;
		InventoryItem inventoryItem3;
		if (inventoryItem == null)
		{
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(pointerItem, num);
			if (pointerItem.amount - num < 1)
			{
				inventoryItem3 = null;
			}
			else
			{
				inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
				inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
			}
		}
		else if (pointerItem.Compare(inventoryItem) && pointerItem.stackable)
		{
			if (inventoryItem.amount + num > inventoryItem.max)
			{
				num = inventoryItem.max - inventoryItem.amount;
			}
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(this.currentItem, this.currentItem.amount + num);
			if (pointerItem.amount - num < 1)
			{
				inventoryItem3 = null;
			}
			else
			{
				inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
				inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
			}
		}
		else
		{
			inventoryItem2 = pointerItem;
			inventoryItem3 = inventoryItem;
		}
		this.currentItem = inventoryItem2;
		this.UpdateCell();
		UiEvents.Instance.PlaceInInventory(this.currentItem);
		if (this.cellType == InventoryCell.CellType.Chest)
		{
			MonoBehaviour.print("sending chest updates, currentchest:  " + OtherInput.Instance.currentChest.id);
			int itemId = -1;
			int num2 = 0;
			if (this.currentItem)
			{
				itemId = this.currentItem.id;
				num2 = this.currentItem.amount;
			}
			ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num2);
			Invoke(nameof(GetReady), (float)(NetStatus.GetPing() * 3) * 0.01f);
		}
		return inventoryItem3;
	}

	// Token: 0x06000402 RID: 1026 RVA: 0x000147CF File Offset: 0x000129CF
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000403 RID: 1027 RVA: 0x000147D8 File Offset: 0x000129D8
	public InventoryItem PickupItem(PointerEventData eventData)
	{
		if (!this.currentItem)
		{
			return null;
		}
		InventoryItem inventoryItem;
		InventoryItem inventoryItem2;
		if (eventData.button == PointerEventData.InputButton.Right && this.currentItem.amount > 1)
		{
			int num = this.currentItem.amount / 2;
			int num2 = this.currentItem.amount - num;
			inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem.Copy(this.currentItem, num);
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(this.currentItem, num2);
		}
		else
		{
			inventoryItem = null;
			inventoryItem2 = this.currentItem;
		}
		this.currentItem = inventoryItem;
		this.UpdateCell();
		if (this.cellType == InventoryCell.CellType.Chest)
		{
			int itemId = -1;
			int num3 = 0;
			if (this.currentItem)
			{
				itemId = this.currentItem.id;
				num3 = this.currentItem.amount;
			}
			float time = 1f;
			Invoke(nameof(GetReady), time);
			ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num3);
		}
		return inventoryItem2;
	}

	// Token: 0x06000404 RID: 1028 RVA: 0x000148D0 File Offset: 0x00012AD0
	public void OnPointerDown(PointerEventData eventData)
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		Invoke(nameof(GetReady), Time.deltaTime * 2f);
		if (this.cellType == InventoryCell.CellType.Crafting)
		{
			InventoryUI.Instance.CraftItem(this.currentItem);
			return;
		}
		if (Time.time - this.lastClickTime < 0.25f && eventData.button == PointerEventData.InputButton.Left && InventoryUI.Instance.HoldingItem())
		{
			this.DoubleClick();
			return;
		}
		if (Input.GetKey(KeyCode.LeftShift))
		{
			this.ShiftClick();
			return;
		}
		if (InventoryUI.Instance.HoldingItem())
		{
			if (this.IsItemCompatibleWithCell(InventoryUI.Instance.currentMouseItem))
			{
				InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
				InventoryUI.Instance.PlaceItem(this.SetItem(currentMouseItem, eventData));
			}
		}
		else
		{
			InventoryUI.Instance.PickupItem(this.PickupItem(eventData));
		}
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			this.lastClickTime = Time.time;
		}
	}

	// Token: 0x06000405 RID: 1029 RVA: 0x000149C0 File Offset: 0x00012BC0
	private bool IsItemCompatibleWithCell(InventoryItem item)
	{
		if (this.tags.Length == 0)
		{
			return true;
		}
		foreach (InventoryItem.ItemTag itemTag in this.tags)
		{
			if (item.tag == itemTag)
			{
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000406 RID: 1030 RVA: 0x000149FD File Offset: 0x00012BFD
	public void RemoveItem()
	{
		this.currentItem = null;
		this.UpdateCell();
	}

	// Token: 0x06000407 RID: 1031 RVA: 0x00014A0C File Offset: 0x00012C0C
	private void DoubleClick()
	{
		InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
		if (!currentMouseItem.stackable)
		{
			return;
		}
		foreach (InventoryCell inventoryCell in InventoryUI.Instance.cells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(currentMouseItem))
			{
				if (currentMouseItem.amount + inventoryCell.currentItem.amount > currentMouseItem.max)
				{
					int num = currentMouseItem.max - currentMouseItem.amount;
					currentMouseItem.amount += num;
					inventoryCell.currentItem.amount -= num;
					inventoryCell.UpdateCell();
					InventoryUI.Instance.PickupItem(currentMouseItem);
					return;
				}
				currentMouseItem.amount += inventoryCell.currentItem.amount;
				inventoryCell.RemoveItem();
			}
		}
		InventoryUI.Instance.PickupItem(currentMouseItem);
	}

	// Token: 0x06000408 RID: 1032 RVA: 0x00014B1C File Offset: 0x00012D1C
	private bool ShiftClick()
	{
		if (this.cellType != InventoryCell.CellType.Chest)
		{
			if (this.cellType == InventoryCell.CellType.Inventory)
			{
				OtherInput.CraftingState craftingState = OtherInput.Instance.craftingState;
				OtherInput.CraftingState craftingState2 = OtherInput.Instance.craftingState;
				OtherInput.CraftingState craftingState3 = OtherInput.Instance.craftingState;
			}
			return false;
		}
		if (!InventoryUI.Instance.CanPickup(this.currentItem))
		{
			return false;
		}
		InventoryUI.Instance.AddItemToInventory(this.currentItem);
		this.RemoveItem();
		int itemId = -1;
		int num = 0;
		if (this.currentItem)
		{
			itemId = this.currentItem.id;
			num = this.currentItem.amount;
		}
		ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num);
		return true;
	}

	// Token: 0x06000409 RID: 1033 RVA: 0x00014BD4 File Offset: 0x00012DD4
	public void OnPointerEnter(PointerEventData eventData)
	{
		this.SetColor(this.hover);
		if (this.currentItem)
		{
			if (this.cellType == InventoryCell.CellType.Inventory || this.cellType == InventoryCell.CellType.Chest)
			{
				string text = this.currentItem.name + "\n<size=50%><i>" + this.currentItem.description;
				if (this.currentItem.IsArmour())
				{
					text = string.Concat(new object[]
					{
						text,
						"\n+",
						this.currentItem.armor,
						" armor"
					});
					text = text + "\n" + this.currentItem.armorComponent.setBonus;
				}
				ItemInfo.Instance.SetText(text, false);
				return;
			}
			if (this.cellType == InventoryCell.CellType.Crafting)
			{
				string text2 = this.currentItem.name + "<size=60%>";
				foreach (InventoryItem.CraftRequirement craftRequirement in this.currentItem.requirements)
				{
					text2 = string.Concat(new object[]
					{
						text2,
						"\n",
						craftRequirement.item.name,
						" - ",
						craftRequirement.amount
					});
				}
				ItemInfo.Instance.SetText(text2, false);
			}
		}
	}

	// Token: 0x0600040A RID: 1034 RVA: 0x00014D23 File Offset: 0x00012F23
	public void Eat(int amount)
	{
		this.currentItem.amount -= amount;
		if (this.currentItem.amount <= 0)
		{
			this.RemoveItem();
		}
		this.UpdateCell();
	}

	// Token: 0x0600040B RID: 1035 RVA: 0x00014D52 File Offset: 0x00012F52
	public void OnPointerExit(PointerEventData eventData)
	{
		this.SetColor(this.idle);
		ItemInfo.Instance.Fade(0f, 0.2f);
	}

	// Token: 0x0600040C RID: 1036 RVA: 0x000030D7 File Offset: 0x000012D7
	public void SetColor(Color c)
	{
	}

	// Token: 0x0600040D RID: 1037 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AddItemToChest(InventoryItem item)
	{
	}

	// Token: 0x0600040E RID: 1038 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AddItemToCauldron()
	{
	}

	// Token: 0x0600040F RID: 1039 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AddItemToFurnace()
	{
	}

	// Token: 0x06000410 RID: 1040 RVA: 0x00014D74 File Offset: 0x00012F74
	public void SetOverlayAlpha(float f)
	{
		MonoBehaviour.print("overlay set to: " + f);
		this.overlay.color = new Color(0f, 0f, 0f, f);
	}

	// Token: 0x040003C5 RID: 965
	public InventoryCell.CellType cellType;

	// Token: 0x040003C6 RID: 966
	public TextMeshProUGUI amount;

	// Token: 0x040003C7 RID: 967
	public Image itemImage;

	// Token: 0x040003C8 RID: 968
	public RawImage slot;

	// Token: 0x040003C9 RID: 969
	[HideInInspector]
	public InventoryItem currentItem;

	// Token: 0x040003CA RID: 970
	public InventoryItem spawnItem;

	// Token: 0x040003CB RID: 971
	public int cellId;

	// Token: 0x040003CC RID: 972
	public Color idle;

	// Token: 0x040003CD RID: 973
	public Color hover;

	// Token: 0x040003CE RID: 974
	private bool ready = true;

	// Token: 0x040003CF RID: 975
	private float lastClickTime;

	// Token: 0x040003D0 RID: 976
	private float doubleClickThreshold = 0.15f;

	// Token: 0x040003D1 RID: 977
	public InventoryItem.ItemTag[] tags;

	// Token: 0x040003D2 RID: 978
	public RawImage overlay;

	// Token: 0x02000150 RID: 336
	public enum CellType
	{
		// Token: 0x040008C3 RID: 2243
		Inventory,
		// Token: 0x040008C4 RID: 2244
		Crafting,
		// Token: 0x040008C5 RID: 2245
		Chest
	}
}
