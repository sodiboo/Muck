using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200006D RID: 109
public class PowerupInfo : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	// Token: 0x1700001B RID: 27
	// (get) Token: 0x06000262 RID: 610 RVA: 0x00003CC4 File Offset: 0x00001EC4
	// (set) Token: 0x06000263 RID: 611 RVA: 0x00003CCC File Offset: 0x00001ECC
	public Powerup powerup { get; set; }

	// Token: 0x06000264 RID: 612 RVA: 0x00003CD5 File Offset: 0x00001ED5
	public void OnPointerEnter(PointerEventData eventData)
	{
		ItemInfo.Instance.SetText(this.powerup.name + "\n<size=50%><i>" + this.powerup.description, true);
	}

	// Token: 0x06000265 RID: 613 RVA: 0x00003D02 File Offset: 0x00001F02
	public void OnPointerExit(PointerEventData eventData)
	{
		ItemInfo.Instance.Fade(0f, 0.2f);
	}
}
