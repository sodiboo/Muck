using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000125 RID: 293
public class DrawGrass : MonoBehaviour
{
	// Token: 0x0600072A RID: 1834 RVA: 0x000241D4 File Offset: 0x000223D4
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

	// Token: 0x0600072B RID: 1835 RVA: 0x00024258 File Offset: 0x00022458
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

	// Token: 0x0600072C RID: 1836 RVA: 0x00006BDC File Offset: 0x00004DDC
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

	// Token: 0x0600072D RID: 1837 RVA: 0x000242B0 File Offset: 0x000224B0
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

	// Token: 0x0600072E RID: 1838 RVA: 0x000244D0 File Offset: 0x000226D0
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

	// Token: 0x0600072F RID: 1839 RVA: 0x00024550 File Offset: 0x00022750
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

	// Token: 0x04000741 RID: 1857
	public Mesh mesh;

	// Token: 0x04000742 RID: 1858
	public MeshFilter filter;

	// Token: 0x04000743 RID: 1859
	public Color AdjustedColor;

	// Token: 0x04000744 RID: 1860
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x04000745 RID: 1861
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x04000746 RID: 1862
	public int toolbarInt;

	// Token: 0x04000747 RID: 1863
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x04000748 RID: 1864
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x04000749 RID: 1865
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x0400074A RID: 1866
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x0400074B RID: 1867
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x0400074C RID: 1868
	public bool painting;

	// Token: 0x0400074D RID: 1869
	public bool removing;

	// Token: 0x0400074E RID: 1870
	public bool editing;

	// Token: 0x0400074F RID: 1871
	public int i;

	// Token: 0x04000750 RID: 1872
	public float sizeWidth = 1f;

	// Token: 0x04000751 RID: 1873
	public float sizeLength = 1f;

	// Token: 0x04000752 RID: 1874
	public float density = 1f;

	// Token: 0x04000753 RID: 1875
	public float normalLimit = 1f;

	// Token: 0x04000754 RID: 1876
	public float rangeR;

	// Token: 0x04000755 RID: 1877
	public float rangeG;

	// Token: 0x04000756 RID: 1878
	public float rangeB;

	// Token: 0x04000757 RID: 1879
	public LayerMask hitMask = 1;

	// Token: 0x04000758 RID: 1880
	public LayerMask paintMask = 1;

	// Token: 0x04000759 RID: 1881
	public float brushSize;

	// Token: 0x0400075A RID: 1882
	private Vector3 mousePos;

	// Token: 0x0400075B RID: 1883
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x0400075C RID: 1884
	private Vector3 hitPos;

	// Token: 0x0400075D RID: 1885
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x0400075E RID: 1886
	private int[] indi;

	// Token: 0x0400075F RID: 1887
	private float updateRate = 0.5f;

	// Token: 0x04000760 RID: 1888
	public Transform grassObject;

	// Token: 0x04000761 RID: 1889
	public float chunkLength = 20f;

	// Token: 0x04000762 RID: 1890
	public float chunkDensity = 10f;

	// Token: 0x04000763 RID: 1891
	public int nChunks = 16;

	// Token: 0x04000764 RID: 1892
	public int iterations;

	// Token: 0x04000765 RID: 1893
	private Dictionary<Vector3, bool> currentPositions;

	// Token: 0x04000766 RID: 1894
	public Transform target;

	// Token: 0x04000767 RID: 1895
	private Vector3 currentGridPos;

	// Token: 0x04000768 RID: 1896
	public int gridSize = 20;
}
