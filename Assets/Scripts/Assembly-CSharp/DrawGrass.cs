
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000DA RID: 218
public class DrawGrass : MonoBehaviour
{
	// Token: 0x0600068B RID: 1675 RVA: 0x00020EA0 File Offset: 0x0001F0A0
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

	// Token: 0x0600068C RID: 1676 RVA: 0x00020F24 File Offset: 0x0001F124
	private void Awake()
	{
		if (!CurrentSettings.grass)
		{
		Destroy(this.grassObject.gameObject);
		Destroy(base.gameObject);
			return;
		}
		this.ClearMesh();
		base.InvokeRepeating("SlowUpdate", 0f, this.updateRate);
		this.currentPositions = new Dictionary<Vector3, bool>();
	}

	// Token: 0x0600068D RID: 1677 RVA: 0x00020F7B File Offset: 0x0001F17B
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

	// Token: 0x0600068E RID: 1678 RVA: 0x00020FA8 File Offset: 0x0001F1A8
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

	// Token: 0x0600068F RID: 1679 RVA: 0x000211C8 File Offset: 0x0001F3C8
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

	// Token: 0x06000690 RID: 1680 RVA: 0x00021248 File Offset: 0x0001F448
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

	// Token: 0x040005FA RID: 1530
	public Mesh mesh;

	// Token: 0x040005FB RID: 1531
	public MeshFilter filter;

	// Token: 0x040005FC RID: 1532
	public Color AdjustedColor;

	// Token: 0x040005FD RID: 1533
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x040005FE RID: 1534
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x040005FF RID: 1535
	public int toolbarInt;

	// Token: 0x04000600 RID: 1536
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x04000601 RID: 1537
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x04000602 RID: 1538
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x04000603 RID: 1539
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x04000604 RID: 1540
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x04000605 RID: 1541
	public bool painting;

	// Token: 0x04000606 RID: 1542
	public bool removing;

	// Token: 0x04000607 RID: 1543
	public bool editing;

	// Token: 0x04000608 RID: 1544
	public int i;

	// Token: 0x04000609 RID: 1545
	public float sizeWidth = 1f;

	// Token: 0x0400060A RID: 1546
	public float sizeLength = 1f;

	// Token: 0x0400060B RID: 1547
	public float density = 1f;

	// Token: 0x0400060C RID: 1548
	public float normalLimit = 1f;

	// Token: 0x0400060D RID: 1549
	public float rangeR;

	// Token: 0x0400060E RID: 1550
	public float rangeG;

	// Token: 0x0400060F RID: 1551
	public float rangeB;

	// Token: 0x04000610 RID: 1552
	public LayerMask hitMask = 1;

	// Token: 0x04000611 RID: 1553
	public LayerMask paintMask = 1;

	// Token: 0x04000612 RID: 1554
	public float brushSize;

	// Token: 0x04000613 RID: 1555
	private Vector3 mousePos;

	// Token: 0x04000614 RID: 1556
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x04000615 RID: 1557
	private Vector3 hitPos;

	// Token: 0x04000616 RID: 1558
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x04000617 RID: 1559
	private int[] indi;

	// Token: 0x04000618 RID: 1560
	private float updateRate = 0.5f;

	// Token: 0x04000619 RID: 1561
	public Transform grassObject;

	// Token: 0x0400061A RID: 1562
	public float chunkLength = 20f;

	// Token: 0x0400061B RID: 1563
	public float chunkDensity = 10f;

	// Token: 0x0400061C RID: 1564
	public int nChunks = 16;

	// Token: 0x0400061D RID: 1565
	public int iterations;

	// Token: 0x0400061E RID: 1566
	private Dictionary<Vector3, bool> currentPositions;

	// Token: 0x0400061F RID: 1567
	public Transform target;

	// Token: 0x04000620 RID: 1568
	private Vector3 currentGridPos;

	// Token: 0x04000621 RID: 1569
	public int gridSize = 20;
}
