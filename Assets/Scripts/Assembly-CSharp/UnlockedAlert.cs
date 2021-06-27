using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000130 RID: 304
public class UnlockedAlert : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler
{
	// Token: 0x060008BD RID: 2237 RVA: 0x0002B858 File Offset: 0x00029A58
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

	// Token: 0x060008BE RID: 2238 RVA: 0x0002B8E4 File Offset: 0x00029AE4
	private void Update()
	{
		float d = 1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f;
		this.alert.transform.localScale = Vector3.Lerp(this.alert.transform.localScale, Vector3.one * d, Time.deltaTime * 10f);
	}

	// Token: 0x060008BF RID: 2239 RVA: 0x0002B948 File Offset: 0x00029B48
	public void OnPointerEnter(PointerEventData eventData)
	{
		UiEvents.Instance.alertCleared[this.cell.currentItem.id] = true;
		Destroy(base.gameObject);
	}

	// Token: 0x0400084C RID: 2124
	public InventoryCell cell;

	// Token: 0x0400084D RID: 2125
	public Transform alert;
}
