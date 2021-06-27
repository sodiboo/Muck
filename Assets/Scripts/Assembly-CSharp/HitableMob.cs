using System;
using UnityEngine;

// Token: 0x02000095 RID: 149
public class HitableMob : Hitable
{
	// Token: 0x1700002A RID: 42
	// (get) Token: 0x06000393 RID: 915 RVA: 0x00013622 File Offset: 0x00011822
	// (set) Token: 0x06000394 RID: 916 RVA: 0x0001362A File Offset: 0x0001182A
	public Mob mob { get; set; }

	// Token: 0x06000395 RID: 917 RVA: 0x00013634 File Offset: 0x00011834
	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
		this.mobServer = base.GetComponent<MobServer>();
		this.maxHp = (int)((float)this.maxHp * GameManager.instance.MobHpMultiplier() * this.mob.multiplier * this.mob.bossMultiplier);
		this.hp = this.maxHp;
	}

	// Token: 0x06000396 RID: 918 RVA: 0x00013698 File Offset: 0x00011898
	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 hitPos)
	{
		if (this.maxFractionHit > 0f)
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

	// Token: 0x06000397 RID: 919 RVA: 0x0001370C File Offset: 0x0001190C
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

	// Token: 0x06000398 RID: 920 RVA: 0x0001374A File Offset: 0x0001194A
	protected override void ExecuteHit()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		this.mobServer.TookDamage();
	}

	// Token: 0x0400038B RID: 907
	public MobServer mobServer;

	// Token: 0x0400038C RID: 908
	public float maxFractionHit;
}
