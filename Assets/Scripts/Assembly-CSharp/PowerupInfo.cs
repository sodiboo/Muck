using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200007C RID: 124
public class PowerupInfo : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	// Token: 0x17000021 RID: 33
	// (get) Token: 0x060002EF RID: 751 RVA: 0x00010043 File Offset: 0x0000E243
	// (set) Token: 0x060002F0 RID: 752 RVA: 0x0001004B File Offset: 0x0000E24B
	public Powerup powerup { get; set; }

	// Token: 0x060002F1 RID: 753 RVA: 0x00010054 File Offset: 0x0000E254
	public void OnPointerEnter(PointerEventData eventData)
	{
		ItemInfo.Instance.SetText(this.powerup.name + "\n<size=50%><i>" + this.powerup.description, true);
	}

	// Token: 0x060002F2 RID: 754 RVA: 0x00010081 File Offset: 0x0000E281
	public void OnPointerExit(PointerEventData eventData)
	{
		ItemInfo.Instance.Fade(0f, 0.2f);
	}
}
