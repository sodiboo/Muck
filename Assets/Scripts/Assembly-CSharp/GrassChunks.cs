using System.Collections.Generic;
using UnityEngine;

public class GrassChunks : MonoBehaviour
{
    public class Chunk
    {
        public int lod;

        public Vector3 chunkCenter;

        public Chunk(int lod, Vector3 chunkCenter)
        {
            this.lod = lod;
            this.chunkCenter = chunkCenter;
        }
    }

    public int nChunks = 25;

    public int chunkSize = 5;

    private int chunkLength;

    private float topLeftX;

    private float topLeftZ;

    public Dictionary<Vector3, Chunk> chunks;

    [Header("Grass")]
    public int grassDensity;

    private Vector2 previousChunk;

    public Transform target;

    private int maxLOD = 20;

    private void Awake()
    {
        InitChunks();
        UpdateChunkCenters(Vector2.zero);
    }

    private void InitChunks()
    {
        chunkLength = Mathf.FloorToInt(Mathf.Sqrt(nChunks));
        topLeftX = (float)(chunkSize * chunkLength) / -2f;
        topLeftZ = (float)(chunkSize * chunkLength) / 2f;
        chunks = new Dictionary<Vector3, Chunk>();
    }

    private void UpdateChunkCenters(Vector2 dir)
    {
        Dictionary<Vector3, Chunk> dictionary = new Dictionary<Vector3, Chunk>();
        float num = base.transform.position.x - base.transform.position.x % (float)chunkSize;
        float num2 = base.transform.position.z - base.transform.position.z % (float)chunkSize;
        if (num < 0f)
        {
            num -= (float)chunkSize / 2f;
        }
        if (num > 0f)
        {
            num += (float)chunkSize / 2f;
        }
        if (num2 < 0f)
        {
            num2 -= (float)chunkSize / 2f;
        }
        if (num2 > 0f)
        {
            num2 += (float)chunkSize / 2f;
        }
        num += topLeftX;
        num2 += topLeftZ;
        MonoBehaviour.print("updaying chunk centers");
        for (int i = 0; i < nChunks; i++)
        {
            int num3 = Mathf.FloorToInt((float)i / (float)chunkLength) * chunkSize;
            int num4 = i % chunkLength * chunkSize;
            Vector3 vector = new Vector3(num + (float)num4 + (float)chunkSize / 2f, 0f, num2 - (float)num3 - (float)chunkSize / 2f);
            if (chunks.ContainsKey(vector))
            {
                dictionary.Add(vector, chunks[vector]);
                continue;
            }
            Chunk value = new Chunk(1, vector);
            dictionary.Add(vector, value);
        }
        chunks = dictionary;
    }

    private void Update()
    {
        Vector2 vector = FindPLayerChunk();
        if (vector != Vector2.zero)
        {
            vector.x /= chunkSize;
            vector.y /= chunkSize;
            MonoBehaviour.print(vector);
            UpdateChunkCenters(vector);
        }
    }

    private void UpdateChunkLOD()
    {
        target = base.transform;
        for (int i = 0; i < nChunks; i++)
        {
        }
    }

    public int FindLOD(float distanceFromChunk)
    {
        for (int i = 1; i < maxLOD + 1; i++)
        {
            if (distanceFromChunk < (float)chunkSize * 1.5f * (float)i)
            {
                return i * i;
            }
        }
        return maxLOD * maxLOD;
    }

    private Vector2 FindPLayerChunk()
    {
        float num = base.transform.position.x - base.transform.position.x % (float)chunkSize;
        float num2 = base.transform.position.z - base.transform.position.z % (float)chunkSize;
        if (num < 0f)
        {
            num -= (float)chunkSize / 2f;
        }
        if (num > 0f)
        {
            num += (float)chunkSize / 2f;
        }
        if (num2 < 0f)
        {
            num2 -= (float)chunkSize / 2f;
        }
        if (num2 > 0f)
        {
            num2 += (float)chunkSize / 2f;
        }
        Vector2 vector = new Vector2(num, num2);
        if (previousChunk != vector)
        {
            Vector2 result = vector - previousChunk;
            previousChunk = vector;
            return result;
        }
        return Vector2.zero;
    }

    private void OnDrawGizmos()
    {
        if (chunks == null)
        {
            return;
        }
        foreach (Chunk value in chunks.Values)
        {
            Gizmos.DrawWireCube(value.chunkCenter, Vector3.one * chunkSize);
        }
    }
}
