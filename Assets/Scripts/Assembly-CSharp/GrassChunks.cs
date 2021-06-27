using System;
using System.Collections.Generic;
using UnityEngine;

public class GrassChunks : MonoBehaviour
{
	private void Awake()
	{
		this.InitChunks();
		this.UpdateChunkCenters(Vector2.zero);
	}

	private void InitChunks()
	{
		this.chunkLength = Mathf.FloorToInt(Mathf.Sqrt((float)this.nChunks));
		this.topLeftX = (float)(this.chunkSize * this.chunkLength) / -2f;
		this.topLeftZ = (float)(this.chunkSize * this.chunkLength) / 2f;
		this.chunks = new Dictionary<Vector3, GrassChunks.Chunk>();
	}

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

	private void UpdateChunkLOD()
	{
		this.target = base.transform;
		for (int i = 0; i < this.nChunks; i++)
		{
		}
	}

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

	public int nChunks = 25;

	public int chunkSize = 5;

	private int chunkLength;

	private float topLeftX;

	private float topLeftZ;

	public Dictionary<Vector3, GrassChunks.Chunk> chunks;

	[Header("Grass")]
	public int grassDensity;

	private Vector2 previousChunk;

	public Transform target;

	private int maxLOD = 20;

	public class Chunk
	{
		public Chunk(int lod, Vector3 chunkCenter)
		{
			this.lod = lod;
			this.chunkCenter = chunkCenter;
		}

		public int lod;

		public Vector3 chunkCenter;
	}
}
