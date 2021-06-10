
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x0200007B RID: 123
public class InventoryCell : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
	// Token: 0x0600031E RID: 798 RVA: 0x0000FD05 File Offset: 0x0000DF05
	private void Start()
	{
		if (this.spawnItem)
		{
			this.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
			this.currentItem.Copy(this.spawnItem, this.spawnItem.amount);
		}
		this.UpdateCell();
	}

	// Token: 0x0600031F RID: 799 RVA: 0x0000FD44 File Offset: 0x0000DF44
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

	// Token: 0x06000320 RID: 800 RVA: 0x0000FDD5 File Offset: 0x0000DFD5
	public void ForceAddItem(InventoryItem item, int amount)
	{
		this.currentItem =Instantiate<InventoryItem>(item);
		this.currentItem.amount = amount;
		this.UpdateCell();
	}

	// Token: 0x06000321 RID: 801 RVA: 0x0000FDF8 File Offset: 0x0000DFF8
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
			base.Invoke("GetReady", (float)(NetStatus.GetPing() * 3) * 0.01f);
		}
		return inventoryItem3;
	}

	// Token: 0x06000322 RID: 802 RVA: 0x0000FF87 File Offset: 0x0000E187
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000323 RID: 803 RVA: 0x0000FF90 File Offset: 0x0000E190
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
			base.Invoke("GetReady", time);
			ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num3);
		}
		return inventoryItem2;
	}

	// Token: 0x06000324 RID: 804 RVA: 0x00010088 File Offset: 0x0000E288
	public void OnPointerDown(PointerEventData eventData)
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		base.Invoke("GetReady", Time.deltaTime * 2f);
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

	// Token: 0x06000325 RID: 805 RVA: 0x00010178 File Offset: 0x0000E378
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

	// Token: 0x06000326 RID: 806 RVA: 0x000101B5 File Offset: 0x0000E3B5
	public void RemoveItem()
	{
		this.currentItem = null;
		this.UpdateCell();
	}

	// Token: 0x06000327 RID: 807 RVA: 0x000101C4 File Offset: 0x0000E3C4
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

	// Token: 0x06000328 RID: 808 RVA: 0x000102D4 File Offset: 0x0000E4D4
	private bool ShiftClick()
	{
		if (this.cellType != InventoryCell.CellType.Chest)
		{
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

	// Token: 0x06000329 RID: 809 RVA: 0x00010360 File Offset: 0x0000E560
	public void OnPointerEnter(PointerEventData eventData)
	{
		this.SetColor(this.hover);
		if (this.currentItem)
		{
			if (this.cellType == InventoryCell.CellType.Inventory)
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

	// Token: 0x0600032A RID: 810 RVA: 0x00010487 File Offset: 0x0000E687
	public void Eat(int amount)
	{
		this.currentItem.amount -= amount;
		if (this.currentItem.amount <= 0)
		{
			this.RemoveItem();
		}
		this.UpdateCell();
	}

	// Token: 0x0600032B RID: 811 RVA: 0x000104B6 File Offset: 0x0000E6B6
	public void OnPointerExit(PointerEventData eventData)
	{
		this.SetColor(this.idle);
		ItemInfo.Instance.Fade(0f, 0.2f);
	}

	// Token: 0x0600032C RID: 812 RVA: 0x0000276E File Offset: 0x0000096E
	public void SetColor(Color c)
	{
	}

	// Token: 0x0600032D RID: 813 RVA: 0x000104D8 File Offset: 0x0000E6D8
	public void SetOverlayAlpha(float f)
	{
		MonoBehaviour.print("overlay set to: " + f);
		this.overlay.color = new Color(0f, 0f, 0f, f);
	}

	// Token: 0x040002CD RID: 717
	public InventoryCell.CellType cellType;

	// Token: 0x040002CE RID: 718
	public TextMeshProUGUI amount;

	// Token: 0x040002CF RID: 719
	public Image itemImage;

	// Token: 0x040002D0 RID: 720
	public RawImage slot;

	// Token: 0x040002D1 RID: 721
	[HideInInspector]
	public InventoryItem currentItem;

	// Token: 0x040002D2 RID: 722
	public InventoryItem spawnItem;

	// Token: 0x040002D3 RID: 723
	public int cellId;

	// Token: 0x040002D4 RID: 724
	public Color idle;

	// Token: 0x040002D5 RID: 725
	public Color hover;

	// Token: 0x040002D6 RID: 726
	private bool ready = true;

	// Token: 0x040002D7 RID: 727
	private float lastClickTime;

	// Token: 0x040002D8 RID: 728
	private float doubleClickThreshold = 0.15f;

	// Token: 0x040002D9 RID: 729
	public InventoryItem.ItemTag[] tags;

	// Token: 0x040002DA RID: 730
	public RawImage overlay;

	// Token: 0x02000116 RID: 278
	public enum CellType
	{
		// Token: 0x04000759 RID: 1881
		Inventory,
		// Token: 0x0400075A RID: 1882
		Crafting,
		// Token: 0x0400075B RID: 1883
		Chest
	}
}
