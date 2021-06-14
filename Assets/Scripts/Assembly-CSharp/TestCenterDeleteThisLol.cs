using System;
using UnityEngine;

// Token: 0x02000143 RID: 323
public class TestCenterDeleteThisLol : MonoBehaviour
{
	// Token: 0x060007CD RID: 1997 RVA: 0x000268BC File Offset: 0x00024ABC
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.L))
		{
			int nextId = MobManager.Instance.GetNextId();
			int id = this.mob.id;
			Vector3 position = PlayerMovement.Instance.transform.position;
			MobSpawner.Instance.ServerSpawnNewMob(nextId, id, position, 1f, 1f, Mob.BossType.None);
		}
	}

	// Token: 0x040007FF RID: 2047
	public MobType mob;
}
