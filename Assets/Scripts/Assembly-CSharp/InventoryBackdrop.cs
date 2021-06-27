using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class InventoryBackdrop : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	public void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.eligibleForClick)
		{
			if (eventData.pointerCurrentRaycast.gameObject != base.gameObject)
			{
				return;
			}
			InventoryUI.Instance.DropItem(eventData);
		}
	}
}
