using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ItemUnlcokedUI : MonoBehaviour
{
	private void Awake()
	{
		this.layout = base.GetComponent<HorizontalLayoutGroup>();
		this.desiredPad = (float)this.layout.padding.top;
		this.layout.padding.top = 400;
		this.padUp = (float)this.layout.padding.top;
		Invoke(nameof(StartFade), this.fadeStart);
	}

	private void StartFade()
	{
		this.icon.CrossFadeAlpha(0f, this.fadeTime, true);
		this.item.CrossFadeAlpha(0f, this.fadeTime, true);
		this.overlay.CrossFadeAlpha(0f, this.fadeTime, true);
		Invoke(nameof(DestroySelf), this.fadeTime);
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	public void SetItem(InventoryItem i)
	{
		this.icon.sprite = i.sprite;
		this.item.text = "Unlocked " + i.name;
	}

	public void Update()
	{
		this.padUp = Mathf.Lerp(this.padUp, this.desiredPad, Time.deltaTime * 10f);
		RectOffset rectOffset = new RectOffset(this.layout.padding.left, this.layout.padding.right, this.layout.padding.top, this.layout.padding.bottom);
		rectOffset.top = (int)this.padUp;
		this.layout.padding = rectOffset;
	}

	public Image overlay;

	public Image icon;

	public TextMeshProUGUI item;

	private HorizontalLayoutGroup layout;

	private float desiredPad;

	private float fadeStart = 1.5f;

	private float fadeTime = 0.5f;

	private float padUp;
}
