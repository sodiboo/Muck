using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000044 RID: 68
public class InventoryBackdrop : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x06000161 RID: 353 RVA: 0x0000D5F8 File Offset: 0x0000B7F8
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
