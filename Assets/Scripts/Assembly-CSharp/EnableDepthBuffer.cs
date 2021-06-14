using System;
using UnityEngine;

// Token: 0x02000127 RID: 295
[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class EnableDepthBuffer : MonoBehaviour
{
	// Token: 0x06000732 RID: 1842 RVA: 0x00006C07 File Offset: 0x00004E07
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

	// Token: 0x04000787 RID: 1927
	private Camera m_camera;
}
