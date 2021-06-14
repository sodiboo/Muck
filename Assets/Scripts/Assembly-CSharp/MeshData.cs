using System;
using UnityEngine;

// Token: 0x02000111 RID: 273
public class MeshData
{
	// Token: 0x060006E7 RID: 1767 RVA: 0x000065A6 File Offset: 0x000047A6
	public MeshData(int meshWidth, int meshHeight)
	{
		this.vertices = new Vector3[meshWidth * meshHeight];
		this.uvs = new Vector2[meshWidth * meshHeight];
		this.triangles = new int[(meshWidth - 1) * (meshHeight - 1) * 6];
	}

	// Token: 0x060006E8 RID: 1768 RVA: 0x000065DE File Offset: 0x000047DE
	public void AddTriangle(int a, int b, int c)
	{
		this.triangles[this.triangleIndex] = a;
		this.triangles[this.triangleIndex + 1] = b;
		this.triangles[this.triangleIndex + 2] = c;
		this.triangleIndex += 3;
	}

	// Token: 0x060006E9 RID: 1769 RVA: 0x0000661C File Offset: 0x0000481C
	public Mesh CreateMesh()
	{
		Mesh mesh = new Mesh();
		mesh.vertices = this.vertices;
		mesh.triangles = this.triangles;
		mesh.uv = this.uvs;
		mesh.RecalculateNormals();
		return mesh;
	}

	// Token: 0x040006E9 RID: 1769
	public Vector3[] vertices;

	// Token: 0x040006EA RID: 1770
	public int[] triangles;

	// Token: 0x040006EB RID: 1771
	public Vector2[] uvs;

	// Token: 0x040006EC RID: 1772
	private int triangleIndex;
}
