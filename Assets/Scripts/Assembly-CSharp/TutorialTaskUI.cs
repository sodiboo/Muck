using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TutorialTaskUI : MonoBehaviour
{
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.left;
		this.layout.padding.left = 400;
		this.padUp = (float)this.layout.padding.left;
	}

	public void StartFade()
	{
		this.icon.texture = this.checkedBox;
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		Invoke(nameof(DestroySelf), this.fadeTime);
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	public void SetItem(InventoryItem i, string text)
	{
		text = text.Replace("[inv]", "[" + InputManager.inventory + "]");
		text = text.Replace("[m2]", "[" + InputManager.rightClick + "]");
		this.item.text = text;
	}

	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 6f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.left = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	public RawImage overlay;

	public RawImage icon;

	public TextMeshProUGUI item;

	private HorizontalLayoutGroup layout;

	public Texture checkedBox;

	private float desiredPad;

	private float fadeStart = 1.5f;

	private float fadeTime = 1.5f;

	private float padUp;
}
