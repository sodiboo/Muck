using System;
using TMPro;
using UnityEngine;

// Token: 0x02000020 RID: 32
public class DayUi : MonoBehaviour
{
	// Token: 0x060000AD RID: 173 RVA: 0x000029D8 File Offset: 0x00000BD8
	private void Awake()
	{
		this.defaultScale = this.dayText.transform.localScale;
	}

	// Token: 0x060000AE RID: 174 RVA: 0x000029F0 File Offset: 0x00000BF0
	public void SetDay(int day)
	{
		base.Invoke(nameof(StartFade), 2f);
		this.dayText.text = string.Format("-DAY {0}-", day);
	}

	// Token: 0x060000AF RID: 175 RVA: 0x00009D68 File Offset: 0x00007F68
	private void StartFade()
	{
		if (GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		base.gameObject.SetActive(true);
		if (this.defaultScale == Vector3.zero)
		{
			this.defaultScale = this.dayText.transform.localScale;
		}
		this.dayText.GetComponent<CanvasRenderer>().SetAlpha(0f);
		this.dayText.transform.localScale = this.defaultScale * 3f;
		this.desiredScale = this.defaultScale * 1.2f;
		this.dayText.CrossFadeAlpha(1f, this.fadeTime, true);
		base.Invoke(nameof(FadeAway), 4f);
		base.Invoke(nameof(Hide), 4f + this.fadeTime);
		this.done = false;
		this.sfx.Play();
	}

	// Token: 0x060000B0 RID: 176 RVA: 0x00009E50 File Offset: 0x00008050
	private void Update()
	{
		Vector3 b = Vector3.one * this.scaleSpeed * Time.deltaTime;
		this.desiredScale += b;
		this.dayText.transform.localScale = Vector3.Lerp(this.dayText.transform.localScale, this.desiredScale, Time.deltaTime * 3f);
	}

	// Token: 0x060000B1 RID: 177 RVA: 0x00002A1D File Offset: 0x00000C1D
	private void Hide()
	{
		base.gameObject.SetActive(false);
	}

	// Token: 0x060000B2 RID: 178 RVA: 0x00002A2B File Offset: 0x00000C2B
	private void FadeAway()
	{
		this.dayText.CrossFadeAlpha(0f, this.fadeTime, true);
	}

	// Token: 0x040000B0 RID: 176
	public TextMeshProUGUI dayText;

	// Token: 0x040000B1 RID: 177
	private Vector3 desiredScale;

	// Token: 0x040000B2 RID: 178
	private Vector3 defaultScale;

	// Token: 0x040000B3 RID: 179
	private bool done;

	// Token: 0x040000B4 RID: 180
	private float fadeTime = 2f;

	// Token: 0x040000B5 RID: 181
	private float scaleSpeed = -0.2f;

	// Token: 0x040000B6 RID: 182
	public AudioSource sfx;
}
