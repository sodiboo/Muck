
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200003A RID: 58
public class ItemInfo : MonoBehaviour
{
	// Token: 0x0600014B RID: 331 RVA: 0x00008DD6 File Offset: 0x00006FD6
	private void Awake()
	{
		ItemInfo.Instance = this;
		this.defaultTextPos = this.text.transform.localPosition;
	}

	// Token: 0x0600014C RID: 332 RVA: 0x00008DF4 File Offset: 0x00006FF4
	private void Update()
	{
		base.transform.position = Input.mousePosition;
		this.FitToText();
	}

	// Token: 0x0600014D RID: 333 RVA: 0x00008E0C File Offset: 0x0000700C
	private void OnEnable()
	{
		this.SetText("", false);
	}

	// Token: 0x0600014E RID: 334 RVA: 0x00008E1C File Offset: 0x0000701C
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

	// Token: 0x0600014F RID: 335 RVA: 0x00008F58 File Offset: 0x00007158
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

	// Token: 0x06000150 RID: 336 RVA: 0x00008FB8 File Offset: 0x000071B8
	public void Fade(float opacity, float time = 0.2f)
	{
		this.text.CrossFadeAlpha(opacity, time, true);
		this.image.CrossFadeAlpha(opacity, time, true);
	}

	// Token: 0x0400014C RID: 332
	public TextMeshProUGUI text;

	// Token: 0x0400014D RID: 333
	public RawImage image;

	// Token: 0x0400014E RID: 334
	public float padding;

	// Token: 0x0400014F RID: 335
	private Vector3 defaultTextPos;

	// Token: 0x04000150 RID: 336
	public static ItemInfo Instance;

	// Token: 0x04000151 RID: 337
	private bool leftCorner;
}
