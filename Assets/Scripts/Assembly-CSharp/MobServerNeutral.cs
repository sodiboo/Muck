using System;
using UnityEngine;

public class MobServerNeutral : MobServer
{
	public int mobZoneId { get; set; }

	private void Start()
	{
		this.FindPositionInterval = 12f;
	}

	protected override void Behaviour()
	{
	}

	public override void TookDamage()
	{
		this.mob.SetSpeed(2f);
		base.SyncFindNextPosition();
	}

	protected override Vector3 FindNextPosition()
	{
		Invoke(nameof(SyncFindNextPosition), 12f);
		return MobZoneManager.Instance.zones[this.mobZoneId].FindRandomPos();
	}

	private void OnDisable()
	{
		base.CancelInvoke();
	}

	private void OnEnable()
	{
		this.FindPositionInterval = 10f;
		base.StartRoutines();
	}
}
