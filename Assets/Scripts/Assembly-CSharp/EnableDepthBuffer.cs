using UnityEngine;

[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class EnableDepthBuffer : MonoBehaviour
{
    private Camera m_camera;

    private void Update()
    {
        if (m_camera == null)
        {
            m_camera = GetComponent<Camera>();
        }
        if (m_camera.depthTextureMode == DepthTextureMode.None)
        {
            m_camera.depthTextureMode = DepthTextureMode.Depth;
        }
    }
}
