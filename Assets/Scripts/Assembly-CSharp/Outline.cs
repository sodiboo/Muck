using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x02000062 RID: 98
[DisallowMultipleComponent]
public class Outline : MonoBehaviour
{
	// Token: 0x17000018 RID: 24
	// (get) Token: 0x0600024C RID: 588 RVA: 0x0000CD1F File Offset: 0x0000AF1F
	// (set) Token: 0x0600024D RID: 589 RVA: 0x0000CD27 File Offset: 0x0000AF27
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

	// Token: 0x17000019 RID: 25
	// (get) Token: 0x0600024E RID: 590 RVA: 0x0000CD37 File Offset: 0x0000AF37
	// (set) Token: 0x0600024F RID: 591 RVA: 0x0000CD3F File Offset: 0x0000AF3F
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

	// Token: 0x1700001A RID: 26
	// (get) Token: 0x06000250 RID: 592 RVA: 0x0000CD4F File Offset: 0x0000AF4F
	// (set) Token: 0x06000251 RID: 593 RVA: 0x0000CD57 File Offset: 0x0000AF57
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

	// Token: 0x06000252 RID: 594 RVA: 0x0000CD68 File Offset: 0x0000AF68
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

	// Token: 0x06000253 RID: 595 RVA: 0x0000CDD8 File Offset: 0x0000AFD8
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

	// Token: 0x06000254 RID: 596 RVA: 0x0000CE2C File Offset: 0x0000B02C
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

	// Token: 0x06000255 RID: 597 RVA: 0x0000CE9E File Offset: 0x0000B09E
	private void Update()
	{
		if (this.needsUpdate)
		{
			this.needsUpdate = false;
			this.UpdateMaterialProperties();
		}
	}

	// Token: 0x06000256 RID: 598 RVA: 0x0000CEB8 File Offset: 0x0000B0B8
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

	// Token: 0x06000257 RID: 599 RVA: 0x0000CF0E File Offset: 0x0000B10E
	private void OnDestroy()
	{
		Destroy(this.outlineMaskMaterial);
		Destroy(this.outlineFillMaterial);
	}

	// Token: 0x06000258 RID: 600 RVA: 0x0000CF28 File Offset: 0x0000B128
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

	// Token: 0x06000259 RID: 601 RVA: 0x0000CF9C File Offset: 0x0000B19C
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

	// Token: 0x0600025A RID: 602 RVA: 0x0000D068 File Offset: 0x0000B268
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

	// Token: 0x0600025B RID: 603 RVA: 0x0000D1B8 File Offset: 0x0000B3B8
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

	// Token: 0x04000238 RID: 568
	private static HashSet<Mesh> registeredMeshes = new HashSet<Mesh>();

	// Token: 0x04000239 RID: 569
	[SerializeField]
	private Outline.Mode outlineMode;

	// Token: 0x0400023A RID: 570
	[SerializeField]
	private Color outlineColor = Color.white;

	// Token: 0x0400023B RID: 571
	[SerializeField]
	[Range(0f, 10f)]
	private float outlineWidth = 2f;

	// Token: 0x0400023C RID: 572
	[Header("Optional")]
	[SerializeField]
	[Tooltip("Precompute enabled: Per-vertex calculations are performed in the editor and serialized with the object. Precompute disabled: Per-vertex calculations are performed at runtime in Awake(). This may cause a pause for large meshes.")]
	private bool precomputeOutline;

	// Token: 0x0400023D RID: 573
	[SerializeField]
	[HideInInspector]
	private List<Mesh> bakeKeys = new List<Mesh>();

	// Token: 0x0400023E RID: 574
	[SerializeField]
	[HideInInspector]
	private List<Outline.ListVector3> bakeValues = new List<Outline.ListVector3>();

	// Token: 0x0400023F RID: 575
	private Renderer[] renderers;

	// Token: 0x04000240 RID: 576
	private Material outlineMaskMaterial;

	// Token: 0x04000241 RID: 577
	private Material outlineFillMaterial;

	// Token: 0x04000242 RID: 578
	private bool needsUpdate;

	// Token: 0x02000111 RID: 273
	public enum Mode
	{
		// Token: 0x04000749 RID: 1865
		OutlineAll,
		// Token: 0x0400074A RID: 1866
		OutlineVisible,
		// Token: 0x0400074B RID: 1867
		OutlineHidden,
		// Token: 0x0400074C RID: 1868
		OutlineAndSilhouette,
		// Token: 0x0400074D RID: 1869
		SilhouetteOnly
	}

	// Token: 0x02000112 RID: 274
	[Serializable]
	private class ListVector3
	{
		// Token: 0x0400074E RID: 1870
		public List<Vector3> data;
	}
}
