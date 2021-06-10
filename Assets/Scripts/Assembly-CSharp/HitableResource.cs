
using UnityEngine;

// Token: 0x02000070 RID: 112
public class HitableResource : Hitable
{
	// Token: 0x060002C1 RID: 705 RVA: 0x0000EF40 File Offset: 0x0000D140
	protected void Start()
	{
		Material material = base.GetComponentInChildren<Renderer>().materials[0];
		this.materialText = material.mainTexture;
	}

	// Token: 0x060002C2 RID: 706 RVA: 0x0000EF68 File Offset: 0x0000D168
	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 pos)
	{
		if (damage > 0)
		{
			ClientSend.PlayerHitObject(damage, this.id, hitEffect, pos);
			return;
		}
		Vector3 vector = GameManager.players[LocalClient.instance.myId].transform.position + Vector3.up * 1.5f;
		Vector3 normalized = (vector - pos).normalized;
		pos = this.hitCollider.ClosestPoint(vector);
		this.SpawnParticles(pos, normalized, hitEffect);
		float d = Vector3.Distance(pos, vector);
		pos += normalized * d * 0.5f;
	Instantiate(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(0f, normalized, (HitEffect)hitEffect);
	}

	// Token: 0x060002C3 RID: 707 RVA: 0x0000F02E File Offset: 0x0000D22E
	protected override void SpawnDeathParticles()
	{
	Instantiate(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation).GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
	}

	// Token: 0x060002C4 RID: 708 RVA: 0x0000F06C File Offset: 0x0000D26C
	protected override void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		GameObject gameObject =Instantiate(this.hitFx);
		gameObject.transform.position = pos;
		gameObject.transform.rotation = Quaternion.LookRotation(dir);
		gameObject.GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
		if (hitEffect != 0)
		{
			HitParticles componentInChildren = gameObject.GetComponentInChildren<HitParticles>();
			if (componentInChildren != null)
			{
				componentInChildren.SetEffect((HitEffect)hitEffect);
			}
		}
	}

	// Token: 0x060002C5 RID: 709 RVA: 0x0000F0D4 File Offset: 0x0000D2D4
	public override void OnKill(Vector3 dir)
	{
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x060002C6 RID: 710 RVA: 0x0000F0E6 File Offset: 0x0000D2E6
	private void OnEnable()
	{
		if (this.dontScale)
		{
			return;
		}
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x060002C7 RID: 711 RVA: 0x0000F104 File Offset: 0x0000D304
	private new void Awake()
	{
		base.Awake();
		if (this.dontScale)
		{
			return;
		}
		if (this.defaultScale == Vector3.zero)
		{
			this.defaultScale = base.transform.localScale;
		}
		this.desiredScale = this.defaultScale;
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x060002C8 RID: 712 RVA: 0x0000F15F File Offset: 0x0000D35F
	public void SetDefaultScale(Vector3 scale)
	{
		this.defaultScale = scale;
	}

	// Token: 0x060002C9 RID: 713 RVA: 0x0000F168 File Offset: 0x0000D368
	protected override void ExecuteHit()
	{
		MonoBehaviour.print("changing scale lol");
		this.currentScale = this.defaultScale * 0.7f;
	}

	// Token: 0x060002CA RID: 714 RVA: 0x0000F18A File Offset: 0x0000D38A
	public void PopIn()
	{
		base.transform.localScale = Vector3.zero;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x060002CB RID: 715 RVA: 0x0000F1A8 File Offset: 0x0000D3A8
	private void Update()
	{
		if (this.dontScale)
		{
			return;
		}
		if (Mathf.Abs(base.transform.localScale.x - this.desiredScale.x) < 0.002f && Mathf.Abs(this.desiredScale.x - this.currentScale.x) < 0.002f)
		{
			return;
		}
		this.currentScale = Vector3.Lerp(this.currentScale, this.desiredScale, Time.deltaTime * 10f);
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.currentScale, Time.deltaTime * 15f);
	}

	// Token: 0x04000295 RID: 661
	public InventoryItem.ItemType compatibleItem;

	// Token: 0x04000296 RID: 662
	public int minTier;

	// Token: 0x04000297 RID: 663
	[Header("Loot")]
	public InventoryItem dropItem;

	// Token: 0x04000298 RID: 664
	public InventoryItem[] dropExtra;

	// Token: 0x04000299 RID: 665
	public float[] dropChance;

	// Token: 0x0400029A RID: 666
	public int amount;

	// Token: 0x0400029B RID: 667
	public bool dontScale;

	// Token: 0x0400029C RID: 668
	private Texture materialText;

	// Token: 0x0400029D RID: 669
	public int poolId;

	// Token: 0x0400029E RID: 670
	private Vector3 defaultScale;

	// Token: 0x0400029F RID: 671
	private float scaleMultiplier;

	// Token: 0x040002A0 RID: 672
	private Vector3 desiredScale;

	// Token: 0x040002A1 RID: 673
	private Vector3 currentScale;
}
