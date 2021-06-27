using System;
using UnityEngine;

public class HitableMob : Hitable
{
	public Mob mob { get; set; }

	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
		this.mobServer = base.GetComponent<MobServer>();
		this.maxHp = (int)((float)this.maxHp * GameManager.instance.MobHpMultiplier() * this.mob.multiplier * this.mob.bossMultiplier);
		this.hp = this.maxHp;
	}

	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 hitPos)
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) damage = int.MaxValue;
		else if (this.maxFractionHit > 0f)
		{
			int num = (int)(this.maxFractionHit * (float)this.maxHp);
			if (damage > num)
			{
				Debug.LogError(string.Concat(new object[]
				{
					"reducing damage from: ",
					damage,
					", to: ",
					num
				}));
				damage = num;
			}
		}
		ClientSend.PlayerDamageMob(this.id, damage, sharpness, hitEffect, hitPos);
	}

	public override void OnKill(Vector3 dir)
	{
		TestRagdoll component = base.GetComponent<TestRagdoll>();
		if (component)
		{
			component.MakeRagdoll(dir);
		}
		MobManager.Instance.RemoveMob(this.id);
		Destroy(base.gameObject);
	}

	protected override void ExecuteHit()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		this.mobServer.TookDamage();
	}

	public MobServer mobServer;

	public float maxFractionHit;
}
