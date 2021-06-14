using System;
using UnityEngine;

// Token: 0x02000088 RID: 136
public class HitableResource : Hitable
{
	// Token: 0x060002FB RID: 763 RVA: 0x00013044 File Offset: 0x00011244
	protected void Start()
	{
		Material material = base.GetComponentInChildren<Renderer>().materials[0];
		this.materialText = material.mainTexture;
	}

	// Token: 0x060002FC RID: 764 RVA: 0x0001306C File Offset: 0x0001126C
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
	Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(0f, normalized, (HitEffect)hitEffect);
	}

	// Token: 0x060002FD RID: 765 RVA: 0x0000423C File Offset: 0x0000243C
	protected override void SpawnDeathParticles()
	{
	Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation).GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
	}

	// Token: 0x060002FE RID: 766 RVA: 0x00013134 File Offset: 0x00011334
	protected override void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		GameObject gameObject =Instantiate<GameObject>(this.hitFx);
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

	// Token: 0x060002FF RID: 767 RVA: 0x00004279 File Offset: 0x00002479
	public override void OnKill(Vector3 dir)
	{
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x06000300 RID: 768 RVA: 0x0000428B File Offset: 0x0000248B
	private void OnEnable()
	{
		if (this.dontScale)
		{
			return;
		}
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x06000301 RID: 769 RVA: 0x0001319C File Offset: 0x0001139C
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

	// Token: 0x06000302 RID: 770 RVA: 0x000042A6 File Offset: 0x000024A6
	public void SetDefaultScale(Vector3 scale)
	{
		this.defaultScale = scale;
	}

	// Token: 0x06000303 RID: 771 RVA: 0x000042AF File Offset: 0x000024AF
	protected override void ExecuteHit()
	{
		MonoBehaviour.print("changing scale lol");
		this.currentScale = this.defaultScale * 0.7f;
	}

	// Token: 0x06000304 RID: 772 RVA: 0x000042D1 File Offset: 0x000024D1
	public void PopIn()
	{
		base.transform.localScale = Vector3.zero;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x06000305 RID: 773 RVA: 0x000131F8 File Offset: 0x000113F8
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

	// Token: 0x040002F9 RID: 761
	public InventoryItem.ItemType compatibleItem;

	// Token: 0x040002FA RID: 762
	public int minTier;

	// Token: 0x040002FB RID: 763
	[Header("Loot")]
	public InventoryItem dropItem;

	// Token: 0x040002FC RID: 764
	public InventoryItem[] dropExtra;

	// Token: 0x040002FD RID: 765
	public float[] dropChance;

	// Token: 0x040002FE RID: 766
	public int amount;

	// Token: 0x040002FF RID: 767
	public bool dontScale;

	// Token: 0x04000300 RID: 768
	private Texture materialText;

	// Token: 0x04000301 RID: 769
	public int poolId;

	// Token: 0x04000302 RID: 770
	private Vector3 defaultScale;

	// Token: 0x04000303 RID: 771
	private float scaleMultiplier;

	// Token: 0x04000304 RID: 772
	private Vector3 desiredScale;

	// Token: 0x04000305 RID: 773
	private Vector3 currentScale;
}
