
using UnityEngine;

// Token: 0x0200006E RID: 110
public class HitableChest : HitableResource
{
	// Token: 0x060002B8 RID: 696 RVA: 0x0000EE4C File Offset: 0x0000D04C
	public override void OnKill(Vector3 dir)
	{
		ChestManager.Instance.RemoveChest(base.GetId());
	}
}
