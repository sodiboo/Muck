using System;
using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000032 RID: 50
public class GenerateNavmesh : MonoBehaviour
{
	// Token: 0x0600010D RID: 269 RVA: 0x00002D5E File Offset: 0x00000F5E
	public void GenerateNavMesh()
	{
		this.surface.BuildNavMesh();
	}

	// Token: 0x04000112 RID: 274
	public NavMeshSurface surface;
}
