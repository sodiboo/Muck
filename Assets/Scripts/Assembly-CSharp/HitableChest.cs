using System;
using UnityEngine;


public class HitableChest : HitableResource
{

	public override void OnKill(Vector3 dir)
	{
		ChestManager.Instance.RemoveChest(base.GetId());
	}
}
