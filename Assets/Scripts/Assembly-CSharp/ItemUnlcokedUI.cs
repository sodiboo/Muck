
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200003E RID: 62
public class ItemUnlcokedUI : MonoBehaviour
{
	// Token: 0x06000168 RID: 360 RVA: 0x000097BC File Offset: 0x000079BC
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.top;
		this.layout.padding.top = 400;
		this.padUp = (float)this.layout.padding.top;
		base.Invoke("StartFade", this.fadeStart);
	}

	// Token: 0x06000169 RID: 361 RVA: 0x0000982C File Offset: 0x00007A2C
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke("DestroySelf", this.fadeTime);
	}

	// Token: 0x0600016A RID: 362 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x0600016B RID: 363 RVA: 0x0000988F File Offset: 0x00007A8F
	public void SetItem(InventoryItem i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = "Unlocked " + i.name;
	}

	// Token: 0x0600016C RID: 364 RVA: 0x000098C0 File Offset: 0x00007AC0
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 10f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.top = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x04000169 RID: 361
	public Image overlay;

	// Token: 0x0400016A RID: 362
	public Image icon;

	// Token: 0x0400016B RID: 363
	public TextMeshProUGUI item;

	// Token: 0x0400016C RID: 364
	private HorizontalLayoutGroup layout;

	// Token: 0x0400016D RID: 365
	private float desiredPad;

	// Token: 0x0400016E RID: 366
	private float fadeStart = 1.5f;

	// Token: 0x0400016F RID: 367
	private float fadeTime = 0.5f;

	// Token: 0x04000170 RID: 368
	private float padUp;
}
