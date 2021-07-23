using UnityEngine;
using UnityEngine.EventSystems;

public class UpdateArmor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
    private InventoryCell cell;

    private void Awake()
    {
        cell = GetComponent<InventoryCell>();
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        int itemId = ((!(cell.currentItem == null)) ? cell.currentItem.id : (-1));
        PlayerStatus.Instance.UpdateArmor(base.transform.GetSiblingIndex(), itemId);
        UiSfx.Instance.PlayArmor();
    }
}
