using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000047 RID: 71
public class ItemInfo : MonoBehaviour
{
	// Token: 0x06000172 RID: 370 RVA: 0x000031DC File Offset: 0x000013DC
	private void Awake()
	{
		ItemInfo.Instance = this;
		this.defaultTextPos = this.text.transform.localPosition;
	}

	// Token: 0x06000173 RID: 371 RVA: 0x000031FA File Offset: 0x000013FA
	private void Update()
	{
		base.transform.position = Input.mousePosition;
		this.FitToText();
	}

	// Token: 0x06000174 RID: 372 RVA: 0x00003212 File Offset: 0x00001412
	private void OnEnable()
	{
		this.SetText("", false);
	}

	// Token: 0x06000175 RID: 373 RVA: 0x0000D9EC File Offset: 0x0000BBEC
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

	// Token: 0x06000176 RID: 374 RVA: 0x0000DB28 File Offset: 0x0000BD28
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

	// Token: 0x06000177 RID: 375 RVA: 0x00003220 File Offset: 0x00001420
	public void Fade(float opacity, float time = 0.2f)
	{
		this.text.CrossFadeAlpha(opacity, time, true);
		this.image.CrossFadeAlpha(opacity, time, true);
	}

	// Token: 0x04000181 RID: 385
	public TextMeshProUGUI text;

	// Token: 0x04000182 RID: 386
	public RawImage image;

	// Token: 0x04000183 RID: 387
	public float padding;

	// Token: 0x04000184 RID: 388
	private Vector3 defaultTextPos;

	// Token: 0x04000185 RID: 389
	public static ItemInfo Instance;

	// Token: 0x04000186 RID: 390
	private bool leftCorner;
}
