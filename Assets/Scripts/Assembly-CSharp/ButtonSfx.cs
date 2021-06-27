using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class ButtonSfx : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler
{
	public void OnPointerEnter(PointerEventData eventData)
	{
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		UiSfx.Instance.PlayClick();
	}
}
