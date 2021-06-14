using System;
using UnityEngine;

// Token: 0x020000B1 RID: 177
public class MobServerNeutral : MobServer
{
	// Token: 0x17000030 RID: 48
	// (get) Token: 0x0600042B RID: 1067 RVA: 0x00004ED8 File Offset: 0x000030D8
	// (set) Token: 0x0600042C RID: 1068 RVA: 0x00004EE0 File Offset: 0x000030E0
	public int mobZoneId { get; set; }

	// Token: 0x0600042D RID: 1069 RVA: 0x00004EE9 File Offset: 0x000030E9
	private void Start()
	{
		this.FindPositionInterval = 12f;
	}

	// Token: 0x0600042E RID: 1070 RVA: 0x00002147 File Offset: 0x00000347
	protected override void Behaviour()
	{
	}

	// Token: 0x0600042F RID: 1071 RVA: 0x00004EF6 File Offset: 0x000030F6
	public override void TookDamage()
	{
		this.mob.SetSpeed(2f);
		base.SyncFindNextPosition();
	}

	// Token: 0x06000430 RID: 1072 RVA: 0x00004F0E File Offset: 0x0000310E
	protected override Vector3 FindNextPosition()
	{
		base.Invoke("SyncFindNextPosition", 12f);
		return MobZoneManager.Instance.zones[this.mobZoneId].FindRandomPos();
	}

	// Token: 0x06000431 RID: 1073 RVA: 0x00004F3A File Offset: 0x0000313A
	private void OnDisable()
	{
		base.CancelInvoke();
	}

	// Token: 0x06000432 RID: 1074 RVA: 0x00004F42 File Offset: 0x00003142
	private void OnEnable()
	{
		this.FindPositionInterval = 10f;
		base.StartRoutines();
	}
}
