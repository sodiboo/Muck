using System;
using UnityEngine;

// Token: 0x02000124 RID: 292
public class ShaderInteractor : MonoBehaviour
{
	// Token: 0x06000728 RID: 1832 RVA: 0x00006BC0 File Offset: 0x00004DC0
	private void Update()
	{
		Shader.SetGlobalVector("_PositionMoving", base.transform.position);
	}
}
