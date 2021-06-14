using System;
using UnityEngine;

// Token: 0x02000014 RID: 20
public class CinematicCamera : MonoBehaviour
{
	// Token: 0x06000068 RID: 104 RVA: 0x00002428 File Offset: 0x00000628
	private void Update()
	{
		base.transform.LookAt(this.target);
		base.transform.RotateAround(this.target.position, Vector3.up, this.speed);
	}

	// Token: 0x04000066 RID: 102
	public Transform target;

	// Token: 0x04000067 RID: 103
	public float speed;
}
