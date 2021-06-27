using System;
using UnityEngine;

// Token: 0x02000018 RID: 24
public class CinematicCamera : MonoBehaviour
{
	// Token: 0x06000098 RID: 152 RVA: 0x00004F9E File Offset: 0x0000319E
	private void Update()
	{
		base.transform.LookAt(this.target);
		base.transform.RotateAround(this.target.position, Vector3.up, this.speed);
	}

	// Token: 0x0400009A RID: 154
	public Transform target;

	// Token: 0x0400009B RID: 155
	public float speed;
}
