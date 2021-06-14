using System;
using UnityEngine;

// Token: 0x02000131 RID: 305
public class SpawnObjectTimed : MonoBehaviour
{
	// Token: 0x06000761 RID: 1889 RVA: 0x00006DB0 File Offset: 0x00004FB0
	private void Awake()
	{
		base.Invoke("SpawnObject", this.time);
	}

	// Token: 0x06000762 RID: 1890 RVA: 0x00006DC3 File Offset: 0x00004FC3
	private void SpawnObject()
	{
	Instantiate<GameObject>(this.objectToSpawn, base.transform.position, this.objectToSpawn.transform.rotation);
	Destroy(this);
	}

	// Token: 0x040007A2 RID: 1954
	public float time;

	// Token: 0x040007A3 RID: 1955
	public GameObject objectToSpawn;
}
