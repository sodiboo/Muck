
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000037 RID: 55
public class InventoryBackdrop : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x0600013A RID: 314 RVA: 0x0000895C File Offset: 0x00006B5C
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
