using System;
using UnityEngine;

// Token: 0x020000F8 RID: 248
public class MeshData
{
	// Token: 0x06000765 RID: 1893 RVA: 0x00025DA5 File Offset: 0x00023FA5
	public MeshData(int meshWidth, int meshHeight)
	{
		this.vertices = new Vector3[meshWidth * meshHeight];
		this.uvs = new Vector2[meshWidth * meshHeight];
		this.triangles = new int[(meshWidth - 1) * (meshHeight - 1) * 6];
	}

	// Token: 0x06000766 RID: 1894 RVA: 0x00025DDD File Offset: 0x00023FDD
	public void AddTriangle(int a, int b, int c)
	{
		this.triangles[this.triangleIndex] = a;
		this.triangles[this.triangleIndex + 1] = b;
		this.triangles[this.triangleIndex + 2] = c;
		this.triangleIndex += 3;
	}

	// Token: 0x06000767 RID: 1895 RVA: 0x00025E1B File Offset: 0x0002401B
	public Mesh CreateMesh()
	{
		Mesh mesh = new Mesh();
		mesh.vertices = this.vertices;
		mesh.triangles = this.triangles;
		mesh.uv = this.uvs;
		mesh.RecalculateNormals();
		return mesh;
	}

	// Token: 0x040006F1 RID: 1777
	public Vector3[] vertices;

	// Token: 0x040006F2 RID: 1778
	public int[] triangles;

	// Token: 0x040006F3 RID: 1779
	public Vector2[] uvs;

	// Token: 0x040006F4 RID: 1780
	private int triangleIndex;
}
