using System;
using UnityEngine;

// Token: 0x0200010F RID: 271
public class SpawnEffect : MonoBehaviour
{
	// Token: 0x060007EC RID: 2028 RVA: 0x0002807C File Offset: 0x0002627C
	private void Awake()
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < this.maxPlayerDistance)
		{
			Instantiate<GameObject>(this.spawnEffect, base.transform.position, Quaternion.identity).GetComponent<AudioSource>().maxDistance = this.maxPlayerDistance;
		}
		Destroy(this);
	}

	// Token: 0x0400078E RID: 1934
	public GameObject spawnEffect;

	// Token: 0x0400078F RID: 1935
	public float maxPlayerDistance = 40f;
}
