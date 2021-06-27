using System;
using UnityEngine;

// Token: 0x020000A0 RID: 160
public class Hotbar : MonoBehaviour
{
	// Token: 0x060003F8 RID: 1016 RVA: 0x000141EC File Offset: 0x000123EC
	private void Start()
	{
		Hotbar.Instance = this;
		this.inventoryCells = this.inventory.hotkeysTransform.GetComponentsInChildren<InventoryCell>();
		this.cells = base.GetComponentsInChildren<InventoryCell>();
		this.cells[this.currentActive].slot.color = this.cells[this.currentActive].hover;
		this.UpdateHotbar();
		Invoke(nameof(UpdateHotbar), 1f);
	}

	// Token: 0x060003F9 RID: 1017 RVA: 0x00014260 File Offset: 0x00012460
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

	// Token: 0x060003FA RID: 1018 RVA: 0x00014310 File Offset: 0x00012510
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
			Invoke(nameof(SendItemToServer), this.sendDelay);
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

	// Token: 0x060003FB RID: 1019 RVA: 0x00014468 File Offset: 0x00012668
	private void SendItemToServer()
	{
		if (this.currentItem == null)
		{
			ClientSend.WeaponInHand(-1);
			if (PreviewPlayer.Instance)
			{
				PreviewPlayer.Instance.WeaponInHand(-1);
				return;
			}
		}
		else
		{
			ClientSend.WeaponInHand(this.currentItem.id);
			if (PreviewPlayer.Instance)
			{
				PreviewPlayer.Instance.WeaponInHand(this.currentItem.id);
			}
		}
	}

	// Token: 0x060003FC RID: 1020 RVA: 0x000144D4 File Offset: 0x000126D4
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

	// Token: 0x040003BC RID: 956
	private InventoryCell[] cells;

	// Token: 0x040003BD RID: 957
	private InventoryCell[] inventoryCells;

	// Token: 0x040003BE RID: 958
	public InventoryUI inventory;

	// Token: 0x040003BF RID: 959
	public InventoryItem currentItem;

	// Token: 0x040003C0 RID: 960
	private int oldActive = -1;

	// Token: 0x040003C1 RID: 961
	private int currentActive;

	// Token: 0x040003C2 RID: 962
	private int max = 6;

	// Token: 0x040003C3 RID: 963
	public static Hotbar Instance;

	// Token: 0x040003C4 RID: 964
	private float sendDelay = 0.25f;
}
