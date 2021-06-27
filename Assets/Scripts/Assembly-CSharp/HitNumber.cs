using TMPro;
using UnityEngine;

public class HitNumber : MonoBehaviour
{
	private void Awake()
	{
		Invoke(nameof(StartFade), 1.5f);
		this.defaultScale = base.transform.localScale * 0.5f;
		this.text = base.GetComponentInChildren<TextMeshProUGUI>();
		float num = 0.5f;
		this.dir = new Vector3(Random.Range(-num, num), Random.Range(0.75f, 1.25f), Random.Range(-num, num));
	}

	private void Update()
	{
		this.speed = Mathf.Lerp(this.speed, 0.2f, Time.deltaTime * 10f);
		base.transform.position += (this.dir + this.hitDir) * Time.deltaTime * this.speed;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.defaultScale * 0.5f, Time.deltaTime * 0.3f);
	}

	public void SetTextAndDir(float damage, Vector3 dir, HitEffect hitEffect)
	{
		this.hitDir = -dir;
		string colorName = HitEffectExtension.GetColorName(hitEffect);
		this.text.text = string.Concat(new object[]
		{
			"<color=",
			colorName,
			">",
			damage
		});
	}

	private void StartFade()
	{
		this.text.CrossFadeAlpha(0f, 1f, true);
		Invoke(nameof(DestroySelf), 1f);
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	private TextMeshProUGUI text;

	private float speed = 10f;

	private Vector3 defaultScale;

	private Vector3 dir;

	private Vector3 hitDir;
}
