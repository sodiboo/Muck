using System;
using UnityEngine;

// Token: 0x02000086 RID: 134
public class HitableChest : HitableResource
{
	// Token: 0x060002F2 RID: 754 RVA: 0x000041EA File Offset: 0x000023EA
	public override void OnKill(Vector3 dir)
	{
		ChestManager.Instance.RemoveChest(base.GetId());
	}
}
