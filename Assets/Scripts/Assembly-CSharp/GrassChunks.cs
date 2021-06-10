
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002C RID: 44
public class GrassChunks : MonoBehaviour
{
	// Token: 0x060000FF RID: 255 RVA: 0x0000728A File Offset: 0x0000548A
	private void Awake()
	{
		this.InitChunks();
		this.UpdateChunkCenters(Vector2.zero);
	}

	// Token: 0x06000100 RID: 256 RVA: 0x000072A0 File Offset: 0x000054A0
	private void InitChunks()
	{
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.topLeftX = (float)(this.chunkSize * this.chunkLength) / -2f;
		this.topLeftZ = (float)(this.chunkSize * this.chunkLength) / 2f;
		this.chunks = new Dictionary<Vector3, GrassChunks.Chunk>();
	}

	// Token: 0x06000101 RID: 257 RVA: 0x00007304 File Offset: 0x00005504
	private void UpdateChunkCenters(Vector2 dir)
	{
		Dictionary<Vector3, GrassChunks.Chunk> dictionary = new Dictionary<Vector3, GrassChunks.Chunk>();
		float num = base.transform.position.x - base.transform.position.x % (float)this.chunkSize;
		float num2 = base.transform.position.z - base.transform.position.z % (float)this.chunkSize;
		if (num < 0f)
		{
			num -= (float)this.chunkSize / 2f;
		}
		if (num > 0f)
		{
			num += (float)this.chunkSize / 2f;
		}
		if (num2 < 0f)
		{
			num2 -= (float)this.chunkSize / 2f;
		}
		if (num2 > 0f)
		{
			num2 += (float)this.chunkSize / 2f;
		}
		num += this.topLeftX;
		num2 += this.topLeftZ;
		MonoBehaviour.print("updaying chunk centers");
		for (int i = 0; i < this.nChunks; i++)
		{
			int num3 = Mathf.FloorToInt((float)i / (float)this.chunkLength) * this.chunkSize;
			int num4 = i % this.chunkLength * this.chunkSize;
			Vector3 vector = new Vector3(num + (float)num4 + (float)this.chunkSize / 2f, 0f, num2 - (float)num3 - (float)this.chunkSize / 2f);
			if (this.chunks.ContainsKey(vector))
			{
				dictionary.Add(vector, this.chunks[vector]);
			}
			else
			{
				GrassChunks.Chunk value = new GrassChunks.Chunk(1, vector);
				dictionary.Add(vector, value);
			}
		}
		this.chunks = dictionary;
	}

	// Token: 0x06000102 RID: 258 RVA: 0x0000749C File Offset: 0x0000569C
	private void Update()
	{
		Vector2 vector = this.FindPLayerChunk();
		if (vector != Vector2.zero)
		{
			vector.x /= (float)this.chunkSize;
			vector.y /= (float)this.chunkSize;
			MonoBehaviour.print(vector);
			this.UpdateChunkCenters(vector);
		}
	}

	// Token: 0x06000103 RID: 259 RVA: 0x000074F4 File Offset: 0x000056F4
	private void UpdateChunkLOD()
	{
		this.target = base.transform;
		for (int i = 0; i < this.nChunks; i++)
		{
		}
	}

	// Token: 0x06000104 RID: 260 RVA: 0x00007520 File Offset: 0x00005720
	public int FindLOD(float distanceFromChunk)
	{
		for (int i = 1; i < this.maxLOD + 1; i++)
		{
			if (distanceFromChunk < (float)this.chunkSize * 1.5f * (float)i)
			{
				return i * i;
			}
		}
		return this.maxLOD * this.maxLOD;
	}

	// Token: 0x06000105 RID: 261 RVA: 0x00007564 File Offset: 0x00005764
	private Vector2 FindPLayerChunk()
	{
		float num = base.transform.position.x - base.transform.position.x % (float)this.chunkSize;
		float num2 = base.transform.position.z - base.transform.position.z % (float)this.chunkSize;
		if (num < 0f)
		{
			num -= (float)this.chunkSize / 2f;
		}
		if (num > 0f)
		{
			num += (float)this.chunkSize / 2f;
		}
		if (num2 < 0f)
		{
			num2 -= (float)this.chunkSize / 2f;
		}
		if (num2 > 0f)
		{
			num2 += (float)this.chunkSize / 2f;
		}
		Vector2 vector = new Vector2(num, num2);
		if (this.previousChunk != vector)
		{
			Vector2 result = vector - this.previousChunk;
			this.previousChunk = vector;
			return result;
		}
		return Vector2.zero;
	}

	// Token: 0x06000106 RID: 262 RVA: 0x00007658 File Offset: 0x00005858
	private void OnDrawGizmos()
	{
		if (this.chunks == null)
		{
			return;
		}
		foreach (GrassChunks.Chunk chunk in this.chunks.Values)
		{
			Gizmos.DrawWireCube(chunk.chunkCenter, Vector3.one * (float)this.chunkSize);
		}
	}

	// Token: 0x040000F7 RID: 247
	public int nChunks = 25;

	// Token: 0x040000F8 RID: 248
	public int chunkSize = 5;

	// Token: 0x040000F9 RID: 249
	private int chunkLength;

	// Token: 0x040000FA RID: 250
	private float topLeftX;

	// Token: 0x040000FB RID: 251
	private float topLeftZ;

	// Token: 0x040000FC RID: 252
	public Dictionary<Vector3, GrassChunks.Chunk> chunks;

	// Token: 0x040000FD RID: 253
	[Header("Grass")]
	public int grassDensity;

	// Token: 0x040000FE RID: 254
	private Vector2 previousChunk;

	// Token: 0x040000FF RID: 255
	public Transform target;

	// Token: 0x04000100 RID: 256
	private int maxLOD = 20;

	// Token: 0x0200010B RID: 267
	public class Chunk
	{
		// Token: 0x0600079E RID: 1950 RVA: 0x00025872 File Offset: 0x00023A72
		public Chunk(int lod, Vector3 chunkCenter)
		{
			this.lod = lod;
			this.chunkCenter = chunkCenter;
		}

		// Token: 0x0400072F RID: 1839
		public int lod;

		// Token: 0x04000730 RID: 1840
		public Vector3 chunkCenter;
	}
}
