using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000159 RID: 345
public class ZoneVignette : MonoBehaviour
{
	// Token: 0x06000843 RID: 2115 RVA: 0x00028510 File Offset: 0x00026710
	private void Awake()
	{
		ZoneVignette.Instance = this;
		this.img = base.GetComponent<RawImage>();
		this.img.CrossFadeAlpha(0f, 0f, true);
		Color color = this.img.color;
		color.a = 0.8f;
		this.img.color = color;
	}

	// Token: 0x06000844 RID: 2116 RVA: 0x0002856C File Offset: 0x0002676C
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

	// Token: 0x06000845 RID: 2117 RVA: 0x0000762F File Offset: 0x0000582F
	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 0.2f);
	}

	// Token: 0x04000887 RID: 2183
	private float intensity;

	// Token: 0x04000888 RID: 2184
	private RawImage img;

	// Token: 0x04000889 RID: 2185
	public static ZoneVignette Instance;

	// Token: 0x0400088A RID: 2186
	private Vector3 desiredScale = Vector3.one;
}
