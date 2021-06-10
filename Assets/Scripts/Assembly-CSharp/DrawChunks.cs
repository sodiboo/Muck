
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000020 RID: 32
public class DrawChunks : MonoBehaviour
{
	// Token: 0x060000B9 RID: 185 RVA: 0x000059B8 File Offset: 0x00003BB8
	private void Awake()
	{
		base.InvokeRepeating("UpdateChunks", 0f, this.updateRate);
		this.visibleChunks = new bool[this.nChunks];
		this.chunkLOD = new int[this.nChunks];
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.chunkSize = MapGenerator.mapChunkSize / this.chunkLength;
		this.minRenderDistance = Mathf.Sqrt((float)(this.chunkLength * this.chunkLength)) * this.resourceGen.worldScale * 1.25f;
		this.topLeftX = (float)(MapGenerator.mapChunkSize - 1) / -2f;
		this.topLeftZ = (float)(MapGenerator.mapChunkSize - 1) / 2f;
		this.InitChunkCenters();
	}

	// Token: 0x060000BA RID: 186 RVA: 0x00005A7F File Offset: 0x00003C7F
	public void InitChunks(List<GameObject>[] chunks)
	{
		this.chunks = chunks;
	}

	// Token: 0x060000BB RID: 187 RVA: 0x00005A88 File Offset: 0x00003C88
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

	// Token: 0x060000BC RID: 188 RVA: 0x00005AFC File Offset: 0x00003CFC
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

	// Token: 0x060000BD RID: 189 RVA: 0x00005BA4 File Offset: 0x00003DA4
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

	// Token: 0x060000BE RID: 190 RVA: 0x00005CD0 File Offset: 0x00003ED0
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

	// Token: 0x060000BF RID: 191 RVA: 0x00005D80 File Offset: 0x00003F80
	public float DistanceFromChunk(int chunk)
	{
		Vector3 b = this.chunkCenters[chunk];
		return Vector3.Distance(this.player.position, b);
	}

	// Token: 0x060000C0 RID: 192 RVA: 0x00005DAC File Offset: 0x00003FAC
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

	// Token: 0x040000AF RID: 175
	public ResourceGenerator resourceGen;

	// Token: 0x040000B0 RID: 176
	[Header("Chunks")]
	public int nChunks = 256;

	// Token: 0x040000B1 RID: 177
	private int chunkLength;

	// Token: 0x040000B2 RID: 178
	private int chunkSize;

	// Token: 0x040000B3 RID: 179
	public float updateRate = 1f;

	// Token: 0x040000B4 RID: 180
	[Header("Render distance")]
	[Range(0f, 2000f)]
	public float drawDistance;

	// Token: 0x040000B5 RID: 181
	public float minRenderDistance;

	// Token: 0x040000B6 RID: 182
	public static readonly float maxRenderDistance = 1500f;

	// Token: 0x040000B7 RID: 183
	public int drawnTrees;

	// Token: 0x040000B8 RID: 184
	public int totalTrees;

	// Token: 0x040000B9 RID: 185
	[Header("LOD")]
	public int maxLOD = 10;

	// Token: 0x040000BA RID: 186
	private bool[] visibleChunks;

	// Token: 0x040000BB RID: 187
	private int[] chunkLOD;

	// Token: 0x040000BC RID: 188
	public List<GameObject>[] chunks;

	// Token: 0x040000BD RID: 189
	private float topLeftX;

	// Token: 0x040000BE RID: 190
	private float topLeftZ;

	// Token: 0x040000BF RID: 191
	public Transform player;

	// Token: 0x040000C0 RID: 192
	private int a;

	// Token: 0x040000C1 RID: 193
	private Vector3[] chunkCenters;
}
