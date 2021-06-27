using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200012B RID: 299
public class TutorialTaskUI : MonoBehaviour
{
	// Token: 0x06000897 RID: 2199 RVA: 0x0002AF90 File Offset: 0x00029190
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = 400;
		this.padUp = (float)this.layout.padding.left;
	}

	// Token: 0x06000898 RID: 2200 RVA: 0x0002AFEC File Offset: 0x000291EC
	public void StartFade()
	{
		this.icon.texture = this.checkedBox;
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		Invoke(nameof(DestroySelf), this.fadeTime);
	}

	// Token: 0x06000899 RID: 2201 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x0600089A RID: 2202 RVA: 0x0002B060 File Offset: 0x00029260
	public void SetItem(InventoryItem i, string text)
	{
		text = text.Replace("[inv]", "[" + InputManager.inventory + "]");
		text = text.Replace("[m2]", "[" + InputManager.rightClick + "]");
		this.item.text = text;
	}

	// Token: 0x0600089B RID: 2203 RVA: 0x0002B0C8 File Offset: 0x000292C8
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 6f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x04000828 RID: 2088
	public RawImage overlay;

	// Token: 0x04000829 RID: 2089
	public RawImage icon;

	// Token: 0x0400082A RID: 2090
	public TextMeshProUGUI item;

	// Token: 0x0400082B RID: 2091
	private HorizontalLayoutGroup layout;

	// Token: 0x0400082C RID: 2092
	public Texture checkedBox;

	// Token: 0x0400082D RID: 2093
	private float desiredPad;

	// Token: 0x0400082E RID: 2094
	private float fadeStart = 1.5f;

	// Token: 0x0400082F RID: 2095
	private float fadeTime = 1.5f;

	// Token: 0x04000830 RID: 2096
	private float padUp;
}
