using System;
using UnityEngine;

// Token: 0x020000B4 RID: 180
public class MobServerNeutral : MobServer
{
	// Token: 0x17000036 RID: 54
	// (get) Token: 0x060004CA RID: 1226 RVA: 0x00018D18 File Offset: 0x00016F18
	// (set) Token: 0x060004CB RID: 1227 RVA: 0x00018D20 File Offset: 0x00016F20
	public int mobZoneId { get; set; }

	// Token: 0x060004CC RID: 1228 RVA: 0x00018D29 File Offset: 0x00016F29
	private void Start()
	{
		this.FindPositionInterval = 12f;
	}

	// Token: 0x060004CD RID: 1229 RVA: 0x000030D7 File Offset: 0x000012D7
	protected override void Behaviour()
	{
	}

	// Token: 0x060004CE RID: 1230 RVA: 0x00018D36 File Offset: 0x00016F36
	public override void TookDamage()
	{
		this.mob.SetSpeed(2f);
		base.SyncFindNextPosition();
	}

	// Token: 0x060004CF RID: 1231 RVA: 0x00018D4E File Offset: 0x00016F4E
	protected override Vector3 FindNextPosition()
	{
		Invoke(nameof(SyncFindNextPosition), 12f);
		return MobZoneManager.Instance.zones[this.mobZoneId].FindRandomPos();
	}

	// Token: 0x060004D0 RID: 1232 RVA: 0x00018D7A File Offset: 0x00016F7A
	private void OnDisable()
	{
		base.CancelInvoke();
	}

	// Token: 0x060004D1 RID: 1233 RVA: 0x00018D82 File Offset: 0x00016F82
	private void OnEnable()
	{
		this.FindPositionInterval = 10f;
		base.StartRoutines();
	}
}
