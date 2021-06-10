
using TMPro;
using UnityEngine;

// Token: 0x02000032 RID: 50
public class HitNumber : MonoBehaviour
{
	// Token: 0x06000126 RID: 294 RVA: 0x00007FD8 File Offset: 0x000061D8
	private void Awake()
	{
		base.Invoke("StartFade", 1.5f);
		this.defaultScale = base.transform.localScale * 0.5f;
		this.text = base.GetComponentInChildren<TextMeshProUGUI>();
		float num = 0.5f;
		this.dir = new Vector3(Random.Range(-num, num), Random.Range(0.75f, 1.25f), Random.Range(-num, num));
	}

	// Token: 0x06000127 RID: 295 RVA: 0x0000804C File Offset: 0x0000624C
	private void Update()
	{
		this.speed = Mathf.Lerp(this.speed, 0.2f, Time.deltaTime * 10f);
		base.transform.position += (this.dir + this.hitDir) * Time.deltaTime * this.speed;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.defaultScale * 0.5f, Time.deltaTime * 0.3f);
	}

	// Token: 0x06000128 RID: 296 RVA: 0x000080EC File Offset: 0x000062EC
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

	// Token: 0x06000129 RID: 297 RVA: 0x0000813F File Offset: 0x0000633F
	private void StartFade()
	{
		this.text.CrossFadeAlpha(0f, 1f, true);
		base.Invoke("DestroySelf", 1f);
	}

	// Token: 0x0600012A RID: 298 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x04000117 RID: 279
	private TextMeshProUGUI text;

	// Token: 0x04000118 RID: 280
	private float speed = 10f;

	// Token: 0x04000119 RID: 281
	private Vector3 defaultScale;

	// Token: 0x0400011A RID: 282
	private Vector3 dir;

	// Token: 0x0400011B RID: 283
	private Vector3 hitDir;
}
