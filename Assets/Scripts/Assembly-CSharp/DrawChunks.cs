using System;
using System.Collections.Generic;
using UnityEngine;

public class DrawChunks : MonoBehaviour
{
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

	public void InitChunks(List<GameObject>[] chunks)
	{
		this.chunks = chunks;
	}

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

	public float DistanceFromChunk(int chunk)
	{
		Vector3 b = this.chunkCenters[chunk];
		return Vector3.Distance(this.player.position, b);
	}

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

	public ResourceGenerator resourceGen;

	[Header("Chunks")]
	public int nChunks = 256;

	private int chunkLength;

	private int chunkSize;

	public float updateRate = 1f;

	[Header("Render distance")]
	[Range(0f, 2000f)]
	public float drawDistance;

	public float minRenderDistance;

	public static readonly float maxRenderDistance = 1500f;

	public int drawnTrees;

	public int totalTrees;

	[Header("LOD")]
	public int maxLOD = 10;

	private bool[] visibleChunks;

	private int[] chunkLOD;

	public List<GameObject>[] chunks;

	private float topLeftX;

	private float topLeftZ;

	public Transform player;

	private int a;

	private Vector3[] chunkCenters;
}
