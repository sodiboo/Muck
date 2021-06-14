using System;
using UnityEngine;

// Token: 0x02000092 RID: 146
public class Hotbar : MonoBehaviour
{
	// Token: 0x06000359 RID: 857 RVA: 0x00013668 File Offset: 0x00011868
	private void Start()
	{
		Hotbar.Instance = this;
		this.inventoryCells = this.inventory.hotkeysTransform.GetComponentsInChildren<InventoryCell>();
		this.cells = base.GetComponentsInChildren<InventoryCell>();
		this.cells[this.currentActive].slot.color = this.cells[this.currentActive].hover;
		this.UpdateHotbar();
		base.Invoke("UpdateHotbar", 1f);
	}

	// Token: 0x0600035A RID: 858 RVA: 0x000136DC File Offset: 0x000118DC
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

	// Token: 0x0600035B RID: 859 RVA: 0x0001378C File Offset: 0x0001198C
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

	// Token: 0x0600035C RID: 860 RVA: 0x000138E4 File Offset: 0x00011AE4
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

	// Token: 0x0600035D RID: 861 RVA: 0x00013938 File Offset: 0x00011B38
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

	// Token: 0x04000328 RID: 808
	private InventoryCell[] cells;

	// Token: 0x04000329 RID: 809
	private InventoryCell[] inventoryCells;

	// Token: 0x0400032A RID: 810
	public InventoryUI inventory;

	// Token: 0x0400032B RID: 811
	public InventoryItem currentItem;

	// Token: 0x0400032C RID: 812
	private int oldActive = -1;

	// Token: 0x0400032D RID: 813
	private int currentActive;

	// Token: 0x0400032E RID: 814
	private int max = 6;

	// Token: 0x0400032F RID: 815
	public static Hotbar Instance;

	// Token: 0x04000330 RID: 816
	private float sendDelay = 0.25f;
}
