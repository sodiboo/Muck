using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000049 RID: 73
public class ItemPickedupUI : MonoBehaviour
{
	// Token: 0x06000187 RID: 391 RVA: 0x0000E11C File Offset: 0x0000C31C
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = -300;
		this.padLeft = (float)this.layout.padding.left;
		base.Invoke("StartFade", this.fadeStart);
	}

	// Token: 0x06000188 RID: 392 RVA: 0x0000E18C File Offset: 0x0000C38C
	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		base.Invoke("DestroySelf", this.fadeTime);
	}

	// Token: 0x06000189 RID: 393 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x0600018A RID: 394 RVA: 0x0000E1D8 File Offset: 0x0000C3D8
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

	// Token: 0x0600018B RID: 395 RVA: 0x0000326E File Offset: 0x0000146E
	public void SetPowerup(Powerup i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = i.name + "\n<size=75%>" + i.description;
	}

	// Token: 0x0600018C RID: 396 RVA: 0x0000E244 File Offset: 0x0000C444
	public void Update()
	{
		this.padLeft = Mathf.Lerp(this.padLeft, this.desiredPad, Time.deltaTime * 7f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padLeft;
		this.layout.padding = rectOffset;
		this.layout.padding.left = (int)this.padLeft;
	}

	// Token: 0x04000197 RID: 407
	public Image icon;

	// Token: 0x04000198 RID: 408
	public TextMeshProUGUI item;

	// Token: 0x04000199 RID: 409
	private HorizontalLayoutGroup layout;

	// Token: 0x0400019A RID: 410
	private float desiredPad;

	// Token: 0x0400019B RID: 411
	private float fadeStart = 6f;

	// Token: 0x0400019C RID: 412
	private float fadeTime = 1f;

	// Token: 0x0400019D RID: 413
	private float padLeft;
}
