using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000135 RID: 309
public class ZoneVignette : MonoBehaviour
{
	// Token: 0x060008D0 RID: 2256 RVA: 0x0002BE08 File Offset: 0x0002A008
	private void Awake()
	{
		ZoneVignette.Instance = this;
		this.img = base.GetComponent<RawImage>();
		this.img.CrossFadeAlpha(0f, 0f, true);
		Color color = this.img.color;
		color.a = 0.8f;
		this.img.color = color;
	}

	// Token: 0x060008D1 RID: 2257 RVA: 0x0002BE64 File Offset: 0x0002A064
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

	// Token: 0x060008D2 RID: 2258 RVA: 0x0002BECB File Offset: 0x0002A0CB
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 0.2f);
	}

	// Token: 0x04000862 RID: 2146
	private float intensity;

	// Token: 0x04000863 RID: 2147
	private RawImage img;

	// Token: 0x04000864 RID: 2148
	public static ZoneVignette Instance;

	// Token: 0x04000865 RID: 2149
	private Vector3 desiredScale = Vector3.one;
}
