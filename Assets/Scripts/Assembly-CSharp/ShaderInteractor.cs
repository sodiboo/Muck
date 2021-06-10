
using UnityEngine;

// Token: 0x020000D9 RID: 217
public class ShaderInteractor : MonoBehaviour
{
	// Token: 0x06000689 RID: 1673 RVA: 0x00020E82 File Offset: 0x0001F082
	private void Update()
	{
		Shader.SetGlobalVector("_PositionMoving", base.transform.position);
	}
}
