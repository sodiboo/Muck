using System;
using UnityEngine;

public class TestCenterDeleteThisLol : MonoBehaviour
{
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

	public MobType mob;
}
