using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000058 RID: 88
public class ItemUnlcokedUI : MonoBehaviour
{
	// Token: 0x060001FA RID: 506 RVA: 0x0000C3A8 File Offset: 0x0000A5A8
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.top;
		this.layout.padding.top = 400;
		this.padUp = (float)this.layout.padding.top;
		Invoke(nameof(StartFade), this.fadeStart);
	}

	// Token: 0x060001FB RID: 507 RVA: 0x0000C418 File Offset: 0x0000A618
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		Invoke(nameof(DestroySelf), this.fadeTime);
	}

	// Token: 0x060001FC RID: 508 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x060001FD RID: 509 RVA: 0x0000C47B File Offset: 0x0000A67B
	public void SetItem(InventoryItem i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = "Unlocked " + i.name;
	}

	// Token: 0x060001FE RID: 510 RVA: 0x0000C4AC File Offset: 0x0000A6AC
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 10f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.top = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x04000210 RID: 528
	public Image overlay;

	// Token: 0x04000211 RID: 529
	public Image icon;

	// Token: 0x04000212 RID: 530
	public TextMeshProUGUI item;

	// Token: 0x04000213 RID: 531
	private HorizontalLayoutGroup layout;

	// Token: 0x04000214 RID: 532
	private float desiredPad;

	// Token: 0x04000215 RID: 533
	private float fadeStart = 1.5f;

	// Token: 0x04000216 RID: 534
	private float fadeTime = 0.5f;

	// Token: 0x04000217 RID: 535
	private float padUp;
}
