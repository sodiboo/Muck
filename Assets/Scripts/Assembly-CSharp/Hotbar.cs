
using UnityEngine;

// Token: 0x0200007A RID: 122
public class Hotbar : MonoBehaviour
{
	// Token: 0x06000318 RID: 792 RVA: 0x0000F9BC File Offset: 0x0000DBBC
	private void Start()
	{
		Hotbar.Instance = this;
		this.inventoryCells = this.inventory.hotkeysTransform.GetComponentsInChildren<InventoryCell>();
		this.cells = base.GetComponentsInChildren<InventoryCell>();
		this.cells[this.currentActive].slot.color = this.cells[this.currentActive].hover;
		this.UpdateHotbar();
		base.Invoke("UpdateHotbar", 1f);
	}

	// Token: 0x06000319 RID: 793 RVA: 0x0000FA30 File Offset: 0x0000DC30
	private void Update()
	{
		for (int i = 1; i < 8; i++)
		{
			if (Input.GetButtonDown("Hotbar" + i))
			{
				this.currentActive = i - 1;
				this.UpdateHotbar();
			}
		}
		float y = Input.mouseScrollDelta.y;
		if (y > 0.5f)
		{
			this.currentActive--;
			if (this.currentActive < 0)
			{
				this.currentActive = this.max;
			}
			this.UpdateHotbar();
			return;
		}
		if (y < -0.5f)
		{
			this.currentActive++;
			if (this.currentActive > this.max)
			{
				this.currentActive = 0;
			}
			this.UpdateHotbar();
		}
	}

	// Token: 0x0600031A RID: 794 RVA: 0x0000FAE0 File Offset: 0x0000DCE0
	public void UpdateHotbar()
	{
		if (this.inventoryCells[this.currentActive].currentItem != this.currentItem)
		{
			this.currentItem = this.inventoryCells[this.currentActive].currentItem;
			if (UseInventory.Instance)
			{
				UseInventory.Instance.SetWeapon(this.currentItem);
			}
			base.CancelInvoke("SendItemToServer");
			base.Invoke("SendItemToServer", this.sendDelay);
		}
		for (int i = 0; i < this.cells.Length; i++)
		{
			if (i == this.currentActive)
			{
				this.cells[i].slot.color = this.cells[i].hover;
			}
			else
			{
				this.cells[i].slot.color = this.cells[i].idle;
			}
		}
		for (int j = 0; j < this.cells.Length; j++)
		{
			this.cells[j].itemImage.sprite = this.inventoryCells[j].itemImage.sprite;
			this.cells[j].itemImage.color = this.inventoryCells[j].itemImage.color;
			this.cells[j].amount.text = this.inventoryCells[j].amount.text;
		}
	}

	// Token: 0x0600031B RID: 795 RVA: 0x0000FC38 File Offset: 0x0000DE38
	private void SendItemToServer()
	{
		if (this.currentItem == null)
		{
			ClientSend.WeaponInHand(-1);
			return;
		}
		ClientSend.WeaponInHand(this.currentItem.id);
		if (PreviewPlayer.Instance)
		{
			PreviewPlayer.Instance.WeaponInHand(this.currentItem.id);
		}
	}

	// Token: 0x0600031C RID: 796 RVA: 0x0000FC8C File Offset: 0x0000DE8C
	public void UseItem(int n)
	{
		this.currentItem.amount -= n;
		if (this.currentItem.amount <= 0)
		{
			this.inventoryCells[this.currentActive].RemoveItem();
		}
		this.inventoryCells[this.currentActive].UpdateCell();
		this.UpdateHotbar();
	}

	// Token: 0x040002C4 RID: 708
	private InventoryCell[] cells;

	// Token: 0x040002C5 RID: 709
	private InventoryCell[] inventoryCells;

	// Token: 0x040002C6 RID: 710
	public InventoryUI inventory;

	// Token: 0x040002C7 RID: 711
	public InventoryItem currentItem;

	// Token: 0x040002C8 RID: 712
	private int oldActive = -1;

	// Token: 0x040002C9 RID: 713
	private int currentActive;

	// Token: 0x040002CA RID: 714
	private int max = 6;

	// Token: 0x040002CB RID: 715
	public static Hotbar Instance;

	// Token: 0x040002CC RID: 716
	private float sendDelay = 0.25f;
}
