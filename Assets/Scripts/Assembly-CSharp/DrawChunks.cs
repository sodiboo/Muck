using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002D RID: 45
public class DrawChunks : MonoBehaviour
{
	// Token: 0x06000106 RID: 262 RVA: 0x00006C4C File Offset: 0x00004E4C
	private void Awake()
	{
		InvokeRepeating(nameof(UpdateChunks), 0f, this.updateRate);
		this.visibleChunks = new bool[this.nChunks];
		this.chunkLOD = new int[this.nChunks];
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.chunkSize = MapGenerator.mapChunkSize / this.chunkLength;
		this.minRenderDistance = Mathf.Sqrt((float)(this.chunkLength * this.chunkLength)) * this.resourceGen.worldScale * 1.25f;
		this.topLeftX = (float)(MapGenerator.mapChunkSize - 1) / -2f;
		this.topLeftZ = (float)(MapGenerator.mapChunkSize - 1) / 2f;
		this.InitChunkCenters();
	}

	// Token: 0x06000107 RID: 263 RVA: 0x00006D13 File Offset: 0x00004F13
	public void InitChunks(List<GameObject>[] chunks)
	{
		this.chunks = chunks;
	}

	// Token: 0x06000108 RID: 264 RVA: 0x00006D1C File Offset: 0x00004F1C
	public int FindChunk(int x, int y)
	{
		int num = Mathf.FloorToInt((float)x / (float)this.chunkSize);
		int num2 = Mathf.FloorToInt((float)(Mathf.FloorToInt((float)y / (float)this.chunkSize) * this.chunkLength));
		if (num2 > this.chunkLength * (this.chunkLength - 1))
		{
			num2 = this.chunkLength * this.chunkLength - 1;
		}
		if (num > this.chunkLength - 1)
		{
			num = this.chunkLength - 1;
		}
		return num + num2;
	}

	// Token: 0x06000109 RID: 265 RVA: 0x00006D90 File Offset: 0x00004F90
	private void UpdateChunks()
	{
		if (!this.player)
		{
			if (PlayerMovement.Instance)
			{
				this.player = PlayerMovement.Instance.playerCam.transform;
			}
			else
			{
				if (!Camera.main)
				{
					return;
				}
				this.player = Camera.main.transform;
			}
		}
		if (this.chunks == null)
		{
			return;
		}
		for (int i = 0; i < this.chunks.Length; i++)
		{
			float num = this.DistanceFromChunk(i);
			if (num < this.drawDistance)
			{
				int lod = this.FindLOD(num);
				this.DrawChunk(i, true, lod);
			}
			else
			{
				this.DrawChunk(i, false, 1);
			}
		}
	}

	// Token: 0x0600010A RID: 266 RVA: 0x00006E38 File Offset: 0x00005038
	private void DrawChunk(int c, bool draw, int lod)
	{
		if (this.a >= this.chunks.Length)
		{
			return;
		}
		if (draw == this.visibleChunks[c] && this.chunkLOD[c] == lod)
		{
			return;
		}
		this.visibleChunks[c] = draw;
		this.chunkLOD[c] = lod;
		if (this.chunks[c].Count < 1)
		{
			return;
		}
		for (int i = 0; i < this.chunks[c].Count; i++)
		{
			if (!(this.chunks[c][i] == null))
			{
				if (i % lod == 0)
				{
					if (draw)
					{
						if (!this.chunks[c][i].activeInHierarchy)
						{
							this.drawnTrees++;
						}
					}
					else if (this.chunks[c][i].activeInHierarchy)
					{
						this.drawnTrees--;
					}
					this.chunks[c][i].SetActive(draw);
				}
				else if (this.chunks[c][i].activeInHierarchy)
				{
					this.drawnTrees--;
					this.chunks[c][i].SetActive(false);
				}
			}
		}
	}

	// Token: 0x0600010B RID: 267 RVA: 0x00006F64 File Offset: 0x00005164
	private void InitChunkCenters()
	{
		this.chunkCenters = new Vector3[this.nChunks];
		for (int i = 0; i < this.nChunks; i++)
		{
			int num = Mathf.FloorToInt((float)i / (float)this.chunkLength) * this.chunkSize;
			int num2 = i % this.chunkLength * this.chunkSize;
			this.chunkCenters[i] = new Vector3(this.topLeftX + (float)num2 + (float)this.chunkSize / 2f, 0f, this.topLeftZ - (float)num - (float)this.chunkSize / 2f) * this.resourceGen.worldScale;
		}
	}

	// Token: 0x0600010C RID: 268 RVA: 0x00007014 File Offset: 0x00005214
	public float DistanceFromChunk(int chunk)
	{
		Vector3 b = this.chunkCenters[chunk];
		return Vector3.Distance(this.player.position, b);
	}

	// Token: 0x0600010D RID: 269 RVA: 0x00007040 File Offset: 0x00005240
	public int FindLOD(float distanceFromChunk)
	{
		for (int i = 1; i < this.maxLOD + 1; i++)
		{
			if (distanceFromChunk < this.minRenderDistance * (float)i)
			{
				return i * i;
			}
		}
		return this.maxLOD * this.maxLOD;
	}

	// Token: 0x04000105 RID: 261
	public ResourceGenerator resourceGen;

	// Token: 0x04000106 RID: 262
	[Header("Chunks")]
	public int nChunks = 256;

	// Token: 0x04000107 RID: 263
	private int chunkLength;

	// Token: 0x04000108 RID: 264
	private int chunkSize;

	// Token: 0x04000109 RID: 265
	public float updateRate = 1f;

	// Token: 0x0400010A RID: 266
	[Header("Render distance")]
	[Range(0f, 2000f)]
	public float drawDistance;

	// Token: 0x0400010B RID: 267
	public float minRenderDistance;

	// Token: 0x0400010C RID: 268
	public static readonly float maxRenderDistance = 1500f;

	// Token: 0x0400010D RID: 269
	public int drawnTrees;

	// Token: 0x0400010E RID: 270
	public int totalTrees;

	// Token: 0x0400010F RID: 271
	[Header("LOD")]
	public int maxLOD = 10;

	// Token: 0x04000110 RID: 272
	private bool[] visibleChunks;

	// Token: 0x04000111 RID: 273
	private int[] chunkLOD;

	// Token: 0x04000112 RID: 274
	public List<GameObject>[] chunks;

	// Token: 0x04000113 RID: 275
	private float topLeftX;

	// Token: 0x04000114 RID: 276
	private float topLeftZ;

	// Token: 0x04000115 RID: 277
	public Transform player;

	// Token: 0x04000116 RID: 278
	private int a;

	// Token: 0x04000117 RID: 279
	private Vector3[] chunkCenters;
}
