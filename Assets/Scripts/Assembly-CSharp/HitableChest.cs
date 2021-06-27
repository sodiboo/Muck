using System;
using UnityEngine;

// Token: 0x02000094 RID: 148
public class HitableChest : HitableResource
{
	// Token: 0x06000391 RID: 913 RVA: 0x00013608 File Offset: 0x00011808
	public override void OnKill(Vector3 dir)
	{
		ChestManager.Instance.RemoveChest(base.GetId());
	}
}
