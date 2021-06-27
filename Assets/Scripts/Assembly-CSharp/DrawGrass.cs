using System.Collections.Generic;
using UnityEngine;

public class DrawGrass : MonoBehaviour
{
	public void ClearMesh()
	{
		this.positions.Clear();
		this.indicies.Clear();
		this.normals.Clear();
		this.length.Clear();
		Destroy(this.mesh);
		this.i = 0;
		this.positions = new List<Vector3>();
		this.indicies = new List<int>();
		this.colors = new List<Color>();
		this.normals = new List<Vector3>();
		this.length = new List<Vector2>();
	}

	private void Awake()
	{
		if (!CurrentSettings.grass)
		{
			Destroy(this.grassObject.gameObject);
			Destroy(base.gameObject);
			return;
		}
		this.ClearMesh();
		InvokeRepeating(nameof(SlowUpdate), 0f, this.updateRate);
		this.currentPositions = new Dictionary<Vector3, bool>();
	}

	private void SlowUpdate()
	{
		if (!CurrentSettings.grass)
		{
			Destroy(this.grassObject.gameObject);
			Destroy(base.gameObject);
			return;
		}
		this.UpdateGrass();
	}

	private void UpdateGrass()
	{
		if (!this.target)
		{
			if (!PlayerMovement.Instance)
			{
				return;
			}
			this.target = PlayerMovement.Instance.playerCam;
		}
		Vector3 vector = this.posToGridPos(this.target.position);
		if (this.currentGridPos != vector)
		{
			this.ClearMesh();
			this.currentGridPos = vector;
			float num = (float)5;
			int num2 = 5;
			int num3 = 0;
			int num4 = Mathf.FloorToInt(num / 2f);
			int num5 = num4 + 1;
			int num6 = Mathf.FloorToInt((float)num2 / 2f);
			int num7 = num6 + 1;
			for (int i = -num4; i < num5; i++)
			{
				for (int j = -num4; j < num5; j++)
				{
					int d = 1;
					if (i <= -num6 || i >= num7 || j <= -num6 || j >= num7)
					{
						d = 2;
					}
					Vector3 vector2 = this.currentGridPos + new Vector3((float)i, 0f, (float)j) * (float)this.gridSize;
					this.CreateNewMesh(new Vector3((float)i, 0f, (float)j) * (float)this.gridSize, d);
					num3++;
					Debug.DrawLine(vector2, vector2 + Vector3.up * 50f, Color.red, 50f);
				}
			}
			try
			{
				MonoBehaviour.print("setting grass mesh");
				this.mesh = new Mesh();
				this.mesh.SetVertices(this.positions);
				this.indi = this.indicies.ToArray();
				this.mesh.SetIndices(this.indi, MeshTopology.Points, 0);
				this.mesh.SetUVs(0, this.length);
				this.mesh.SetColors(this.colors);
				this.mesh.SetNormals(this.normals);
				this.filter.mesh = this.mesh;
			}
			catch
			{
				Debug.LogError("Failed to draw grass");
			}
		}
	}

	public Vector3 posToGridPos(Vector3 point)
	{
		float num = point.x;
		float num2 = point.z;
		if (num < 0f)
		{
			num -= (float)this.gridSize;
		}
		if (num2 < 0f)
		{
			num2 -= (float)this.gridSize;
		}
		float num3 = num - num % (float)this.gridSize;
		float num4 = num2 - num2 % (float)this.gridSize;
		float x = num3 + (float)this.gridSize / 2f;
		num4 += (float)this.gridSize / 2f;
		return new Vector3(x, 0f, num4);
	}

	private void CreateNewMesh(Vector3 offset, int d)
	{
		if (PlayerMovement.Instance)
		{
			base.transform.position = PlayerMovement.Instance.transform.position;
		}
		float num = this.chunkDensity / (float)d;
		float num2 = this.chunkLength / num;
		int num3 = 0;
		while ((float)num3 < num)
		{
			int num4 = 0;
			while ((float)num4 < num)
			{
				float num5 = this.currentGridPos.x + offset.x - this.currentGridPos.x % num2;
				float num6 = this.currentGridPos.z + offset.z - this.currentGridPos.z % num2;
				float x = num5 + ((float)num3 - num / 2f) / num * this.chunkLength;
				float z = num6 + ((float)num4 - num / 2f) / num * this.chunkLength;
				Vector3 origin = new Vector3(x, base.transform.position.y + 50f, z);
				RaycastHit raycastHit;
				if (Physics.Raycast(new Ray(origin, Vector3.down), out raycastHit, 200f, this.hitMask.value) && this.i < this.grassLimit && raycastHit.normal.y <= 1f + this.normalLimit && raycastHit.normal.y >= 1f - this.normalLimit && WorldUtility.WorldHeightToBiome(raycastHit.point.y) == TextureData.TerrainType.Grass && raycastHit.collider.gameObject.CompareTag("Terrain"))
				{
					this.hitPos = raycastHit.point;
					this.hitNormal = raycastHit.normal;
					this.hitPos -= this.grassObject.transform.position;
					this.positions.Add(this.hitPos);
					this.indicies.Add(this.i);
					this.length.Add(new Vector2(this.sizeWidth, this.sizeLength));
					this.colors.Add(new Color(this.AdjustedColor.r + Random.Range(0f, 1f) * this.rangeR, this.AdjustedColor.g + Random.Range(0f, 1f) * this.rangeG, this.AdjustedColor.b + Random.Range(0f, 1f) * this.rangeB, 1f));
					this.normals.Add(raycastHit.normal);
					this.i++;
				}
				num4++;
			}
			num3++;
		}
	}

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
}
