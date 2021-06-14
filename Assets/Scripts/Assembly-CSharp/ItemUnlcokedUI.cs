using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200004B RID: 75
public class ItemUnlcokedUI : MonoBehaviour
{
	// Token: 0x0600018F RID: 399 RVA: 0x0000E2EC File Offset: 0x0000C4EC
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.top;
		this.layout.padding.top = 400;
		this.padUp = (float)this.layout.padding.top;
		base.Invoke(nameof(StartFade), this.fadeStart);
	}

	// Token: 0x06000190 RID: 400 RVA: 0x0000E35C File Offset: 0x0000C55C
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke(nameof(DestroySelf), this.fadeTime);
	}

	// Token: 0x06000191 RID: 401 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x06000192 RID: 402 RVA: 0x000032C0 File Offset: 0x000014C0
	public void SetItem(InventoryItem i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = "Unlocked " + i.name;
	}

	// Token: 0x06000193 RID: 403 RVA: 0x0000E3C0 File Offset: 0x0000C5C0
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 10f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.top = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x0400019E RID: 414
	public Image overlay;

	// Token: 0x0400019F RID: 415
	public Image icon;

	// Token: 0x040001A0 RID: 416
	public TextMeshProUGUI item;

	// Token: 0x040001A1 RID: 417
	private HorizontalLayoutGroup layout;

	// Token: 0x040001A2 RID: 418
	private float desiredPad;

	// Token: 0x040001A3 RID: 419
	private float fadeStart = 1.5f;

	// Token: 0x040001A4 RID: 420
	private float fadeTime = 0.5f;

	// Token: 0x040001A5 RID: 421
	private float padUp;
}
