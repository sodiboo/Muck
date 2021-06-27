using System;
using UnityEngine;

// Token: 0x02000101 RID: 257
public class ShaderInteractor : MonoBehaviour
{
	// Token: 0x060007A5 RID: 1957 RVA: 0x00027076 File Offset: 0x00025276
	private void Update()
	{
		Shader.SetGlobalVector("_PositionMoving", base.transform.position);
	}
}
