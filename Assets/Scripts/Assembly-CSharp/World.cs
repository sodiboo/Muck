using System;
using UnityEngine;

// Token: 0x02000133 RID: 307
public class World : MonoBehaviour
{
	// Token: 0x060008C7 RID: 2247 RVA: 0x0002BA9C File Offset: 0x00029C9C
	private void Awake()
	{
		World.Instance = this;
	}

	// Token: 0x04000852 RID: 2130
	public Transform worldMesh;

	// Token: 0x04000853 RID: 2131
	public Transform water;

	// Token: 0x04000854 RID: 2132
	public static World Instance;
}
