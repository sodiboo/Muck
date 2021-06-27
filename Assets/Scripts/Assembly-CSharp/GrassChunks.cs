using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003F RID: 63
public class GrassChunks : MonoBehaviour
{
	// Token: 0x0600016D RID: 365 RVA: 0x00008ED2 File Offset: 0x000070D2
	private void Awake()
	{
		this.InitChunks();
		this.UpdateChunkCenters(Vector2.zero);
	}

	// Token: 0x0600016E RID: 366 RVA: 0x00008EE8 File Offset: 0x000070E8
	private void InitChunks()
	{
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.topLeftX = (float)(this.chunkSize * this.chunkLength) / -2f;
		this.topLeftZ = (float)(this.chunkSize * this.chunkLength) / 2f;
		this.chunks = new Dictionary<Vector3, GrassChunks.Chunk>();
	}

	// Token: 0x0600016F RID: 367 RVA: 0x00008F4C File Offset: 0x0000714C
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

	// Token: 0x06000170 RID: 368 RVA: 0x000090E4 File Offset: 0x000072E4
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

	// Token: 0x06000171 RID: 369 RVA: 0x0000913C File Offset: 0x0000733C
	private void UpdateChunkLOD()
	{
		this.target = base.transform;
		for (int i = 0; i < this.nChunks; i++)
		{
		}
	}

	// Token: 0x06000172 RID: 370 RVA: 0x00009168 File Offset: 0x00007368
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

	// Token: 0x06000173 RID: 371 RVA: 0x000091AC File Offset: 0x000073AC
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

	// Token: 0x06000174 RID: 372 RVA: 0x000092A0 File Offset: 0x000074A0
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

	// Token: 0x0400016C RID: 364
	public int nChunks = 25;

	// Token: 0x0400016D RID: 365
	public int chunkSize = 5;

	// Token: 0x0400016E RID: 366
	private int chunkLength;

	// Token: 0x0400016F RID: 367
	private float topLeftX;

	// Token: 0x04000170 RID: 368
	private float topLeftZ;

	// Token: 0x04000171 RID: 369
	public Dictionary<Vector3, GrassChunks.Chunk> chunks;

	// Token: 0x04000172 RID: 370
	[Header("Grass")]
	public int grassDensity;

	// Token: 0x04000173 RID: 371
	private Vector2 previousChunk;

	// Token: 0x04000174 RID: 372
	public Transform target;

	// Token: 0x04000175 RID: 373
	private int maxLOD = 20;

	// Token: 0x02000143 RID: 323
	public class Chunk
	{
		// Token: 0x060008F1 RID: 2289 RVA: 0x0002C30D File Offset: 0x0002A50D
		public Chunk(int lod, Vector3 chunkCenter)
		{
			this.lod = lod;
			this.chunkCenter = chunkCenter;
		}

		// Token: 0x04000890 RID: 2192
		public int lod;

		// Token: 0x04000891 RID: 2193
		public Vector3 chunkCenter;
	}
}
