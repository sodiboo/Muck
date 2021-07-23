using UnityEngine;
using UnityEngine.UI;

public class FadeScreen : MonoBehaviour
{
    public RawImage blackImg;

    public static FadeScreen Instance;

    private void Awake()
    {
        Instance = this;
        blackImg.CrossFadeAlpha(0f, 0f, ignoreTimeScale: true);
        blackImg.gameObject.SetActive(value: true);
    }

    public void StartFade(float alpha, float duration)
    {
        blackImg.CrossFadeAlpha(alpha, duration, ignoreTimeScale: true);
    }
}
