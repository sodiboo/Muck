
using UnityEngine;

// Token: 0x020000AE RID: 174
public class VectorExtensions : MonoBehaviour
{
	// Token: 0x06000576 RID: 1398 RVA: 0x0001BBE2 File Offset: 0x00019DE2
	public static Vector3 XZVector(Vector3 v)
	{
		return new Vector3(v.x, 0f, v.z);
	}
}
