using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000151 RID: 337
public class TutorialTaskUI : MonoBehaviour
{
	// Token: 0x06000810 RID: 2064 RVA: 0x00027988 File Offset: 0x00025B88
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = 400;
		this.padUp = (float)this.layout.padding.left;
	}

	// Token: 0x06000811 RID: 2065 RVA: 0x000279E4 File Offset: 0x00025BE4
	public void StartFade()
	{
		this.icon.texture = this.checkedBox;
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke("DestroySelf", this.fadeTime);
	}

	// Token: 0x06000812 RID: 2066 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x06000813 RID: 2067 RVA: 0x00027A58 File Offset: 0x00025C58
	public void SetItem(InventoryItem i, string text)
	{
		text = text.Replace("[inv]", "[" + InputManager.inventory + "]");
		text = text.Replace("[m2]", "[" + InputManager.rightClick + "]");
		this.item.text = text;
	}

	// Token: 0x06000814 RID: 2068 RVA: 0x00027AC0 File Offset: 0x00025CC0
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 6f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x04000854 RID: 2132
	public RawImage overlay;

	// Token: 0x04000855 RID: 2133
	public RawImage icon;

	// Token: 0x04000856 RID: 2134
	public TextMeshProUGUI item;

	// Token: 0x04000857 RID: 2135
	private HorizontalLayoutGroup layout;

	// Token: 0x04000858 RID: 2136
	public Texture checkedBox;

	// Token: 0x04000859 RID: 2137
	private float desiredPad;

	// Token: 0x0400085A RID: 2138
	private float fadeStart = 1.5f;

	// Token: 0x0400085B RID: 2139
	private float fadeTime = 1.5f;

	// Token: 0x0400085C RID: 2140
	private float padUp;
}
