using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ItemInfo : MonoBehaviour
{
	private void Awake()
	{
		ItemInfo.Instance = this;
		this.defaultTextPos = this.text.transform.localPosition;
	}

	private void Update()
	{
		base.transform.position = Input.mousePosition;
		this.FitToText();
	}

	private void OnEnable()
	{
		this.SetText("", false);
	}

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

	public void Fade(float opacity, float time = 0.2f)
	{
		this.text.CrossFadeAlpha(opacity, time, true);
		this.image.CrossFadeAlpha(opacity, time, true);
	}

	public TextMeshProUGUI text;

	public RawImage image;

	public float padding;

	private Vector3 defaultTextPos;

	public static ItemInfo Instance;

	private bool leftCorner;
}
