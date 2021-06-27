using System;
using UnityEngine;

public static class MeshGenerator
{
	public static MeshData GenerateTerrainMesh(float[,] heightMap, float heightMultiplier, AnimationCurve heightCurve, int levelOfDetail)
	{
		int length = heightMap.GetLength(0);
		int length2 = heightMap.GetLength(1);
		float num = (float)(length - 1) / -2f;
		float num2 = (float)(length2 - 1) / 2f;
		int num3 = (levelOfDetail == 0) ? 1 : (levelOfDetail * 2);
		int num4 = (length - 1) / num3 + 1;
		MeshData meshData = new MeshData(num4, num4);
		int num5 = 0;
		for (int i = 0; i < length2; i += num3)
		{
			for (int j = 0; j < length; j += num3)
			{
				meshData.vertices[num5] = new Vector3(num + (float)j, heightCurve.Evaluate(heightMap[j, i]) * heightMultiplier, num2 - (float)i);
				meshData.uvs[num5] = new Vector2((float)j / (float)length, (float)i / (float)length2);
				if (j < length - 1 && i < length2 - 1)
				{
					meshData.AddTriangle(num5, num5 + num4 + 1, num5 + num4);
					meshData.AddTriangle(num5 + num4 + 1, num5, num5 + 1);
				}
				num5++;
			}
		}
		return meshData;
	}
}
