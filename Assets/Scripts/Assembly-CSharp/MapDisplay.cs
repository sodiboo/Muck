using System;
using UnityEngine;

// Token: 0x0200010D RID: 269
public class MapDisplay : MonoBehaviour
{
	// Token: 0x060006D9 RID: 1753 RVA: 0x000064BE File Offset: 0x000046BE
	public void DrawTexture(Texture2D texture)
	{
		this.textureRender.sharedMaterial.mainTexture = texture;
		this.textureRender.transform.localScale = new Vector3((float)texture.width, 1f, (float)texture.height);
	}

	// Token: 0x060006DA RID: 1754 RVA: 0x000064F9 File Offset: 0x000046F9
	public void DrawMesh(MeshData meshData)
	{
		this.meshFilter.sharedMesh = meshData.CreateMesh();
		this.meshCollider.sharedMesh = this.meshFilter.sharedMesh;
	}

	// Token: 0x040006D1 RID: 1745
	public Renderer textureRender;

	// Token: 0x040006D2 RID: 1746
	public MeshFilter meshFilter;

	// Token: 0x040006D3 RID: 1747
	public MeshRenderer meshRenderer;

	// Token: 0x040006D4 RID: 1748
	public MeshCollider meshCollider;
}
