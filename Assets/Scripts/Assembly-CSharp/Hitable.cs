using System;
using UnityEngine;

// Token: 0x02000092 RID: 146
public abstract class Hitable : MonoBehaviour, SharedObject
{
	// Token: 0x06000380 RID: 896 RVA: 0x000133A8 File Offset: 0x000115A8
	protected void Awake()
	{
		this.hp = this.maxHp;
		foreach (Collider collider in base.GetComponents<Collider>())
		{
			if (!collider.isTrigger)
			{
				this.hitCollider = collider;
			}
		}
	}

	// Token: 0x06000381 RID: 897
	public abstract void Hit(int damage, float sharpness, int HitEffect, Vector3 pos);

	// Token: 0x06000382 RID: 898 RVA: 0x000133EC File Offset: 0x000115EC
	public virtual int Damage(int newHp, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 normalized = (GameManager.players[fromClient].transform.position + Vector3.up * 1.5f - pos).normalized;
		this.SpawnParticles(pos, normalized, hitEffect);
		int num = this.hp - newHp;
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < 100f)
		{
			Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)num, normalized, (HitEffect)hitEffect);
		}
		this.hp = newHp;
		if (this.hp <= 0)
		{
			this.hp = 0;
			this.KillObject(normalized);
		}
		this.ExecuteHit();
		return this.hp;
	}

	// Token: 0x06000383 RID: 899 RVA: 0x000134B8 File Offset: 0x000116B8
	protected virtual void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) > 100f)
		{
			return;
		}
		GameObject gameObject = Instantiate<GameObject>(this.hitFx);
		gameObject.transform.position = pos;
		gameObject.transform.rotation = Quaternion.LookRotation(dir);
		if (hitEffect != 0)
		{
			HitParticles componentInChildren = gameObject.GetComponentInChildren<HitParticles>();
			if (componentInChildren != null)
			{
				componentInChildren.SetEffect((HitEffect)hitEffect);
			}
		}
	}

	// Token: 0x06000384 RID: 900 RVA: 0x00013531 File Offset: 0x00011731
	protected virtual void SpawnDeathParticles()
	{
		Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation);
	}

	// Token: 0x06000385 RID: 901 RVA: 0x0001355A File Offset: 0x0001175A
	public void KillObject(Vector3 dir)
	{
		this.SpawnDeathParticles();
		this.OnKill(dir);
	}

	// Token: 0x06000386 RID: 902
	public abstract void OnKill(Vector3 dir);

	// Token: 0x06000387 RID: 903
	protected abstract void ExecuteHit();

	// Token: 0x06000388 RID: 904 RVA: 0x00013569 File Offset: 0x00011769
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000389 RID: 905 RVA: 0x00013572 File Offset: 0x00011772
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400037F RID: 895
	protected int id;

	// Token: 0x04000380 RID: 896
	public string entityName;

	// Token: 0x04000381 RID: 897
	public bool canHitMoreThanOnce;

	// Token: 0x04000382 RID: 898
	public LootDrop dropTable;

	// Token: 0x04000383 RID: 899
	public int hp;

	// Token: 0x04000384 RID: 900
	public int maxHp;

	// Token: 0x04000385 RID: 901
	public GameObject destroyFx;

	// Token: 0x04000386 RID: 902
	public GameObject hitFx;

	// Token: 0x04000387 RID: 903
	public GameObject numberFx;

	// Token: 0x04000388 RID: 904
	protected Collider hitCollider;
}
