using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ItemInfo : MonoBehaviour
{
    public TextMeshProUGUI text;

    public RawImage image;

    public float padding;

    private Vector3 defaultTextPos;

    public static ItemInfo Instance;

    private bool leftCorner;

    private void Awake()
    {
        Instance = this;
        defaultTextPos = text.transform.localPosition;
    }

    private void Update()
    {
        base.transform.position = Input.mousePosition;
        FitToText();
    }

    private void OnEnable()
    {
        SetText("");
    }

    public void FitToText()
    {
        Vector2 sizeDelta = new Vector2(text.mesh.bounds.size.x, text.mesh.bounds.size.y);
        sizeDelta.x += padding;
        sizeDelta.y += padding;
        if (leftCorner)
        {
            text.transform.localPosition = -defaultTextPos - new Vector3(sizeDelta.x, sizeDelta.y, 0f);
        }
        else
        {
            text.transform.localPosition = defaultTextPos;
        }
        image.rectTransform.sizeDelta = sizeDelta;
        image.rectTransform.position = text.rectTransform.position;
        Vector3 vector = new Vector3(padding / 2f, 0f, 0f);
        image.rectTransform.localPosition = text.rectTransform.localPosition - vector;
    }

    public void SetText(string t, bool leftCorner = false)
    {
        text.text = t;
        if (t == "")
        {
            Fade(0f);
        }
        else
        {
            Fade(1f);
        }
        FitToText();
        if (leftCorner)
        {
            this.leftCorner = true;
        }
        else
        {
            this.leftCorner = false;
        }
    }

    public void Fade(float opacity, float time = 0.2f)
    {
        text.CrossFadeAlpha(opacity, time, ignoreTimeScale: true);
        image.CrossFadeAlpha(opacity, time, ignoreTimeScale: true);
    }
}
