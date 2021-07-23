using System.Collections.Generic;
using UnityEngine;

public class DrawChunks : MonoBehaviour
{
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

    private void Awake()
    {
        InvokeRepeating("UpdateChunks", 0f, updateRate);
        visibleChunks = new bool[nChunks];
        chunkLOD = new int[nChunks];
        chunkLength = Mathf.FloorToInt(Mathf.Sqrt(nChunks));
        chunkSize = MapGenerator.mapChunkSize / chunkLength;
        minRenderDistance = Mathf.Sqrt(chunkLength * chunkLength) * resourceGen.worldScale * 1.25f;
        topLeftX = (float)(MapGenerator.mapChunkSize - 1) / -2f;
        topLeftZ = (float)(MapGenerator.mapChunkSize - 1) / 2f;
        InitChunkCenters();
    }

    public void InitChunks(List<GameObject>[] chunks)
    {
        this.chunks = chunks;
    }

    public int FindChunk(int x, int y)
    {
        int num = Mathf.FloorToInt((float)x / (float)chunkSize);
        int num2 = Mathf.FloorToInt(Mathf.FloorToInt((float)y / (float)chunkSize) * chunkLength);
        if (num2 > chunkLength * (chunkLength - 1))
        {
            num2 = chunkLength * chunkLength - 1;
        }
        if (num > chunkLength - 1)
        {
            num = chunkLength - 1;
        }
        return num + num2;
    }

    private void UpdateChunks()
    {
        if (!player)
        {
            if ((bool)PlayerMovement.Instance)
            {
                player = PlayerMovement.Instance.playerCam.transform;
            }
            else
            {
                if (!Camera.main)
                {
                    return;
                }
                player = Camera.main.transform;
            }
        }
        if (chunks == null)
        {
            return;
        }
        for (int i = 0; i < chunks.Length; i++)
        {
            float num = DistanceFromChunk(i);
            if (num < drawDistance)
            {
                int lod = FindLOD(num);
                DrawChunk(i, draw: true, lod);
            }
            else
            {
                DrawChunk(i, draw: false, 1);
            }
        }
    }

    private void DrawChunk(int c, bool draw, int lod)
    {
        if (a >= chunks.Length || (draw == visibleChunks[c] && chunkLOD[c] == lod))
        {
            return;
        }
        visibleChunks[c] = draw;
        chunkLOD[c] = lod;
        if (chunks[c].Count < 1)
        {
            return;
        }
        for (int i = 0; i < chunks[c].Count; i++)
        {
            if (chunks[c][i] == null)
            {
                continue;
            }
            if (i % lod == 0)
            {
                if (draw)
                {
                    if (!chunks[c][i].activeInHierarchy)
                    {
                        drawnTrees++;
                    }
                }
                else if (chunks[c][i].activeInHierarchy)
                {
                    drawnTrees--;
                }
                chunks[c][i].SetActive(draw);
            }
            else if (chunks[c][i].activeInHierarchy)
            {
                drawnTrees--;
                chunks[c][i].SetActive(value: false);
            }
        }
    }

    private void InitChunkCenters()
    {
        chunkCenters = new Vector3[nChunks];
        for (int i = 0; i < nChunks; i++)
        {
            int num = Mathf.FloorToInt((float)i / (float)chunkLength) * chunkSize;
            int num2 = i % chunkLength * chunkSize;
            chunkCenters[i] = new Vector3(topLeftX + (float)num2 + (float)chunkSize / 2f, 0f, topLeftZ - (float)num - (float)chunkSize / 2f) * resourceGen.worldScale;
        }
    }

    public float DistanceFromChunk(int chunk)
    {
        Vector3 b = chunkCenters[chunk];
        return Vector3.Distance(player.position, b);
    }

    public int FindLOD(float distanceFromChunk)
    {
        for (int i = 1; i < maxLOD + 1; i++)
        {
            if (distanceFromChunk < minRenderDistance * (float)i)
            {
                return i * i;
            }
        }
        return maxLOD * maxLOD;
    }
}
