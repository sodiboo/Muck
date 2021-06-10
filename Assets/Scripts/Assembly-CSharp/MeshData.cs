
using UnityEngine;

// Token: 0x020000D0 RID: 208
public class MeshData
{
	// Token: 0x0600064B RID: 1611 RVA: 0x0001FCC5 File Offset: 0x0001DEC5
	public MeshData(int meshWidth, int meshHeight)
	{
		this.vertices = new Vector3[meshWidth * meshHeight];
		this.uvs = new Vector2[meshWidth * meshHeight];
		this.triangles = new int[(meshWidth - 1) * (meshHeight - 1) * 6];
	}

	// Token: 0x0600064C RID: 1612 RVA: 0x0001FCFD File Offset: 0x0001DEFD
	public void AddTriangle(int a, int b, int c)
	{
		this.triangles[this.triangleIndex] = a;
		this.triangles[this.triangleIndex + 1] = b;
		this.triangles[this.triangleIndex + 2] = c;
		this.triangleIndex += 3;
	}

	// Token: 0x0600064D RID: 1613 RVA: 0x0001FD3B File Offset: 0x0001DF3B
	public Mesh CreateMesh()
	{
		Mesh mesh = new Mesh();
		mesh.vertices = this.vertices;
		mesh.triangles = this.triangles;
		mesh.uv = this.uvs;
		mesh.RecalculateNormals();
		return mesh;
	}

	// Token: 0x040005CB RID: 1483
	public Vector3[] vertices;

	// Token: 0x040005CC RID: 1484
	public int[] triangles;

	// Token: 0x040005CD RID: 1485
	public Vector2[] uvs;

	// Token: 0x040005CE RID: 1486
	private int triangleIndex;
}
