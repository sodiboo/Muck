using System;
using UnityEngine;

// Token: 0x0200011E RID: 286
public class TestCenterDeleteThisLol : MonoBehaviour
{
	// Token: 0x06000853 RID: 2131 RVA: 0x00029C4C File Offset: 0x00027E4C
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.L))
		{
			int nextId = MobManager.Instance.GetNextId();
			int id = this.mob.id;
			Vector3 position = PlayerMovement.Instance.transform.position;
			MobSpawner.Instance.ServerSpawnNewMob(nextId, id, position, 1f, 1f, Mob.BossType.None, -1);
		}
	}

	// Token: 0x040007DE RID: 2014
	public MobType mob;
}
