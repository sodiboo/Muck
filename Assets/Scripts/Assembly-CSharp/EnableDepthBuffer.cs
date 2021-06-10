
using UnityEngine;

// Token: 0x020000DC RID: 220
[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class EnableDepthBuffer : MonoBehaviour
{
	// Token: 0x06000693 RID: 1683 RVA: 0x0002167C File Offset: 0x0001F87C
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

	// Token: 0x04000640 RID: 1600
	private Camera m_camera;
}
