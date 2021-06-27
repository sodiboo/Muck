using System;
using UnityEngine;

// Token: 0x020000D6 RID: 214
public class VectorExtensions : MonoBehaviour
{
	// Token: 0x06000680 RID: 1664 RVA: 0x00021772 File Offset: 0x0001F972
	public static Vector3 XZVector(Vector3 v)
	{
		return new Vector3(v.x, 0f, v.z);
	}
}
