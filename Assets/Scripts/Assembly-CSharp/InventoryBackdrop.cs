using UnityEngine;
using UnityEngine.EventSystems;

public class InventoryBackdrop : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
    public void OnPointerDown(PointerEventData eventData)
    {
        if (eventData.eligibleForClick && !(eventData.pointerCurrentRaycast.gameObject != base.gameObject))
        {
            InventoryUI.Instance.DropItem(eventData);
        }
    }
}
