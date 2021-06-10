
using UnityEngine;

// Token: 0x020000E4 RID: 228
public class SpawnObjectTimed : MonoBehaviour
{
	// Token: 0x060006B3 RID: 1715 RVA: 0x00021AB0 File Offset: 0x0001FCB0
	private void Awake()
	{
		base.Invoke("SpawnObject", this.time);
	}

	// Token: 0x060006B4 RID: 1716 RVA: 0x00021AC3 File Offset: 0x0001FCC3
	private void SpawnObject()
	{
	Instantiate(this.objectToSpawn, base.transform.position, this.objectToSpawn.transform.rotation);
	Destroy(this);
	}

	// Token: 0x04000655 RID: 1621
	public float time;

	// Token: 0x04000656 RID: 1622
	public GameObject objectToSpawn;
}
