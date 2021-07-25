using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ItemPickedupUI : MonoBehaviour
{
    public Image icon;

    public TextMeshProUGUI item;

    private HorizontalLayoutGroup layout;

    private float desiredPad;

    private float fadeStart = 6f;

    private float fadeTime = 1f;

    private float padLeft;

    private void Awake()
    {
        layout = GetComponent<HorizontalLayoutGroup>();
        desiredPad = layout.padding.left;
        layout.padding.left = -300;
        padLeft = layout.padding.left;
        Invoke(nameof(StartFade), fadeStart);
    }

    private void StartFade()
    {
        icon.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        item.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        Invoke(nameof(DestroySelf), fadeTime);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }

    public void SetItem(InventoryItem i)
    {
        if (i.amount < 1)
        {
            icon.sprite = null;
            item.text = "Inventory full";
        }
        else
        {
            icon.sprite = i.sprite;
            item.text = $"{i.amount}x {i.name}";
        }
    }

    public void SetPowerup(Powerup i)
    {
        icon.sprite = i.sprite;
        item.text = i.name + "\n<size=75%>" + i.description;
    }

    public void Update()
    {
        padLeft = Mathf.Lerp(padLeft, desiredPad, Time.deltaTime * 7f);
        RectOffset rectOffset = new RectOffset(layout.padding.left, layout.padding.right, layout.padding.top, layout.padding.bottom);
        rectOffset.left = (int)padLeft;
        layout.padding = rectOffset;
        layout.padding.left = (int)padLeft;
    }
}
