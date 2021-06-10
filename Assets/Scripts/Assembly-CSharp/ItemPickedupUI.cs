
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200003C RID: 60
public class ItemPickedupUI : MonoBehaviour
{
	// Token: 0x06000160 RID: 352 RVA: 0x0000959C File Offset: 0x0000779C
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = -300;
		this.padLeft = (float)this.layout.padding.left;
		base.Invoke("StartFade", this.fadeStart);
	}

	// Token: 0x06000161 RID: 353 RVA: 0x0000960C File Offset: 0x0000780C
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke("DestroySelf", this.fadeTime);
	}

	// Token: 0x06000162 RID: 354 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x06000163 RID: 355 RVA: 0x00009658 File Offset: 0x00007858
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

	// Token: 0x06000164 RID: 356 RVA: 0x000096C2 File Offset: 0x000078C2
	public void SetPowerup(Powerup i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = i.name + "\n<size=75%>" + i.description;
	}

	// Token: 0x06000165 RID: 357 RVA: 0x000096F8 File Offset: 0x000078F8
	public void Update()
	{
		this.padLeft = Mathf.Lerp(this.padLeft, this.desiredPad, Time.deltaTime * 7f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padLeft;
		this.layout.padding = rectOffset;
		this.layout.padding.left = (int)this.padLeft;
	}

	// Token: 0x04000162 RID: 354
	public Image icon;

	// Token: 0x04000163 RID: 355
	public TextMeshProUGUI item;

	// Token: 0x04000164 RID: 356
	private HorizontalLayoutGroup layout;

	// Token: 0x04000165 RID: 357
	private float desiredPad;

	// Token: 0x04000166 RID: 358
	private float fadeStart = 6f;

	// Token: 0x04000167 RID: 359
	private float fadeTime = 1f;

	// Token: 0x04000168 RID: 360
	private float padLeft;
}
