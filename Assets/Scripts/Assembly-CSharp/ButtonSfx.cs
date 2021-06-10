
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200000B RID: 11
public class ButtonSfx : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler
{
	// Token: 0x06000031 RID: 49 RVA: 0x0000276E File Offset: 0x0000096E
	public void OnPointerEnter(PointerEventData eventData)
	{
	}

	// Token: 0x06000032 RID: 50 RVA: 0x00003917 File Offset: 0x00001B17
	public void OnPointerClick(PointerEventData eventData)
	{
		UiSfx.Instance.PlayClick();
	}
}
