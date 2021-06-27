using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000056 RID: 86
public class ItemPickedupUI : MonoBehaviour
{
	// Token: 0x060001F2 RID: 498 RVA: 0x0000C188 File Offset: 0x0000A388
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = -300;
		this.padLeft = (float)this.layout.padding.left;
		Invoke(nameof(StartFade), this.fadeStart);
	}

	// Token: 0x060001F3 RID: 499 RVA: 0x0000C1F8 File Offset: 0x0000A3F8
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		Invoke(nameof(DestroySelf), this.fadeTime);
	}

	// Token: 0x060001F4 RID: 500 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x060001F5 RID: 501 RVA: 0x0000C244 File Offset: 0x0000A444
	public void SetItem(InventoryItem i)
	{
		if (i.amount < 1)
		{
			this.icon.sprite = null;
			this.item.text = "Inventory full";
			return;
		}
		this.icon.sprite = i.sprite;
		this.item.text = string.Format("{0}x {1}", i.amount, i.name);
	}

	// Token: 0x060001F6 RID: 502 RVA: 0x0000C2AE File Offset: 0x0000A4AE
	public void SetPowerup(Powerup i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = i.name + "\n<size=75%>" + i.description;
	}

	// Token: 0x060001F7 RID: 503 RVA: 0x0000C2E4 File Offset: 0x0000A4E4
	public void Update()
	{
		this.padLeft = Mathf.Lerp(this.padLeft, this.desiredPad, Time.deltaTime * 7f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padLeft;
		this.layout.padding = rectOffset;
		this.layout.padding.left = (int)this.padLeft;
	}

	// Token: 0x04000209 RID: 521
	public Image icon;

	// Token: 0x0400020A RID: 522
	public TextMeshProUGUI item;

	// Token: 0x0400020B RID: 523
	private HorizontalLayoutGroup layout;

	// Token: 0x0400020C RID: 524
	private float desiredPad;

	// Token: 0x0400020D RID: 525
	private float fadeStart = 6f;

	// Token: 0x0400020E RID: 526
	private float fadeTime = 1f;

	// Token: 0x0400020F RID: 527
	private float padLeft;
}
