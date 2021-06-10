
using UnityEngine;

// Token: 0x0200008D RID: 141
public class MobServerNeutral : MobServer
{
	// Token: 0x1700002A RID: 42
	// (get) Token: 0x060003D4 RID: 980 RVA: 0x00013982 File Offset: 0x00011B82
	// (set) Token: 0x060003D5 RID: 981 RVA: 0x0001398A File Offset: 0x00011B8A
	public int mobZoneId { get; set; }

	// Token: 0x060003D6 RID: 982 RVA: 0x00013993 File Offset: 0x00011B93
	private void Start()
	{
		this.FindPositionInterval = 10f;
	}

	// Token: 0x060003D7 RID: 983 RVA: 0x0000276E File Offset: 0x0000096E
	protected override void Behaviour()
	{
	}

	// Token: 0x060003D8 RID: 984 RVA: 0x000139A0 File Offset: 0x00011BA0
	public override void TookDamage()
	{
		this.mob.SetSpeed(2f);
		base.SyncFindNextPosition();
	}

	// Token: 0x060003D9 RID: 985 RVA: 0x000139B8 File Offset: 0x00011BB8
	protected override Vector3 FindNextPosition()
	{
		return MobZoneManager.Instance.zones[this.mobZoneId].FindRandomPos();
	}

	// Token: 0x060003DA RID: 986 RVA: 0x000139D4 File Offset: 0x00011BD4
	private void OnDisable()
	{
		base.CancelInvoke();
	}

	// Token: 0x060003DB RID: 987 RVA: 0x000139DC File Offset: 0x00011BDC
	private void OnEnable()
	{
		this.FindPositionInterval = 10f;
		base.StartRoutines();
	}
}
