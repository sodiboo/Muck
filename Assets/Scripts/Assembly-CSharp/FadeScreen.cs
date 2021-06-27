using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000033 RID: 51
public class FadeScreen : MonoBehaviour
{
	// Token: 0x0600012D RID: 301 RVA: 0x0000797F File Offset: 0x00005B7F
	private void Awake()
	{
		FadeScreen.Instance = this;
		this.blackImg.CrossFadeAlpha(0f, 0f, true);
		this.blackImg.gameObject.SetActive(true);
	}

	// Token: 0x0600012E RID: 302 RVA: 0x000079AE File Offset: 0x00005BAE
	public void StartFade(float alpha, float duration)
	{
		this.blackImg.CrossFadeAlpha(alpha, duration, true);
	}

	// Token: 0x04000131 RID: 305
	public RawImage blackImg;

	// Token: 0x04000132 RID: 306
	public static FadeScreen Instance;
}
