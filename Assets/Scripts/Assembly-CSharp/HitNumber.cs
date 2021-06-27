using TMPro;
using UnityEngine;

// Token: 0x0200004B RID: 75
public class HitNumber : MonoBehaviour
{
	// Token: 0x060001B1 RID: 433 RVA: 0x0000A960 File Offset: 0x00008B60
	private void Awake()
	{
		Invoke(nameof(StartFade), 1.5f);
		this.defaultScale = base.transform.localScale * 0.5f;
		this.text = base.GetComponentInChildren<TextMeshProUGUI>();
		float num = 0.5f;
		this.dir = new Vector3(Random.Range(-num, num), Random.Range(0.75f, 1.25f), Random.Range(-num, num));
	}

	// Token: 0x060001B2 RID: 434 RVA: 0x0000A9D4 File Offset: 0x00008BD4
	private void Update()
	{
		this.speed = Mathf.Lerp(this.speed, 0.2f, Time.deltaTime * 10f);
		base.transform.position += (this.dir + this.hitDir) * Time.deltaTime * this.speed;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.defaultScale * 0.5f, Time.deltaTime * 0.3f);
	}

	// Token: 0x060001B3 RID: 435 RVA: 0x0000AA74 File Offset: 0x00008C74
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

	// Token: 0x060001B4 RID: 436 RVA: 0x0000AAC7 File Offset: 0x00008CC7
	private void StartFade()
	{
		this.text.CrossFadeAlpha(0f, 1f, true);
		Invoke(nameof(DestroySelf), 1f);
	}

	// Token: 0x060001B5 RID: 437 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x040001B7 RID: 439
	private TextMeshProUGUI text;

	// Token: 0x040001B8 RID: 440
	private float speed = 10f;

	// Token: 0x040001B9 RID: 441
	private Vector3 defaultScale;

	// Token: 0x040001BA RID: 442
	private Vector3 dir;

	// Token: 0x040001BB RID: 443
	private Vector3 hitDir;
}
