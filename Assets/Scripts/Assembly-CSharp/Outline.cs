using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[DisallowMultipleComponent]
public class Outline : MonoBehaviour
{
	public Outline.Mode OutlineMode
	{
		get
		{
			return this.outlineMode;
		}
		set
		{
			this.outlineMode = value;
			this.needsUpdate = true;
		}
	}

	public Color OutlineColor
	{
		get
		{
			return this.outlineColor;
		}
		set
		{
			this.outlineColor = value;
			this.needsUpdate = true;
		}
	}

	public float OutlineWidth
	{
		get
		{
			return this.outlineWidth;
		}
		set
		{
			this.outlineWidth = value;
			this.needsUpdate = true;
		}
	}

	private void Awake()
	{
		this.renderers = base.GetComponentsInChildren<Renderer>();
		this.outlineMaskMaterial = Instantiate<Material>(Resources.Load<Material>("Materials/OutlineMask"));
		this.outlineFillMaterial = Instantiate<Material>(Resources.Load<Material>("Materials/OutlineFill"));
		this.outlineMaskMaterial.name = "OutlineMask (Instance)";
		this.outlineFillMaterial.name = "OutlineFill (Instance)";
		this.LoadSmoothNormals();
		this.needsUpdate = true;
	}

	private void OnEnable()
	{
		foreach (Renderer renderer in this.renderers)
		{
			List<Material> list = renderer.sharedMaterials.ToList<Material>();
			list.Add(this.outlineMaskMaterial);
			list.Add(this.outlineFillMaterial);
			renderer.materials = list.ToArray();
		}
	}

	private void OnValidate()
	{
		this.needsUpdate = true;
		if ((!this.precomputeOutline && this.bakeKeys.Count != 0) || this.bakeKeys.Count != this.bakeValues.Count)
		{
			this.bakeKeys.Clear();
			this.bakeValues.Clear();
		}
		if (this.precomputeOutline && this.bakeKeys.Count == 0)
		{
			this.Bake();
		}
	}

	private void Update()
	{
		if (this.needsUpdate)
		{
			this.needsUpdate = false;
			this.UpdateMaterialProperties();
		}
	}

	private void OnDisable()
	{
		foreach (Renderer renderer in this.renderers)
		{
			List<Material> list = renderer.sharedMaterials.ToList<Material>();
			list.Remove(this.outlineMaskMaterial);
			list.Remove(this.outlineFillMaterial);
			renderer.materials = list.ToArray();
		}
	}

	private void OnDestroy()
	{
		Destroy(this.outlineMaskMaterial);
		Destroy(this.outlineFillMaterial);
	}

	private void Bake()
	{
		HashSet<Mesh> hashSet = new HashSet<Mesh>();
		foreach (MeshFilter meshFilter in base.GetComponentsInChildren<MeshFilter>())
		{
			if (hashSet.Add(meshFilter.sharedMesh))
			{
				List<Vector3> data = this.SmoothNormals(meshFilter.sharedMesh);
				this.bakeKeys.Add(meshFilter.sharedMesh);
				this.bakeValues.Add(new Outline.ListVector3
				{
					data = data
				});
			}
		}
	}

	private void LoadSmoothNormals()
	{
		foreach (MeshFilter meshFilter in base.GetComponentsInChildren<MeshFilter>())
		{
			if (Outline.registeredMeshes.Add(meshFilter.sharedMesh))
			{
				int num = this.bakeKeys.IndexOf(meshFilter.sharedMesh);
				List<Vector3> uvs = (num >= 0) ? this.bakeValues[num].data : this.SmoothNormals(meshFilter.sharedMesh);
				meshFilter.sharedMesh.SetUVs(3, uvs);
			}
		}
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in base.GetComponentsInChildren<SkinnedMeshRenderer>())
		{
			if (Outline.registeredMeshes.Add(skinnedMeshRenderer.sharedMesh))
			{
				skinnedMeshRenderer.sharedMesh.uv4 = new Vector2[skinnedMeshRenderer.sharedMesh.vertexCount];
			}
		}
	}

	private List<Vector3> SmoothNormals(Mesh mesh)
	{
		IEnumerable<IGrouping<Vector3, KeyValuePair<Vector3, int>>> enumerable = from pair in mesh.vertices.Select((Vector3 vertex, int index) => new KeyValuePair<Vector3, int>(vertex, index))
		group pair by pair.Key;
		List<Vector3> list = new List<Vector3>(mesh.normals);
		foreach (IGrouping<Vector3, KeyValuePair<Vector3, int>> grouping in enumerable)
		{
			if (grouping.Count<KeyValuePair<Vector3, int>>() != 1)
			{
				Vector3 vector = Vector3.zero;
				foreach (KeyValuePair<Vector3, int> keyValuePair in grouping)
				{
					vector += mesh.normals[keyValuePair.Value];
				}
				vector.Normalize();
				foreach (KeyValuePair<Vector3, int> keyValuePair2 in grouping)
				{
					list[keyValuePair2.Value] = vector;
				}
			}
		}
		return list;
	}

	private void UpdateMaterialProperties()
	{
		this.outlineFillMaterial.SetColor("_OutlineColor", this.outlineColor);
		switch (this.outlineMode)
		{
		case Outline.Mode.OutlineAll:
			this.outlineMaskMaterial.SetFloat("_ZTest", 8f);
			this.outlineFillMaterial.SetFloat("_ZTest", 8f);
			this.outlineFillMaterial.SetFloat("_OutlineWidth", this.outlineWidth);
			return;
		case Outline.Mode.OutlineVisible:
			this.outlineMaskMaterial.SetFloat("_ZTest", 8f);
			this.outlineFillMaterial.SetFloat("_ZTest", 4f);
			this.outlineFillMaterial.SetFloat("_OutlineWidth", this.outlineWidth);
			return;
		case Outline.Mode.OutlineHidden:
			this.outlineMaskMaterial.SetFloat("_ZTest", 8f);
			this.outlineFillMaterial.SetFloat("_ZTest", 5f);
			this.outlineFillMaterial.SetFloat("_OutlineWidth", this.outlineWidth);
			return;
		case Outline.Mode.OutlineAndSilhouette:
			this.outlineMaskMaterial.SetFloat("_ZTest", 4f);
			this.outlineFillMaterial.SetFloat("_ZTest", 8f);
			this.outlineFillMaterial.SetFloat("_OutlineWidth", this.outlineWidth);
			return;
		case Outline.Mode.SilhouetteOnly:
			this.outlineMaskMaterial.SetFloat("_ZTest", 4f);
			this.outlineFillMaterial.SetFloat("_ZTest", 5f);
			this.outlineFillMaterial.SetFloat("_OutlineWidth", 0f);
			return;
		default:
			return;
		}
	}

	private static HashSet<Mesh> registeredMeshes = new HashSet<Mesh>();

	[SerializeField]
	private Outline.Mode outlineMode;

	[SerializeField]
	private Color outlineColor = Color.white;

	[SerializeField]
	[Range(0f, 10f)]
	private float outlineWidth = 2f;

	[Header("Optional")]
	[SerializeField]
	[Tooltip("Precompute enabled: Per-vertex calculations are performed in the editor and serialized with the object. Precompute disabled: Per-vertex calculations are performed at runtime in Awake(). This may cause a pause for large meshes.")]
	private bool precomputeOutline;

	[SerializeField]
	[HideInInspector]
	private List<Mesh> bakeKeys = new List<Mesh>();

	[SerializeField]
	[HideInInspector]
	private List<Outline.ListVector3> bakeValues = new List<Outline.ListVector3>();

	private Renderer[] renderers;

	private Material outlineMaskMaterial;

	private Material outlineFillMaterial;

	private bool needsUpdate;

	public enum Mode
	{
		OutlineAll,
		OutlineVisible,
		OutlineHidden,
		OutlineAndSilhouette,
		SilhouetteOnly
	}

	[Serializable]
	private class ListVector3
	{
		public List<Vector3> data;
	}
}
