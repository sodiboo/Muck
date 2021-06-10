
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000DB RID: 219
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[ExecuteInEditMode]
public class GeometryGrassPainter : MonoBehaviour
{
	// Token: 0x04000622 RID: 1570
	private Mesh mesh;

	// Token: 0x04000623 RID: 1571
	private MeshFilter filter;

	// Token: 0x04000624 RID: 1572
	public Color AdjustedColor;

	// Token: 0x04000625 RID: 1573
	[Range(1f, 600000f)]
	public int grassLimit = 50000;

	// Token: 0x04000626 RID: 1574
	private Vector3 lastPosition = Vector3.zero;

	// Token: 0x04000627 RID: 1575
	public int toolbarInt;

	// Token: 0x04000628 RID: 1576
	[SerializeField]
	private List<Vector3> positions = new List<Vector3>();

	// Token: 0x04000629 RID: 1577
	[SerializeField]
	private List<Color> colors = new List<Color>();

	// Token: 0x0400062A RID: 1578
	[SerializeField]
	private List<int> indicies = new List<int>();

	// Token: 0x0400062B RID: 1579
	[SerializeField]
	private List<Vector3> normals = new List<Vector3>();

	// Token: 0x0400062C RID: 1580
	[SerializeField]
	private List<Vector2> length = new List<Vector2>();

	// Token: 0x0400062D RID: 1581
	public bool painting;

	// Token: 0x0400062E RID: 1582
	public bool removing;

	// Token: 0x0400062F RID: 1583
	public bool editing;

	// Token: 0x04000630 RID: 1584
	public int i;

	// Token: 0x04000631 RID: 1585
	public float sizeWidth = 1f;

	// Token: 0x04000632 RID: 1586
	public float sizeLength = 1f;

	// Token: 0x04000633 RID: 1587
	public float density = 1f;

	// Token: 0x04000634 RID: 1588
	public float normalLimit = 1f;

	// Token: 0x04000635 RID: 1589
	public float rangeR;

	// Token: 0x04000636 RID: 1590
	public float rangeG;

	// Token: 0x04000637 RID: 1591
	public float rangeB;

	// Token: 0x04000638 RID: 1592
	public LayerMask hitMask = 1;

	// Token: 0x04000639 RID: 1593
	public LayerMask paintMask = 1;

	// Token: 0x0400063A RID: 1594
	public float brushSize;

	// Token: 0x0400063B RID: 1595
	private Vector3 mousePos;

	// Token: 0x0400063C RID: 1596
	[HideInInspector]
	public Vector3 hitPosGizmo;

	// Token: 0x0400063D RID: 1597
	private Vector3 hitPos;

	// Token: 0x0400063E RID: 1598
	[HideInInspector]
	public Vector3 hitNormal;

	// Token: 0x0400063F RID: 1599
	private int[] indi;
}
