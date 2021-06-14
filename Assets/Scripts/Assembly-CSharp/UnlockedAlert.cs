using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000156 RID: 342
public class UnlockedAlert : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler
{
	// Token: 0x06000835 RID: 2101 RVA: 0x0002809C File Offset: 0x0002629C
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

	// Token: 0x06000836 RID: 2102 RVA: 0x00028128 File Offset: 0x00026328
	private void Update()
	{
		float d = 1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f;
		this.alert.transform.localScale = Vector3.Lerp(this.alert.transform.localScale, Vector3.one * d, Time.deltaTime * 10f);
	}

	// Token: 0x06000837 RID: 2103 RVA: 0x000075C0 File Offset: 0x000057C0
	public void OnPointerEnter(PointerEventData eventData)
	{
		UiEvents.Instance.alertCleared[this.cell.currentItem.id] = true;
	Destroy(base.gameObject);
	}

	// Token: 0x04000877 RID: 2167
	public InventoryCell cell;

	// Token: 0x04000878 RID: 2168
	public Transform alert;
}
