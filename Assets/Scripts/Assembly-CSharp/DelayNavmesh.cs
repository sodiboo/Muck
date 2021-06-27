using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000027 RID: 39
public class DelayNavmesh : MonoBehaviour
{
	// Token: 0x060000EB RID: 235 RVA: 0x00006715 File Offset: 0x00004915
	private void Awake()
	{
		Invoke(nameof(ResetObstacle), Random.Range(5f, 15f));
	}

	// Token: 0x060000EC RID: 236 RVA: 0x00006731 File Offset: 0x00004931
	private void ResetObstacle()
	{
		NavMeshObstacle component = base.GetComponent<NavMeshObstacle>();
		component.enabled = false;
		component.enabled = true;
	}
}
