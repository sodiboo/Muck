using System;
using UnityEngine;

// Token: 0x02000130 RID: 304
public class SpawnEffect : MonoBehaviour
{
	// Token: 0x0600075F RID: 1887 RVA: 0x00024D6C File Offset: 0x00022F6C
	private void Awake()
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < this.maxPlayerDistance)
		{
		Instantiate<GameObject>(this.spawnEffect, base.transform.position, Quaternion.identity).GetComponent<AudioSource>().maxDistance = this.maxPlayerDistance;
		}
	Destroy(this);
	}

	// Token: 0x040007A0 RID: 1952
	public GameObject spawnEffect;

	// Token: 0x040007A1 RID: 1953
	public float maxPlayerDistance = 40f;
}
