
using UnityEngine;
using UnityEngine.AI;

// Token: 0x0200002A RID: 42
public class GenerateNavmesh : MonoBehaviour
{
	// Token: 0x060000F9 RID: 249 RVA: 0x00007006 File Offset: 0x00005206
	public void GenerateNavMesh()
	{
		this.surface.BuildNavMesh();
	}

	// Token: 0x040000EF RID: 239
	public NavMeshSurface surface;
}
