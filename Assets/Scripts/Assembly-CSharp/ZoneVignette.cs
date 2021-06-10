
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000102 RID: 258
public class ZoneVignette : MonoBehaviour
{
	// Token: 0x06000784 RID: 1924 RVA: 0x0002541C File Offset: 0x0002361C
	private void Awake()
	{
		ZoneVignette.Instance = this;
		this.img = base.GetComponent<RawImage>();
		this.img.CrossFadeAlpha(0f, 0f, true);
		Color color = this.img.color;
		color.a = 0.8f;
		this.img.color = color;
	}

	// Token: 0x06000785 RID: 1925 RVA: 0x00025478 File Offset: 0x00023678
	public void SetVignette(bool on)
	{
		if (on)
		{
			this.img.CrossFadeAlpha(0.8f, 3f, true);
			this.desiredScale = Vector3.one * 1.6f;
			return;
		}
		this.img.CrossFadeAlpha(0f, 2f, true);
		this.desiredScale = Vector3.one * 1f;
	}

	// Token: 0x06000786 RID: 1926 RVA: 0x000254DF File Offset: 0x000236DF
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 0.2f);
	}

	// Token: 0x04000714 RID: 1812
	private float intensity;

	// Token: 0x04000715 RID: 1813
	private RawImage img;

	// Token: 0x04000716 RID: 1814
	public static ZoneVignette Instance;

	// Token: 0x04000717 RID: 1815
	private Vector3 desiredScale = Vector3.one;
}
