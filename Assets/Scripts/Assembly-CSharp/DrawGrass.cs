using System.Collections.Generic;
using UnityEngine;

public class DrawGrass : MonoBehaviour
{
    public Mesh mesh;

    public MeshFilter filter;

    public Color AdjustedColor;

    [Range(1f, 600000f)]
    public int grassLimit = 50000;

    private Vector3 lastPosition = Vector3.zero;

    public int toolbarInt;

    [SerializeField]
    private List<Vector3> positions = new List<Vector3>();

    [SerializeField]
    private List<Color> colors = new List<Color>();

    [SerializeField]
    private List<int> indicies = new List<int>();

    [SerializeField]
    private List<Vector3> normals = new List<Vector3>();

    [SerializeField]
    private List<Vector2> length = new List<Vector2>();

    public bool painting;

    public bool removing;

    public bool editing;

    public int i;

    public float sizeWidth = 1f;

    public float sizeLength = 1f;

    public float density = 1f;

    public float normalLimit = 1f;

    public float rangeR;

    public float rangeG;

    public float rangeB;

    public LayerMask hitMask = 1;

    public LayerMask paintMask = 1;

    public float brushSize;

    private Vector3 mousePos;

    [HideInInspector]
    public Vector3 hitPosGizmo;

    private Vector3 hitPos;

    [HideInInspector]
    public Vector3 hitNormal;

    private int[] indi;

    private float updateRate = 0.5f;

    public Transform grassObject;

    public float chunkLength = 20f;

    public float chunkDensity = 10f;

    public int nChunks = 16;

    public int iterations;

    private Dictionary<Vector3, bool> currentPositions;

    public Transform target;

    private Vector3 currentGridPos;

    public int gridSize = 20;

    public void ClearMesh()
    {
        positions.Clear();
        indicies.Clear();
        normals.Clear();
        length.Clear();
        Object.Destroy(mesh);
        i = 0;
        positions = new List<Vector3>();
        indicies = new List<int>();
        colors = new List<Color>();
        normals = new List<Vector3>();
        length = new List<Vector2>();
    }

    private void Awake()
    {
        if (!CurrentSettings.grass)
        {
            Object.Destroy(grassObject.gameObject);
            Object.Destroy(base.gameObject);
        }
        else
        {
            ClearMesh();
            InvokeRepeating("SlowUpdate", 0f, updateRate);
            currentPositions = new Dictionary<Vector3, bool>();
        }
    }

    private void SlowUpdate()
    {
        if (!CurrentSettings.grass)
        {
            Object.Destroy(grassObject.gameObject);
            Object.Destroy(base.gameObject);
        }
        else
        {
            UpdateGrass();
        }
    }

    private void UpdateGrass()
    {
        if (!target)
        {
            if (!PlayerMovement.Instance)
            {
                return;
            }
            target = PlayerMovement.Instance.playerCam;
        }
        Vector3 vector = posToGridPos(target.position);
        if (!(currentGridPos != vector))
        {
            return;
        }
        _ = (vector - currentGridPos) / chunkLength;
        ClearMesh();
        currentGridPos = vector;
        int num = 5;
        int num2 = 0;
        int num3 = Mathf.FloorToInt(5f / 2f);
        int num4 = num3 + 1;
        int num5 = Mathf.FloorToInt((float)num / 2f);
        int num6 = num5 + 1;
        for (int i = -num3; i < num4; i++)
        {
            for (int j = -num3; j < num4; j++)
            {
                int d = 1;
                if (i <= -num5 || i >= num6 || j <= -num5 || j >= num6)
                {
                    d = 2;
                }
                Vector3 vector2 = currentGridPos + new Vector3(i, 0f, j) * gridSize;
                CreateNewMesh(new Vector3(i, 0f, j) * gridSize, d);
                num2++;
                Debug.DrawLine(vector2, vector2 + Vector3.up * 50f, Color.red, 50f);
            }
        }
        try
        {
            MonoBehaviour.print("setting grass mesh");
            mesh = new Mesh();
            mesh.SetVertices(positions);
            indi = indicies.ToArray();
            mesh.SetIndices(indi, MeshTopology.Points, 0);
            mesh.SetUVs(0, length);
            mesh.SetColors(colors);
            mesh.SetNormals(normals);
            filter.mesh = mesh;
        }
        catch
        {
            Debug.LogError("Failed to draw grass");
        }
    }

    public Vector3 posToGridPos(Vector3 point)
    {
        float num = point.x;
        float num2 = point.z;
        if (num < 0f)
        {
            num -= (float)gridSize;
        }
        if (num2 < 0f)
        {
            num2 -= (float)gridSize;
        }
        float num3 = num - num % (float)gridSize;
        float num4 = num2 - num2 % (float)gridSize;
        float x = num3 + (float)gridSize / 2f;
        num4 += (float)gridSize / 2f;
        return new Vector3(x, 0f, num4);
    }

    private void CreateNewMesh(Vector3 offset, int d)
    {
        if ((bool)PlayerMovement.Instance)
        {
            base.transform.position = PlayerMovement.Instance.transform.position;
        }
        float num = chunkDensity / (float)d;
        float num2 = chunkLength / num;
        for (int i = 0; (float)i < num; i++)
        {
            for (int j = 0; (float)j < num; j++)
            {
                float num3 = currentGridPos.x + offset.x - currentGridPos.x % num2;
                float num4 = currentGridPos.z + offset.z - currentGridPos.z % num2;
                float x = num3 + ((float)i - num / 2f) / num * chunkLength;
                float z = num4 + ((float)j - num / 2f) / num * chunkLength;
                Vector3 origin = new Vector3(x, base.transform.position.y + 50f, z);
                if (Physics.Raycast(new Ray(origin, Vector3.down), out var hitInfo, 200f, hitMask.value) && this.i < grassLimit && hitInfo.normal.y <= 1f + normalLimit && hitInfo.normal.y >= 1f - normalLimit && WorldUtility.WorldHeightToBiome(hitInfo.point.y) == TextureData.TerrainType.Grass && hitInfo.collider.gameObject.CompareTag("Terrain"))
                {
                    hitPos = hitInfo.point;
                    hitNormal = hitInfo.normal;
                    hitPos -= grassObject.transform.position;
                    positions.Add(hitPos);
                    indicies.Add(this.i);
                    length.Add(new Vector2(sizeWidth, sizeLength));
                    colors.Add(new Color(AdjustedColor.r + Random.Range(0f, 1f) * rangeR, AdjustedColor.g + Random.Range(0f, 1f) * rangeG, AdjustedColor.b + Random.Range(0f, 1f) * rangeB, 1f));
                    normals.Add(hitInfo.normal);
                    this.i++;
                }
            }
        }
    }
}
