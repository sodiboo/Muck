using System;
using TMPro;
using UnityEngine;

// Token: 0x02000024 RID: 36
public class DayUi : MonoBehaviour
{
	// Token: 0x060000DF RID: 223 RVA: 0x00006329 File Offset: 0x00004529
	private void Awake()
	{
		this.defaultScale = this.dayText.transform.localScale;
	}

	// Token: 0x060000E0 RID: 224 RVA: 0x00006341 File Offset: 0x00004541
	public void SetDay(int day)
	{
		Invoke(nameof(StartFade), 2f);
		this.dayText.text = string.Format("-DAY {0}-", day);
	}

	// Token: 0x060000E1 RID: 225 RVA: 0x00006370 File Offset: 0x00004570
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
		Invoke(nameof(FadeAway), 4f);
		Invoke(nameof(Hide), 4f + this.fadeTime);
		this.done = false;
		this.sfx.Play();
	}

	// Token: 0x060000E2 RID: 226 RVA: 0x00006458 File Offset: 0x00004658
	private void Update()
	{
		Vector3 b = Vector3.one * this.scaleSpeed * Time.deltaTime;
		this.desiredScale += b;
		this.dayText.transform.localScale = Vector3.Lerp(this.dayText.transform.localScale, this.desiredScale, Time.deltaTime * 3f);
	}

	// Token: 0x060000E3 RID: 227 RVA: 0x00002F0F File Offset: 0x0000110F
	private void Hide()
	{
		base.gameObject.SetActive(false);
	}

	// Token: 0x060000E4 RID: 228 RVA: 0x000064C8 File Offset: 0x000046C8
	private void FadeAway()
	{
		this.dayText.CrossFadeAlpha(0f, this.fadeTime, true);
	}

	// Token: 0x040000E8 RID: 232
	public TextMeshProUGUI dayText;

	// Token: 0x040000E9 RID: 233
	private Vector3 desiredScale;

	// Token: 0x040000EA RID: 234
	private Vector3 defaultScale;

	// Token: 0x040000EB RID: 235
	private bool done;

	// Token: 0x040000EC RID: 236
	private float fadeTime = 2f;

	// Token: 0x040000ED RID: 237
	private float scaleSpeed = -0.2f;

	// Token: 0x040000EE RID: 238
	public AudioSource sfx;
}
