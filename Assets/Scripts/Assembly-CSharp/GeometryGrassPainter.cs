using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000103 RID: 259
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[ExecuteInEditMode]
public class GeometryGrassPainter : MonoBehaviour
{
	// Token: 0x0400074C RID: 1868
	private Mesh mesh;

	// Token: 0x0400074D RID: 1869
	private MeshFilter filter;

	// Token: 0x0400074E RID: 1870
	public Color AdjustedColor;

	// Token: 0x0400074F RID: 1871
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x04000750 RID: 1872
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x04000751 RID: 1873
	public int toolbarInt;

	// Token: 0x04000752 RID: 1874
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x04000753 RID: 1875
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x04000754 RID: 1876
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x04000755 RID: 1877
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x04000756 RID: 1878
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x04000757 RID: 1879
	public bool painting;

	// Token: 0x04000758 RID: 1880
	public bool removing;

	// Token: 0x04000759 RID: 1881
	public bool editing;

	// Token: 0x0400075A RID: 1882
	public int i;

	// Token: 0x0400075B RID: 1883
	public float sizeWidth = 1f;

	// Token: 0x0400075C RID: 1884
	public float sizeLength = 1f;

	// Token: 0x0400075D RID: 1885
	public float density = 1f;

	// Token: 0x0400075E RID: 1886
	public float normalLimit = 1f;

	// Token: 0x0400075F RID: 1887
	public float rangeR;

	// Token: 0x04000760 RID: 1888
	public float rangeG;

	// Token: 0x04000761 RID: 1889
	public float rangeB;

	// Token: 0x04000762 RID: 1890
	public LayerMask hitMask = 1;

	// Token: 0x04000763 RID: 1891
	public LayerMask paintMask = 1;

	// Token: 0x04000764 RID: 1892
	public float brushSize;

	// Token: 0x04000765 RID: 1893
	private Vector3 mousePos;

	// Token: 0x04000766 RID: 1894
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x04000767 RID: 1895
	private Vector3 hitPos;

	// Token: 0x04000768 RID: 1896
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x04000769 RID: 1897
	private int[] indi;
}
