using System;
using UnityEngine;

// Token: 0x02000111 RID: 273
public class SpawnObjectTimed : MonoBehaviour
{
	// Token: 0x060007F0 RID: 2032 RVA: 0x00028123 File Offset: 0x00026323
	private void Awake()
	{
		Invoke(nameof(SpawnObject), this.time);
	}

	// Token: 0x060007F1 RID: 2033 RVA: 0x00028136 File Offset: 0x00026336
	private void SpawnObject()
	{
		Instantiate<GameObject>(this.objectToSpawn, base.transform.position, this.objectToSpawn.transform.rotation);
		Destroy(this);
	}

	// Token: 0x04000792 RID: 1938
	public float time;

	// Token: 0x04000793 RID: 1939
	public GameObject objectToSpawn;
}
