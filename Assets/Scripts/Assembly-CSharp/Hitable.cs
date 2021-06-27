using System;
using UnityEngine;

public abstract class Hitable : MonoBehaviour, SharedObject
{
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

	public abstract void Hit(int damage, float sharpness, int HitEffect, Vector3 pos);

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

	protected virtual void SpawnDeathParticles()
	{
		Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation);
	}

	public void KillObject(Vector3 dir)
	{
		this.SpawnDeathParticles();
		this.OnKill(dir);
	}

	public abstract void OnKill(Vector3 dir);

	protected abstract void ExecuteHit();

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	protected int id;

	public string entityName;

	public bool canHitMoreThanOnce;

	public LootDrop dropTable;

	public int hp;

	public int maxHp;

	public GameObject destroyFx;

	public GameObject hitFx;

	public GameObject numberFx;

	protected Collider hitCollider;
}
