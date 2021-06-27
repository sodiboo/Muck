using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200000F RID: 15
public class ButtonSfx : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler
{
	// Token: 0x0600005B RID: 91 RVA: 0x000030D7 File Offset: 0x000012D7
	public void OnPointerEnter(PointerEventData eventData)
	{
	}

	// Token: 0x0600005C RID: 92 RVA: 0x0000416B File Offset: 0x0000236B
	public void OnPointerClick(PointerEventData eventData)
	{
		UiSfx.Instance.PlayClick();
	}
}
