using System;
using UnityEngine;

// Token: 0x02000096 RID: 150
public class HitableResource : Hitable
{
	// Token: 0x0600039A RID: 922 RVA: 0x00013760 File Offset: 0x00011960
	protected void Start()
	{
		Material material = base.GetComponentInChildren<Renderer>().materials[0];
		this.materialText = material.mainTexture;
	}

	// Token: 0x0600039B RID: 923 RVA: 0x00013788 File Offset: 0x00011988
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

	// Token: 0x0600039C RID: 924 RVA: 0x0001384E File Offset: 0x00011A4E
	protected override void SpawnDeathParticles()
	{
		Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation).GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
	}

	// Token: 0x0600039D RID: 925 RVA: 0x0001388C File Offset: 0x00011A8C
	protected override void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		GameObject gameObject = Instantiate<GameObject>(this.hitFx);
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

	// Token: 0x0600039E RID: 926 RVA: 0x000138F4 File Offset: 0x00011AF4
	public override void OnKill(Vector3 dir)
	{
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x0600039F RID: 927 RVA: 0x00013906 File Offset: 0x00011B06
	private void OnEnable()
	{
		if (this.dontScale)
		{
			return;
		}
		base.transform.localScale = Vector3.zero;
	}

	// Token: 0x060003A0 RID: 928 RVA: 0x00013924 File Offset: 0x00011B24
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

	// Token: 0x060003A1 RID: 929 RVA: 0x0001397F File Offset: 0x00011B7F
	public void SetDefaultScale(Vector3 scale)
	{
		this.defaultScale = scale;
	}

	// Token: 0x060003A2 RID: 930 RVA: 0x00013988 File Offset: 0x00011B88
	protected override void ExecuteHit()
	{
		MonoBehaviour.print("changing scale lol");
		this.currentScale = this.defaultScale * 0.7f;
	}

	// Token: 0x060003A3 RID: 931 RVA: 0x000139AA File Offset: 0x00011BAA
	public void PopIn()
	{
		base.transform.localScale = Vector3.zero;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x060003A4 RID: 932 RVA: 0x000139C8 File Offset: 0x00011BC8
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

	// Token: 0x0400038D RID: 909
	public InventoryItem.ItemType compatibleItem;

	// Token: 0x0400038E RID: 910
	public int minTier;

	// Token: 0x0400038F RID: 911
	[Header("Loot")]
	public InventoryItem dropItem;

	// Token: 0x04000390 RID: 912
	public InventoryItem[] dropExtra;

	// Token: 0x04000391 RID: 913
	public float[] dropChance;

	// Token: 0x04000392 RID: 914
	public int amount;

	// Token: 0x04000393 RID: 915
	public bool dontScale;

	// Token: 0x04000394 RID: 916
	private Texture materialText;

	// Token: 0x04000395 RID: 917
	public int poolId;

	// Token: 0x04000396 RID: 918
	private Vector3 defaultScale;

	// Token: 0x04000397 RID: 919
	private float scaleMultiplier;

	// Token: 0x04000398 RID: 920
	private Vector3 desiredScale;

	// Token: 0x04000399 RID: 921
	private Vector3 currentScale;
}
