using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ItemUnlcokedUI : MonoBehaviour
{
    public Image overlay;

    public Image icon;

    public TextMeshProUGUI item;

    private HorizontalLayoutGroup layout;

    private float desiredPad;

    private float fadeStart = 1.5f;

    private float fadeTime = 0.5f;

    private float padUp;

    private void Awake()
    {
        layout = GetComponent<HorizontalLayoutGroup>();
        desiredPad = layout.padding.top;
        layout.padding.top = 400;
        padUp = layout.padding.top;
        Invoke("StartFade", fadeStart);
    }

    private void StartFade()
    {
        icon.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        item.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        overlay.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        Invoke("DestroySelf", fadeTime);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }

    public void SetItem(InventoryItem i)
    {
        icon.sprite = i.sprite;
        item.text = "Unlocked " + i.name;
    }

    public void Update()
    {
        padUp = Mathf.Lerp(padUp, desiredPad, Time.deltaTime * 10f);
        RectOffset rectOffset = new RectOffset(layout.padding.left, layout.padding.right, layout.padding.top, layout.padding.bottom);
        rectOffset.top = (int)padUp;
        layout.padding = rectOffset;
    }
}
