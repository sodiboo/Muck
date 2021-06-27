using System;
using TMPro;
using UnityEngine;

public class DayUi : MonoBehaviour
{
	private void Awake()
	{
		this.defaultScale = this.dayText.transform.localScale;
	}

	public void SetDay(int day)
	{
		Invoke(nameof(StartFade), 2f);
		this.dayText.text = string.Format("-DAY {0}-", day);
	}

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

	private void Update()
	{
		Vector3 b = Vector3.one * this.scaleSpeed * Time.deltaTime;
		this.desiredScale += b;
		this.dayText.transform.localScale = Vector3.Lerp(this.dayText.transform.localScale, this.desiredScale, Time.deltaTime * 3f);
	}

	private void Hide()
	{
		base.gameObject.SetActive(false);
	}

	private void FadeAway()
	{
		this.dayText.CrossFadeAlpha(0f, this.fadeTime, true);
	}

	public TextMeshProUGUI dayText;

	private Vector3 desiredScale;

	private Vector3 defaultScale;

	private bool done;

	private float fadeTime = 2f;

	private float scaleSpeed = -0.2f;

	public AudioSource sfx;
}
