
using UnityEngine;
using UnityEngine.AI;

// Token: 0x0200001D RID: 29
public class DelayNavmesh : MonoBehaviour
{
	// Token: 0x060000AD RID: 173 RVA: 0x00005789 File Offset: 0x00003989
	private void Awake()
	{
		base.Invoke("ResetObstacle", Random.Range(5f, 15f));
	}

	// Token: 0x060000AE RID: 174 RVA: 0x000057A5 File Offset: 0x000039A5
	private void ResetObstacle()
	{
		NavMeshObstacle component = base.GetComponent<NavMeshObstacle>();
		component.enabled = false;
		component.enabled = true;
	}
}
