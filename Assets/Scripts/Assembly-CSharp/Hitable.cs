using System;
using UnityEngine;

// Token: 0x02000083 RID: 131
public abstract class Hitable : MonoBehaviour, SharedObject
{
	// Token: 0x060002E1 RID: 737 RVA: 0x00012DB8 File Offset: 0x00010FB8
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

	// Token: 0x060002E2 RID: 738
	public abstract void Hit(int damage, float sharpness, int HitEffect, Vector3 pos);

	// Token: 0x060002E3 RID: 739 RVA: 0x00012DFC File Offset: 0x00010FFC
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

	// Token: 0x060002E4 RID: 740 RVA: 0x00012EC8 File Offset: 0x000110C8
	protected virtual void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) > 100f)
		{
			return;
		}
		GameObject gameObject =Instantiate<GameObject>(this.hitFx);
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

	// Token: 0x060002E5 RID: 741 RVA: 0x00004172 File Offset: 0x00002372
	protected virtual void SpawnDeathParticles()
	{
	Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation);
	}

	// Token: 0x060002E6 RID: 742 RVA: 0x0000419B File Offset: 0x0000239B
	public void KillObject(Vector3 dir)
	{
		this.SpawnDeathParticles();
		this.OnKill(dir);
	}

	// Token: 0x060002E7 RID: 743
	public abstract void OnKill(Vector3 dir);

	// Token: 0x060002E8 RID: 744
	protected abstract void ExecuteHit();

	// Token: 0x060002E9 RID: 745 RVA: 0x000041AA File Offset: 0x000023AA
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060002EA RID: 746 RVA: 0x000041B3 File Offset: 0x000023B3
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040002E9 RID: 745
	protected int id;

	// Token: 0x040002EA RID: 746
	public string entityName;

	// Token: 0x040002EB RID: 747
	public bool canHitMoreThanOnce;

	// Token: 0x040002EC RID: 748
	public LootDrop dropTable;

	// Token: 0x040002ED RID: 749
	public int hp;

	// Token: 0x040002EE RID: 750
	public int maxHp;

	// Token: 0x040002EF RID: 751
	public GameObject destroyFx;

	// Token: 0x040002F0 RID: 752
	public GameObject hitFx;

	// Token: 0x040002F1 RID: 753
	public GameObject numberFx;

	// Token: 0x040002F2 RID: 754
	protected Collider hitCollider;
}
