using System;
using UnityEngine;

[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class EnableDepthBuffer : MonoBehaviour
{
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

	private Camera m_camera;
}
