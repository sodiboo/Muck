
using UnityEngine;

// Token: 0x020000E3 RID: 227
public class SpawnEffect : MonoBehaviour
{
	// Token: 0x060006B1 RID: 1713 RVA: 0x00021A38 File Offset: 0x0001FC38
	private void Awake()
	{
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < this.maxPlayerDistance)
		{
		Instantiate(this.spawnEffect, base.transform.position, Quaternion.identity).GetComponent<AudioSource>().maxDistance = this.maxPlayerDistance;
		}
	Destroy(this);
	}

	// Token: 0x04000653 RID: 1619
	public GameObject spawnEffect;

	// Token: 0x04000654 RID: 1620
	public float maxPlayerDistance = 40f;
}
