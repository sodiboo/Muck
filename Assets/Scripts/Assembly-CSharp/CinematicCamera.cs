
using UnityEngine;

// Token: 0x02000012 RID: 18
public class CinematicCamera : MonoBehaviour
{
	// Token: 0x06000064 RID: 100 RVA: 0x00004352 File Offset: 0x00002552
	private void Update()
	{
		base.transform.LookAt(this.target);
		base.transform.RotateAround(this.target.position, Vector3.up, this.speed);
	}

	// Token: 0x04000061 RID: 97
	public Transform target;

	// Token: 0x04000062 RID: 98
	public float speed;
}
