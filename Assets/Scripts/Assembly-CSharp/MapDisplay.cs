using System;
using UnityEngine;

// Token: 0x020000F5 RID: 245
public class MapDisplay : MonoBehaviour
{
	// Token: 0x06000757 RID: 1879 RVA: 0x00025784 File Offset: 0x00023984
	public void DrawTexture(Texture2D texture)
	{
		this.textureRender.sharedMaterial.mainTexture = texture;
		this.textureRender.transform.localScale = new Vector3((float)texture.width, 1f, (float)texture.height);
	}

	// Token: 0x06000758 RID: 1880 RVA: 0x000257BF File Offset: 0x000239BF
	public void DrawMesh(MeshData meshData)
	{
		this.meshFilter.sharedMesh = meshData.CreateMesh();
		this.meshCollider.sharedMesh = this.meshFilter.sharedMesh;
	}

	// Token: 0x040006DE RID: 1758
	public Renderer textureRender;

	// Token: 0x040006DF RID: 1759
	public MeshFilter meshFilter;

	// Token: 0x040006E0 RID: 1760
	public MeshRenderer meshRenderer;

	// Token: 0x040006E1 RID: 1761
	public MeshCollider meshCollider;
}
