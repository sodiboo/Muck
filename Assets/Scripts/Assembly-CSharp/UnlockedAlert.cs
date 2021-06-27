using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnlockedAlert : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler
{
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

	private void Update()
	{
		float d = 1f + Mathf.PingPong(Time.time, 0.25f) - 0.5f;
		this.alert.transform.localScale = Vector3.Lerp(this.alert.transform.localScale, Vector3.one * d, Time.deltaTime * 10f);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		UiEvents.Instance.alertCleared[this.cell.currentItem.id] = true;
		Destroy(base.gameObject);
	}

	public InventoryCell cell;

	public Transform alert;
}
