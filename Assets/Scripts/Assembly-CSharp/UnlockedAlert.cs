
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x020000FF RID: 255
public class UnlockedAlert : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler
{
	// Token: 0x06000776 RID: 1910 RVA: 0x00024F38 File Offset: 0x00023138
	private void Start()
	{
		if (this.cell.currentItem == null)
		{
			Debug.LogError("Item is null");
			return;
		}
		if (UiEvents.Instance.alertCleared[this.cell.currentItem.id])
		{
		Destroy(base.gameObject);
			return;
		}
		this.alert.transform.localScale = Vector3.one * (1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f);
	}

	// Token: 0x06000777 RID: 1911 RVA: 0x00024FC4 File Offset: 0x000231C4
	private void Update()
	{
		float d = 1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f;
		this.alert.transform.localScale = Vector3.Lerp(this.alert.transform.localScale, Vector3.one * d, Time.deltaTime * 10f);
	}

	// Token: 0x06000778 RID: 1912 RVA: 0x00025028 File Offset: 0x00023228
	public void OnPointerEnter(PointerEventData eventData)
	{
		UiEvents.Instance.alertCleared[this.cell.currentItem.id] = true;
	Destroy(base.gameObject);
	}

	// Token: 0x04000704 RID: 1796
	public InventoryCell cell;

	// Token: 0x04000705 RID: 1797
	public Transform alert;
}
