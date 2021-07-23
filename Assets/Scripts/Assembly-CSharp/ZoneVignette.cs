using UnityEngine;
using UnityEngine.UI;

public class ZoneVignette : MonoBehaviour
{
    private float intensity;

    private RawImage img;

    public static ZoneVignette Instance;

    private Vector3 desiredScale = Vector3.one;

    private void Awake()
    {
        Instance = this;
        img = GetComponent<RawImage>();
        img.CrossFadeAlpha(0f, 0f, ignoreTimeScale: true);
        Color color = img.color;
        color.a = 0.8f;
        img.color = color;
    }

    public void SetVignette(bool on)
    {
        if (on)
        {
            img.CrossFadeAlpha(0.8f, 3f, ignoreTimeScale: true);
            desiredScale = Vector3.one * 1.6f;
        }
        else
        {
            img.CrossFadeAlpha(0f, 2f, ignoreTimeScale: true);
            desiredScale = Vector3.one * 1f;
        }
    }

    private void Update()
    {
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, desiredScale, Time.deltaTime * 0.2f);
    }
}
