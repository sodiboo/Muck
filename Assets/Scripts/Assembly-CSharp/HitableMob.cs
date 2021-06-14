using System;
using UnityEngine;

// Token: 0x02000087 RID: 135
public class HitableMob : Hitable
{
	// Token: 0x17000024 RID: 36
	// (get) Token: 0x060002F4 RID: 756 RVA: 0x00004204 File Offset: 0x00002404
	// (set) Token: 0x060002F5 RID: 757 RVA: 0x0000420C File Offset: 0x0000240C
	public Mob mob { get; set; }

	// Token: 0x060002F6 RID: 758 RVA: 0x00012FA0 File Offset: 0x000111A0
	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
		this.mobServer = base.GetComponent<MobServer>();
		this.maxHp = (int)((float)this.maxHp * GameManager.instance.MobHpMultiplier() * this.mob.multiplier * this.mob.bossMultiplier);
		this.hp = this.maxHp;
	}

	// Token: 0x060002F7 RID: 759 RVA: 0x00004215 File Offset: 0x00002415
	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 hitPos)
	{
		ClientSend.PlayerDamageMob(this.id, damage, sharpness, hitEffect, hitPos);
	}

	// Token: 0x060002F8 RID: 760 RVA: 0x00013004 File Offset: 0x00011204
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

	// Token: 0x060002F9 RID: 761 RVA: 0x00004227 File Offset: 0x00002427
	protected override void ExecuteHit()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		this.mobServer.TookDamage();
	}

	// Token: 0x040002F8 RID: 760
	public MobServer mobServer;
}
