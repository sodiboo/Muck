using UnityEngine;
using System.Collections.Generic;

public class DrawGrass : MonoBehaviour
{
	public Mesh mesh;
	public MeshFilter filter;
	public Color AdjustedColor;
	public int grassLimit;
	public int toolbarInt;
	[SerializeField]
	private List<Vector3> positions;
	[SerializeField]
	private List<Color> colors;
	[SerializeField]
	private List<int> indicies;
	[SerializeField]
	private List<Vector3> normals;
	[SerializeField]
	private List<Vector2> length;
	public bool painting;
	public bool removing;
	public bool editing;
	public int i;
	public float sizeWidth;
	public float sizeLength;
	public float density;
	public float normalLimit;
	public float rangeR;
	public float rangeG;
	public float rangeB;
	public LayerMask hitMask;
	public LayerMask paintMask;
	public float brushSize;
	public Vector3 hitPosGizmo;
	public Vector3 hitNormal;
	public Transform grassObject;
	public float chunkLength;
	public float chunkDensity;
	public int nChunks;
	public int iterations;
	public Transform target;
	public int gridSize;
}
