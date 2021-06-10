
using UnityEngine;

// Token: 0x020000CD RID: 205
public class MapDisplay : MonoBehaviour
{
	// Token: 0x0600063D RID: 1597 RVA: 0x0001F6A4 File Offset: 0x0001D8A4
	public void DrawTexture(Texture2D texture)
	{
		this.textureRender.sharedMaterial.mainTexture = texture;
		this.textureRender.transform.localScale = new Vector3((float)texture.width, 1f, (float)texture.height);
	}

	// Token: 0x0600063E RID: 1598 RVA: 0x0001F6DF File Offset: 0x0001D8DF
	public void DrawMesh(MeshData meshData)
	{
		this.meshFilter.sharedMesh = meshData.CreateMesh();
		this.meshCollider.sharedMesh = this.meshFilter.sharedMesh;
	}

	// Token: 0x040005B8 RID: 1464
	public Renderer textureRender;

	// Token: 0x040005B9 RID: 1465
	public MeshFilter meshFilter;

	// Token: 0x040005BA RID: 1466
	public MeshRenderer meshRenderer;

	// Token: 0x040005BB RID: 1467
	public MeshCollider meshCollider;
}
