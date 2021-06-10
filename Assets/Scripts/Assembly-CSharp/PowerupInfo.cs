
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x0200005C RID: 92
public class PowerupInfo : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	// Token: 0x17000017 RID: 23
	// (get) Token: 0x06000232 RID: 562 RVA: 0x0000C254 File Offset: 0x0000A454
	// (set) Token: 0x06000233 RID: 563 RVA: 0x0000C25C File Offset: 0x0000A45C
	public Powerup powerup { get; set; }

	// Token: 0x06000234 RID: 564 RVA: 0x0000C265 File Offset: 0x0000A465
	public void OnPointerEnter(PointerEventData eventData)
	{
		ItemInfo.Instance.SetText(this.powerup.name + "\n<size=50%><i>" + this.powerup.description, true);
	}

	// Token: 0x06000235 RID: 565 RVA: 0x0000C292 File Offset: 0x0000A492
	public void OnPointerExit(PointerEventData eventData)
	{
		ItemInfo.Instance.Fade(0f, 0.2f);
	}
}
