using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000054 RID: 84
public class ItemInfo : MonoBehaviour
{
	// Token: 0x060001DD RID: 477 RVA: 0x0000B9C4 File Offset: 0x00009BC4
	private void Awake()
	{
		ItemInfo.Instance = this;
		this.defaultTextPos = this.text.transform.localPosition;
	}

	// Token: 0x060001DE RID: 478 RVA: 0x0000B9E2 File Offset: 0x00009BE2
	private void Update()
	{
		base.transform.position = Input.mousePosition;
		this.FitToText();
	}

	// Token: 0x060001DF RID: 479 RVA: 0x0000B9FA File Offset: 0x00009BFA
	private void OnEnable()
	{
		this.SetText("", false);
	}

	// Token: 0x060001E0 RID: 480 RVA: 0x0000BA08 File Offset: 0x00009C08
	public void FitToText()
	{
		Vector2 vector = new Vector2(this.text.mesh.bounds.size.x, this.text.mesh.bounds.size.y);
		vector.x += this.padding;
		vector.y += this.padding;
		if (this.leftCorner)
		{
			this.text.transform.localPosition = -this.defaultTextPos - new Vector3(vector.x, vector.y, 0f);
		}
		else
		{
			this.text.transform.localPosition = this.defaultTextPos;
		}
		this.image.rectTransform.sizeDelta = vector;
		this.image.rectTransform.position = this.text.rectTransform.position;
		Vector3 b = new Vector3(this.padding / 2f, 0f, 0f);
		this.image.rectTransform.localPosition = this.text.rectTransform.localPosition - b;
	}

	// Token: 0x060001E1 RID: 481 RVA: 0x0000BB44 File Offset: 0x00009D44
	public void SetText(string t, bool leftCorner = false)
	{
		this.text.text = t;
		if (t == "")
		{
			this.Fade(0f, 0.2f);
		}
		else
		{
			this.Fade(1f, 0.2f);
		}
		this.FitToText();
		if (leftCorner)
		{
			this.leftCorner = true;
			return;
		}
		this.leftCorner = false;
	}

	// Token: 0x060001E2 RID: 482 RVA: 0x0000BBA4 File Offset: 0x00009DA4
	public void Fade(float opacity, float time = 0.2f)
	{
		this.text.CrossFadeAlpha(opacity, time, true);
		this.image.CrossFadeAlpha(opacity, time, true);
	}

	// Token: 0x040001F3 RID: 499
	public TextMeshProUGUI text;

	// Token: 0x040001F4 RID: 500
	public RawImage image;

	// Token: 0x040001F5 RID: 501
	public float padding;

	// Token: 0x040001F6 RID: 502
	private Vector3 defaultTextPos;

	// Token: 0x040001F7 RID: 503
	public static ItemInfo Instance;

	// Token: 0x040001F8 RID: 504
	private bool leftCorner;
}
