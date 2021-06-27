using System;
using UnityEngine;

// Token: 0x02000104 RID: 260
[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class EnableDepthBuffer : MonoBehaviour
{
	// Token: 0x060007AF RID: 1967 RVA: 0x00027870 File Offset: 0x00025A70
	private void Update()
	{
		if (this.m_camera == null)
		{
			this.m_camera = base.GetComponent<Camera>();
		}
		if (this.m_camera.depthTextureMode == DepthTextureMode.None)
		{
			this.m_camera.depthTextureMode = DepthTextureMode.Depth;
		}
	}

	// Token: 0x0400076A RID: 1898
	private Camera m_camera;
}
