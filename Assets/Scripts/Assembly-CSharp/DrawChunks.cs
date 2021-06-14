using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000026 RID: 38
public class DrawChunks : MonoBehaviour
{
	// Token: 0x060000C5 RID: 197 RVA: 0x0000A22C File Offset: 0x0000842C
	private void Awake()
	{
		base.InvokeRepeating(nameof(UpdateChunks), 0f, this.updateRate);
		this.visibleChunks = new bool[this.nChunks];
		this.chunkLOD = new int[this.nChunks];
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.chunkSize = MapGenerator.mapChunkSize / this.chunkLength;
		this.minRenderDistance = Mathf.Sqrt((float)(this.chunkLength * this.chunkLength)) * this.resourceGen.worldScale * 1.25f;
		this.topLeftX = (float)(MapGenerator.mapChunkSize - 1) / -2f;
		this.topLeftZ = (float)(MapGenerator.mapChunkSize - 1) / 2f;
		this.InitChunkCenters();
	}

	// Token: 0x060000C6 RID: 198 RVA: 0x00002B38 File Offset: 0x00000D38
	public void InitChunks(List<GameObject>[] chunks)
	{
		this.chunks = chunks;
	}

	// Token: 0x060000C7 RID: 199 RVA: 0x0000A2F4 File Offset: 0x000084F4
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

	// Token: 0x060000C8 RID: 200 RVA: 0x0000A368 File Offset: 0x00008568
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

	// Token: 0x060000C9 RID: 201 RVA: 0x0000A410 File Offset: 0x00008610
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

	// Token: 0x060000CA RID: 202 RVA: 0x0000A53C File Offset: 0x0000873C
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

	// Token: 0x060000CB RID: 203 RVA: 0x0000A5EC File Offset: 0x000087EC
	public float DistanceFromChunk(int chunk)
	{
		Vector3 b = this.chunkCenters[chunk];
		return Vector3.Distance(this.player.position, b);
	}

	// Token: 0x060000CC RID: 204 RVA: 0x0000A618 File Offset: 0x00008818
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

	// Token: 0x040000C3 RID: 195
	public ResourceGenerator resourceGen;

	// Token: 0x040000C4 RID: 196
	[Header("Chunks")]
	public int nChunks = 256;

	// Token: 0x040000C5 RID: 197
	private int chunkLength;

	// Token: 0x040000C6 RID: 198
	private int chunkSize;

	// Token: 0x040000C7 RID: 199
	public float updateRate = 1f;

	// Token: 0x040000C8 RID: 200
	[Header("Render distance")]
	[Range(0f, 2000f)]
	public float drawDistance;

	// Token: 0x040000C9 RID: 201
	public float minRenderDistance;

	// Token: 0x040000CA RID: 202
	public static readonly float maxRenderDistance = 1500f;

	// Token: 0x040000CB RID: 203
	public int drawnTrees;

	// Token: 0x040000CC RID: 204
	public int totalTrees;

	// Token: 0x040000CD RID: 205
	[Header("LOD")]
	public int maxLOD = 10;

	// Token: 0x040000CE RID: 206
	private bool[] visibleChunks;

	// Token: 0x040000CF RID: 207
	private int[] chunkLOD;

	// Token: 0x040000D0 RID: 208
	public List<GameObject>[] chunks;

	// Token: 0x040000D1 RID: 209
	private float topLeftX;

	// Token: 0x040000D2 RID: 210
	private float topLeftZ;

	// Token: 0x040000D3 RID: 211
	public Transform player;

	// Token: 0x040000D4 RID: 212
	private int a;

	// Token: 0x040000D5 RID: 213
	private Vector3[] chunkCenters;
}
