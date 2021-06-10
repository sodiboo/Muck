
using UnityEngine;

// Token: 0x0200000A RID: 10
[ExecuteInEditMode]
public class BuildSnappingInfo : MonoBehaviour
{
	// Token: 0x0600002F RID: 47 RVA: 0x000038B4 File Offset: 0x00001AB4
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		foreach (Vector3 a in this.position)
		{
			Gizmos.DrawCube(base.transform.position + a * 1f, Vector3.one * 0.1f);
		}
	}

	// Token: 0x04000034 RID: 52
	public Vector3[] position;

	// Token: 0x04000035 RID: 53
	public bool half;
}
