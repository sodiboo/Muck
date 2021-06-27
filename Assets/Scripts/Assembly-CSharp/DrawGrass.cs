using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000102 RID: 258
public class DrawGrass : MonoBehaviour
{
	// Token: 0x060007A7 RID: 1959 RVA: 0x00027094 File Offset: 0x00025294
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

	// Token: 0x060007A8 RID: 1960 RVA: 0x00027118 File Offset: 0x00025318
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

	// Token: 0x060007A9 RID: 1961 RVA: 0x0002716F File Offset: 0x0002536F
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

	// Token: 0x060007AA RID: 1962 RVA: 0x0002719C File Offset: 0x0002539C
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

	// Token: 0x060007AB RID: 1963 RVA: 0x000273BC File Offset: 0x000255BC
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

	// Token: 0x060007AC RID: 1964 RVA: 0x0002743C File Offset: 0x0002563C
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

	// Token: 0x04000724 RID: 1828
	public Mesh mesh;

	// Token: 0x04000725 RID: 1829
	public MeshFilter filter;

	// Token: 0x04000726 RID: 1830
	public Color AdjustedColor;

	// Token: 0x04000727 RID: 1831
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x04000728 RID: 1832
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x04000729 RID: 1833
	public int toolbarInt;

	// Token: 0x0400072A RID: 1834
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x0400072B RID: 1835
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x0400072C RID: 1836
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x0400072D RID: 1837
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x0400072E RID: 1838
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x0400072F RID: 1839
	public bool painting;

	// Token: 0x04000730 RID: 1840
	public bool removing;

	// Token: 0x04000731 RID: 1841
	public bool editing;

	// Token: 0x04000732 RID: 1842
	public int i;

	// Token: 0x04000733 RID: 1843
	public float sizeWidth = 1f;

	// Token: 0x04000734 RID: 1844
	public float sizeLength = 1f;

	// Token: 0x04000735 RID: 1845
	public float density = 1f;

	// Token: 0x04000736 RID: 1846
	public float normalLimit = 1f;

	// Token: 0x04000737 RID: 1847
	public float rangeR;

	// Token: 0x04000738 RID: 1848
	public float rangeG;

	// Token: 0x04000739 RID: 1849
	public float rangeB;

	// Token: 0x0400073A RID: 1850
	public LayerMask hitMask = 1;

	// Token: 0x0400073B RID: 1851
	public LayerMask paintMask = 1;

	// Token: 0x0400073C RID: 1852
	public float brushSize;

	// Token: 0x0400073D RID: 1853
	private Vector3 mousePos;

	// Token: 0x0400073E RID: 1854
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x0400073F RID: 1855
	private Vector3 hitPos;

	// Token: 0x04000740 RID: 1856
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x04000741 RID: 1857
	private int[] indi;

	// Token: 0x04000742 RID: 1858
	private float updateRate = 0.5f;

	// Token: 0x04000743 RID: 1859
	public Transform grassObject;

	// Token: 0x04000744 RID: 1860
	public float chunkLength = 20f;

	// Token: 0x04000745 RID: 1861
	public float chunkDensity = 10f;

	// Token: 0x04000746 RID: 1862
	public int nChunks = 16;

	// Token: 0x04000747 RID: 1863
	public int iterations;

	// Token: 0x04000748 RID: 1864
	private Dictionary<Vector3, bool> currentPositions;

	// Token: 0x04000749 RID: 1865
	public Transform target;

	// Token: 0x0400074A RID: 1866
	private Vector3 currentGridPos;

	// Token: 0x0400074B RID: 1867
	public int gridSize = 20;
}
