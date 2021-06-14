using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000023 RID: 35
public class DelayNavmesh : MonoBehaviour
{
	// Token: 0x060000B9 RID: 185 RVA: 0x00002A84 File Offset: 0x00000C84
	private void Awake()
	{
		base.Invoke("ResetObstacle", Random.Range(5f, 15f));
	}

	// Token: 0x060000BA RID: 186 RVA: 0x00002AA0 File Offset: 0x00000CA0
	private void ResetObstacle()
	{
		NavMeshObstacle component = base.GetComponent<NavMeshObstacle>();
		component.enabled = false;
		component.enabled = true;
	}
}
