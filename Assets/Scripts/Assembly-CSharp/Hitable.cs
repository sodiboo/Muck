
using UnityEngine;

// Token: 0x0200006C RID: 108
public abstract class Hitable : MonoBehaviour, SharedObject
{
	// Token: 0x060002A7 RID: 679 RVA: 0x0000EBEC File Offset: 0x0000CDEC
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

	// Token: 0x060002A8 RID: 680
	public abstract void Hit(int damage, float sharpness, int HitEffect, Vector3 pos);

	// Token: 0x060002A9 RID: 681 RVA: 0x0000EC30 File Offset: 0x0000CE30
	public virtual int Damage(int newHp, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 normalized = (GameManager.players[fromClient].transform.position + Vector3.up * 1.5f - pos).normalized;
		this.SpawnParticles(pos, normalized, hitEffect);
		int num = this.hp - newHp;
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < 100f)
		{
		Instantiate(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)num, normalized, (HitEffect)hitEffect);
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

	// Token: 0x060002AA RID: 682 RVA: 0x0000ECFC File Offset: 0x0000CEFC
	protected virtual void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) > 100f)
		{
			return;
		}
		GameObject gameObject =Instantiate(this.hitFx);
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

	// Token: 0x060002AB RID: 683 RVA: 0x0000ED75 File Offset: 0x0000CF75
	protected virtual void SpawnDeathParticles()
	{
	Instantiate(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation);
	}

	// Token: 0x060002AC RID: 684 RVA: 0x0000ED9E File Offset: 0x0000CF9E
	public void KillObject(Vector3 dir)
	{
		this.SpawnDeathParticles();
		this.OnKill(dir);
	}

	// Token: 0x060002AD RID: 685
	public abstract void OnKill(Vector3 dir);

	// Token: 0x060002AE RID: 686
	protected abstract void ExecuteHit();

	// Token: 0x060002AF RID: 687 RVA: 0x0000EDAD File Offset: 0x0000CFAD
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060002B0 RID: 688 RVA: 0x0000EDB6 File Offset: 0x0000CFB6
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000289 RID: 649
	protected int id;

	// Token: 0x0400028A RID: 650
	public string entityName;

	// Token: 0x0400028B RID: 651
	public LootDrop dropTable;

	// Token: 0x0400028C RID: 652
	public int hp;

	// Token: 0x0400028D RID: 653
	public int maxHp;

	// Token: 0x0400028E RID: 654
	public GameObject destroyFx;

	// Token: 0x0400028F RID: 655
	public GameObject hitFx;

	// Token: 0x04000290 RID: 656
	public GameObject numberFx;

	// Token: 0x04000291 RID: 657
	protected Collider hitCollider;
}
