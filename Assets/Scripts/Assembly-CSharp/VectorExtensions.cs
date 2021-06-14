using System;
using UnityEngine;

// Token: 0x020000E8 RID: 232
public class VectorExtensions : MonoBehaviour
{
	// Token: 0x06000608 RID: 1544 RVA: 0x00005D0D File Offset: 0x00003F0D
	public static Vector3 XZVector(Vector3 v)
	{
		return new Vector3(v.x, 0f, v.z);
	}
}
