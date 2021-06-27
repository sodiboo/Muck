using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000051 RID: 81
public class InventoryBackdrop : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x060001CB RID: 459 RVA: 0x0000B4B4 File Offset: 0x000096B4
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
