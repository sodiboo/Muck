using TMPro;
using UnityEngine;

public class DayUi : MonoBehaviour
{
    public TextMeshProUGUI dayText;

    private Vector3 desiredScale;

    private Vector3 defaultScale;

    private bool done;

    private float fadeTime = 2f;

    private float scaleSpeed = -0.2f;

    public AudioSource sfx;

    private void Awake()
    {
        defaultScale = dayText.transform.localScale;
    }

    public void SetDay(int day)
    {
        Invoke(nameof(StartFade), 2f);
        dayText.text = $"-DAY {day}-";
    }

    private void StartFade()
    {
        if (GameManager.state == GameManager.GameState.Playing)
        {
            base.gameObject.SetActive(value: true);
            if (defaultScale == Vector3.zero)
            {
                defaultScale = dayText.transform.localScale;
            }
            dayText.GetComponent<CanvasRenderer>().SetAlpha(0f);
            dayText.transform.localScale = defaultScale * 3f;
            desiredScale = defaultScale * 1.2f;
            dayText.CrossFadeAlpha(1f, fadeTime, ignoreTimeScale: true);
            Invoke(nameof(FadeAway), 4f);
            Invoke(nameof(Hide), 4f + fadeTime);
            done = false;
            sfx.Play();
        }
    }

    private void Update()
    {
        Vector3 vector = Vector3.one * scaleSpeed * Time.deltaTime;
        desiredScale += vector;
        dayText.transform.localScale = Vector3.Lerp(dayText.transform.localScale, desiredScale, Time.deltaTime * 3f);
    }

    private void Hide()
    {
        base.gameObject.SetActive(value: false);
    }

    private void FadeAway()
    {
        dayText.CrossFadeAlpha(0f, fadeTime, ignoreTimeScale: true);
    }
}
