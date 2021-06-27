using System;
using UnityEngine;

public class Hotbar : MonoBehaviour
{
	private void Start()
	{
		Hotbar.Instance = this;
		this.inventoryCells = this.inventory.hotkeysTransform.GetComponentsInChildren<InventoryCell>();
		this.cells = base.GetComponentsInChildren<InventoryCell>();
		this.cells[this.currentActive].slot.color = this.cells[this.currentActive].hover;
		this.UpdateHotbar();
		Invoke(nameof(UpdateHotbar), 1f);
	}

	private void Update()
	{
		if (OtherInput.Instance.OtherUiActive()) return;
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
			cells[j].itemImage.preserveAspect = true;
		}
	}

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

	public void UseItem(int n)
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) return;
		this.currentItem.amount -= n;
		if (this.currentItem.amount <= 0)
		{
			this.inventoryCells[this.currentActive].RemoveItem();
		}
		this.inventoryCells[this.currentActive].UpdateCell();
		this.UpdateHotbar();
	}

	private InventoryCell[] cells;

	private InventoryCell[] inventoryCells;

	public InventoryUI inventory;

	public InventoryItem currentItem;

	private int oldActive = -1;

	private int currentActive;

	private int max = 6;

	public static Hotbar Instance;

	private float sendDelay = 0.25f;
}
