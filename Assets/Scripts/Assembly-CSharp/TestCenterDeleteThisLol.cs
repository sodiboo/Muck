
using UnityEngine;

// Token: 0x020000EF RID: 239
public class TestCenterDeleteThisLol : MonoBehaviour
{
	// Token: 0x06000711 RID: 1809 RVA: 0x00023378 File Offset: 0x00021578
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.L))
		{
			int nextId = MobManager.Instance.GetNextId();
			int id = this.mob.id;
			Vector3 position = PlayerMovement.Instance.transform.position;
			MobSpawner.Instance.ServerSpawnNewMob(nextId, id, position, 1.5f, 1f);
		}
	}

	// Token: 0x04000699 RID: 1689
	public MobType mob;
}
