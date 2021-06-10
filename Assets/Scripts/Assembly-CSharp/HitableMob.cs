
using UnityEngine;

// Token: 0x0200006F RID: 111
public class HitableMob : Hitable
{
	// Token: 0x17000020 RID: 32
	// (get) Token: 0x060002BA RID: 698 RVA: 0x0000EE66 File Offset: 0x0000D066
	// (set) Token: 0x060002BB RID: 699 RVA: 0x0000EE6E File Offset: 0x0000D06E
	public Mob mob { get; set; }

	// Token: 0x060002BC RID: 700 RVA: 0x0000EE78 File Offset: 0x0000D078
	private void Start()
	{
		this.mob = base.GetComponent<Mob>();
		this.mobServer = base.GetComponent<MobServer>();
		this.maxHp = (int)((float)this.maxHp * GameManager.instance.MobHpMultiplier() * this.mob.multiplier * this.mob.bossMultiplier);
		this.hp = this.maxHp;
	}

	// Token: 0x060002BD RID: 701 RVA: 0x0000EEDA File Offset: 0x0000D0DA
	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 hitPos)
	{
		ClientSend.PlayerDamageMob(this.id, damage, sharpness, hitEffect, hitPos);
	}

	// Token: 0x060002BE RID: 702 RVA: 0x0000EEEC File Offset: 0x0000D0EC
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

	// Token: 0x060002BF RID: 703 RVA: 0x0000EF2A File Offset: 0x0000D12A
	protected override void ExecuteHit()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		this.mobServer.TookDamage();
	}

	// Token: 0x04000294 RID: 660
	public MobServer mobServer;
}
