using TMPro;
using UnityEngine;

// Token: 0x0200003F RID: 63
public class HitNumber : MonoBehaviour
{
	// Token: 0x0600014D RID: 333 RVA: 0x0000CD58 File Offset: 0x0000AF58
	private void Awake()
	{
		base.Invoke("StartFade", 1.5f);
		this.defaultScale = base.transform.localScale * 0.5f;
		this.text = base.GetComponentInChildren<TextMeshProUGUI>();
		float num = 0.5f;
		this.dir = new Vector3(Random.Range(-num, num), Random.Range(0.75f, 1.25f), Random.Range(-num, num));
	}

	// Token: 0x0600014E RID: 334 RVA: 0x0000CDCC File Offset: 0x0000AFCC
	private void Update()
	{
		this.speed = Mathf.Lerp(this.speed, 0.2f, Time.deltaTime * 10f);
		base.transform.position += (this.dir + this.hitDir) * Time.deltaTime * this.speed;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.defaultScale * 0.5f, Time.deltaTime * 0.3f);
	}

	// Token: 0x0600014F RID: 335 RVA: 0x0000CE6C File Offset: 0x0000B06C
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

	// Token: 0x06000150 RID: 336 RVA: 0x00003057 File Offset: 0x00001257
	private void StartFade()
	{
		this.text.CrossFadeAlpha(0f, 1f, true);
		base.Invoke("DestroySelf", 1f);
	}

	// Token: 0x06000151 RID: 337 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x0400014C RID: 332
	private TextMeshProUGUI text;

	// Token: 0x0400014D RID: 333
	private float speed = 10f;

	// Token: 0x0400014E RID: 334
	private Vector3 defaultScale;

	// Token: 0x0400014F RID: 335
	private Vector3 dir;

	// Token: 0x04000150 RID: 336
	private Vector3 hitDir;
}
