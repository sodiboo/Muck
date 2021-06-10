
using TMPro;
using UnityEngine;

// Token: 0x0200001A RID: 26
public class DayUi : MonoBehaviour
{
	// Token: 0x060000A1 RID: 161 RVA: 0x0000538D File Offset: 0x0000358D
	private void Awake()
	{
		this.defaultScale = this.dayText.transform.localScale;
	}

	// Token: 0x060000A2 RID: 162 RVA: 0x000053A5 File Offset: 0x000035A5
	public void SetDay(int day)
	{
		base.Invoke("StartFade", 2f);
		this.dayText.text = string.Format("-DAY {0}-", day);
	}

	// Token: 0x060000A3 RID: 163 RVA: 0x000053D4 File Offset: 0x000035D4
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
		base.Invoke("FadeAway", 4f);
		base.Invoke("Hide", 4f + this.fadeTime);
		this.done = false;
		this.sfx.Play();
	}

	// Token: 0x060000A4 RID: 164 RVA: 0x000054BC File Offset: 0x000036BC
	private void Update()
	{
		Vector3 b = Vector3.one * this.scaleSpeed * Time.deltaTime;
		this.desiredScale += b;
		this.dayText.transform.localScale = Vector3.Lerp(this.dayText.transform.localScale, this.desiredScale, Time.deltaTime * 3f);
	}

	// Token: 0x060000A5 RID: 165 RVA: 0x0000552C File Offset: 0x0000372C
	private void Hide()
	{
		base.gameObject.SetActive(false);
	}

	// Token: 0x060000A6 RID: 166 RVA: 0x0000553A File Offset: 0x0000373A
	private void FadeAway()
	{
		this.dayText.CrossFadeAlpha(0f, this.fadeTime, true);
	}

	// Token: 0x0400009C RID: 156
	public TextMeshProUGUI dayText;

	// Token: 0x0400009D RID: 157
	private Vector3 desiredScale;

	// Token: 0x0400009E RID: 158
	private Vector3 defaultScale;

	// Token: 0x0400009F RID: 159
	private bool done;

	// Token: 0x040000A0 RID: 160
	private float fadeTime = 2f;

	// Token: 0x040000A1 RID: 161
	private float scaleSpeed = -0.2f;

	// Token: 0x040000A2 RID: 162
	public AudioSource sfx;
}
