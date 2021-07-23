using UnityEngine;
using UnityEngine.EventSystems;

public class UnlockedAlert : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler
{
    public InventoryCell cell;

    public Transform alert;

    private void Start()
    {
        if (cell.currentItem == null)
        {
            Debug.LogError("Item is null");
        }
        else if (UiEvents.Instance.alertCleared[cell.currentItem.id])
        {
            Object.Destroy(base.gameObject);
        }
        else
        {
            alert.transform.localScale = Vector3.one * (1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f);
        }
    }

    private void Update()
    {
        float num = 1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f;
        alert.transform.localScale = Vector3.Lerp(alert.transform.localScale, Vector3.one * num, Time.deltaTime * 10f);
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        UiEvents.Instance.alertCleared[cell.currentItem.id] = true;
        Object.Destroy(base.gameObject);
    }
}
