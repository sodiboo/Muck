using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200000C RID: 12
public class ButtonSfx : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler
{
	// Token: 0x06000032 RID: 50 RVA: 0x00002147 File Offset: 0x00000347
	public void OnPointerEnter(PointerEventData eventData)
	{
	}

	// Token: 0x06000033 RID: 51 RVA: 0x00002275 File Offset: 0x00000475
	public void OnPointerClick(PointerEventData eventData)
	{
		UiSfx.Instance.PlayClick();
	}
}
