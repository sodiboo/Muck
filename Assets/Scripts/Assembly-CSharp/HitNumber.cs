using TMPro;
using UnityEngine;

public class HitNumber : MonoBehaviour
{
    private TextMeshProUGUI text;

    private float speed = 10f;

    private Vector3 defaultScale;

    private Vector3 dir;

    private Vector3 hitDir;

    private void Awake()
    {
        Invoke(nameof(StartFade), 1.5f);
        defaultScale = base.transform.localScale * 0.5f;
        text = GetComponentInChildren<TextMeshProUGUI>();
        float num = 0.5f;
        dir = new Vector3(Random.Range(0f - num, num), Random.Range(0.75f, 1.25f), Random.Range(0f - num, num));
    }

    private void Update()
    {
        speed = Mathf.Lerp(speed, 0.2f, Time.deltaTime * 10f);
        base.transform.position += (dir + hitDir) * Time.deltaTime * speed;
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, defaultScale * 0.5f, Time.deltaTime * 0.3f);
    }

    public void SetTextAndDir(float damage, Vector3 dir, HitEffect hitEffect)
    {
        hitDir = -dir;
        string colorName = HitEffectExtension.GetColorName(hitEffect);
        text.text = "<color=" + colorName + ">" + damage;
    }

    private void StartFade()
    {
        text.CrossFadeAlpha(0f, 1f, ignoreTimeScale: true);
        Invoke(nameof(DestroySelf), 1f);
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }
}
