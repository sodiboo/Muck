using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TutorialTaskUI : MonoBehaviour
{
    public RawImage overlay;

    public RawImage icon;

    public TextMeshProUGUI item;

    private HorizontalLayoutGroup layout;

    public Texture checkedBox;

    private float desiredPad;

    private float fadeStart = 1.5f;

    private float fadeTime = 1.5f;

    private float padUp;

    private void Awake()
    {
        layout = GetComponent<HorizontalLayoutGroup>();
        desiredPad = layout.padding.left;
        layout.padding.left = 400;
        padUp = layout.padding.left;
    }

    public void StartFade()
    {
        icon.texture = checkedBox;
        icon.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        item.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        overlay.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
        Invoke("DestroySelf", fadeTime);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }

    public void SetItem(InventoryItem i, string text)
    {
        text = text.Replace("[inv]", string.Concat("[", InputManager.inventory, "]"));
        text = text.Replace("[m2]", string.Concat("[", InputManager.rightClick, "]"));
        item.text = text;
    }

    public void Update()
    {
        padUp = Mathf.Lerp(padUp, desiredPad, Time.deltaTime * 6f);
        RectOffset rectOffset = new RectOffset(layout.padding.left, layout.padding.right, layout.padding.top, layout.padding.bottom);
        rectOffset.left = (int)padUp;
        layout.padding = rectOffset;
    }
}
