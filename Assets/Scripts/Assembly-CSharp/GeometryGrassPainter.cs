using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000126 RID: 294
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[ExecuteInEditMode]
public class GeometryGrassPainter : MonoBehaviour
{
	// Token: 0x04000769 RID: 1897
	private Mesh mesh;

	// Token: 0x0400076A RID: 1898
	private MeshFilter filter;

	// Token: 0x0400076B RID: 1899
	public Color AdjustedColor;

	// Token: 0x0400076C RID: 1900
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x0400076D RID: 1901
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x0400076E RID: 1902
	public int toolbarInt;

	// Token: 0x0400076F RID: 1903
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x04000770 RID: 1904
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x04000771 RID: 1905
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x04000772 RID: 1906
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x04000773 RID: 1907
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x04000774 RID: 1908
	public bool painting;

	// Token: 0x04000775 RID: 1909
	public bool removing;

	// Token: 0x04000776 RID: 1910
	public bool editing;

	// Token: 0x04000777 RID: 1911
	public int i;

	// Token: 0x04000778 RID: 1912
	public float sizeWidth = 1f;

	// Token: 0x04000779 RID: 1913
	public float sizeLength = 1f;

	// Token: 0x0400077A RID: 1914
	public float density = 1f;

	// Token: 0x0400077B RID: 1915
	public float normalLimit = 1f;

	// Token: 0x0400077C RID: 1916
	public float rangeR;

	// Token: 0x0400077D RID: 1917
	public float rangeG;

	// Token: 0x0400077E RID: 1918
	public float rangeB;

	// Token: 0x0400077F RID: 1919
	public LayerMask hitMask = 1;

	// Token: 0x04000780 RID: 1920
	public LayerMask paintMask = 1;

	// Token: 0x04000781 RID: 1921
	public float brushSize;

	// Token: 0x04000782 RID: 1922
	private Vector3 mousePos;

	// Token: 0x04000783 RID: 1923
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x04000784 RID: 1924
	private Vector3 hitPos;

	// Token: 0x04000785 RID: 1925
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x04000786 RID: 1926
	private int[] indi;
}
