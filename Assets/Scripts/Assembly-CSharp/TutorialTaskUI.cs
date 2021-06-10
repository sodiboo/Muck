
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000FB RID: 251
public class TutorialTaskUI : MonoBehaviour
{
	// Token: 0x06000753 RID: 1875 RVA: 0x000246A8 File Offset: 0x000228A8
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = 400;
		this.padUp = (float)this.layout.padding.left;
	}

	// Token: 0x06000754 RID: 1876 RVA: 0x00024704 File Offset: 0x00022904
	public void StartFade()
	{
		this.icon.texture = this.checkedBox;
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke("DestroySelf", this.fadeTime);
	}

	// Token: 0x06000755 RID: 1877 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x06000756 RID: 1878 RVA: 0x00024778 File Offset: 0x00022978
	public void SetItem(InventoryItem i, string text)
	{
		text = text.Replace("[inv]", "[" + InputManager.inventory + "]");
		text = text.Replace("[m2]", "[" + InputManager.rightClick + "]");
		this.item.text = text;
	}

	// Token: 0x06000757 RID: 1879 RVA: 0x000247E0 File Offset: 0x000229E0
	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 6f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	// Token: 0x040006E3 RID: 1763
	public RawImage overlay;

	// Token: 0x040006E4 RID: 1764
	public RawImage icon;

	// Token: 0x040006E5 RID: 1765
	public TextMeshProUGUI item;

	// Token: 0x040006E6 RID: 1766
	private HorizontalLayoutGroup layout;

	// Token: 0x040006E7 RID: 1767
	public Texture checkedBox;

	// Token: 0x040006E8 RID: 1768
	private float desiredPad;

	// Token: 0x040006E9 RID: 1769
	private float fadeStart = 1.5f;

	// Token: 0x040006EA RID: 1770
	private float fadeTime = 1.5f;

	// Token: 0x040006EB RID: 1771
	private float padUp;
}
