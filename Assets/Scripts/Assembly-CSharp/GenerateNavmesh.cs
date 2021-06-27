using System;
using UnityEngine;
using UnityEngine.AI;

// Token: 0x0200003D RID: 61
public class GenerateNavmesh : MonoBehaviour
{
	// Token: 0x06000167 RID: 359 RVA: 0x00008C4C File Offset: 0x00006E4C
	public void GenerateNavMesh()
	{
		this.surface.BuildNavMesh();
	}

	// Token: 0x04000164 RID: 356
	public NavMeshSurface surface;
}
