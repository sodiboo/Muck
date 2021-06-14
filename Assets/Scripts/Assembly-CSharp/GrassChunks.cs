using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000034 RID: 52
public class GrassChunks : MonoBehaviour
{
	// Token: 0x06000113 RID: 275 RVA: 0x00002DB2 File Offset: 0x00000FB2
	private void Awake()
	{
		this.InitChunks();
		this.UpdateChunkCenters(Vector2.zero);
	}

	// Token: 0x06000114 RID: 276 RVA: 0x0000BB58 File Offset: 0x00009D58
	private void InitChunks()
	{
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.topLeftX = (float)(this.chunkSize * this.chunkLength) / -2f;
		this.topLeftZ = (float)(this.chunkSize * this.chunkLength) / 2f;
		this.chunks = new Dictionary<Vector3, GrassChunks.Chunk>();
	}

	// Token: 0x06000115 RID: 277 RVA: 0x0000BBBC File Offset: 0x00009DBC
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

	// Token: 0x06000116 RID: 278 RVA: 0x0000BD54 File Offset: 0x00009F54
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

	// Token: 0x06000117 RID: 279 RVA: 0x0000BDAC File Offset: 0x00009FAC
	private void UpdateChunkLOD()
	{
		this.target = base.transform;
		for (int i = 0; i < this.nChunks; i++)
		{
		}
	}

	// Token: 0x06000118 RID: 280 RVA: 0x0000BDD8 File Offset: 0x00009FD8
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

	// Token: 0x06000119 RID: 281 RVA: 0x0000BE1C File Offset: 0x0000A01C
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

	// Token: 0x0600011A RID: 282 RVA: 0x0000BF10 File Offset: 0x0000A110
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

	// Token: 0x0400011A RID: 282
	public int nChunks = 25;

	// Token: 0x0400011B RID: 283
	public int chunkSize = 5;

	// Token: 0x0400011C RID: 284
	private int chunkLength;

	// Token: 0x0400011D RID: 285
	private float topLeftX;

	// Token: 0x0400011E RID: 286
	private float topLeftZ;

	// Token: 0x0400011F RID: 287
	public Dictionary<Vector3, GrassChunks.Chunk> chunks;

	// Token: 0x04000120 RID: 288
	[Header("Grass")]
	public int grassDensity;

	// Token: 0x04000121 RID: 289
	private Vector2 previousChunk;

	// Token: 0x04000122 RID: 290
	public Transform target;

	// Token: 0x04000123 RID: 291
	private int maxLOD = 20;

	// Token: 0x02000035 RID: 53
	public class Chunk
	{
		// Token: 0x0600011C RID: 284 RVA: 0x00002DE4 File Offset: 0x00000FE4
		public Chunk(int lod, Vector3 chunkCenter)
		{
			this.lod = lod;
			this.chunkCenter = chunkCenter;
		}

		// Token: 0x04000124 RID: 292
		public int lod;

		// Token: 0x04000125 RID: 293
		public Vector3 chunkCenter;
	}
}
