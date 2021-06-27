using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class UpdateArmor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	private void Awake()
	{
		this.cell = base.GetComponent<InventoryCell>();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		int itemId;
		if (this.cell.currentItem == null)
		{
			itemId = -1;
		}
		else
		{
			itemId = this.cell.currentItem.id;
		}
		PlayerStatus.Instance.UpdateArmor(base.transform.GetSiblingIndex(), itemId);
		UiSfx.Instance.PlayArmor();
	}

	private InventoryCell cell;
}
