using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x02000073 RID: 115
[DisallowMultipleComponent]
public class Outline : MonoBehaviour
{
	// Token: 0x1700001C RID: 28
	// (get) Token: 0x0600027C RID: 636 RVA: 0x00003D86 File Offset: 0x00001F86
	// (set) Token: 0x0600027D RID: 637 RVA: 0x00003D8E File Offset: 0x00001F8E
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

	// Token: 0x1700001D RID: 29
	// (get) Token: 0x0600027E RID: 638 RVA: 0x00003D9E File Offset: 0x00001F9E
	// (set) Token: 0x0600027F RID: 639 RVA: 0x00003DA6 File Offset: 0x00001FA6
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

	// Token: 0x1700001E RID: 30
	// (get) Token: 0x06000280 RID: 640 RVA: 0x00003DB6 File Offset: 0x00001FB6
	// (set) Token: 0x06000281 RID: 641 RVA: 0x00003DBE File Offset: 0x00001FBE
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

	// Token: 0x06000282 RID: 642 RVA: 0x00011224 File Offset: 0x0000F424
	private void Awake()
	{
		this.renderers = base.GetComponentsInChildren<Renderer>();
		this.outlineMaskMaterial =Instantiate<Material>(Resources.Load<Material>("Materials/OutlineMask"));
		this.outlineFillMaterial =Instantiate<Material>(Resources.Load<Material>("Materials/OutlineFill"));
		this.outlineMaskMaterial.name = "OutlineMask (Instance)";
		this.outlineFillMaterial.name = "OutlineFill (Instance)";
		this.LoadSmoothNormals();
		this.needsUpdate = true;
	}

	// Token: 0x06000283 RID: 643 RVA: 0x00011294 File Offset: 0x0000F494
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

	// Token: 0x06000284 RID: 644 RVA: 0x000112E8 File Offset: 0x0000F4E8
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

	// Token: 0x06000285 RID: 645 RVA: 0x00003DCE File Offset: 0x00001FCE
	private void Update()
	{
		if (this.needsUpdate)
		{
			this.needsUpdate = false;
			this.UpdateMaterialProperties();
		}
	}

	// Token: 0x06000286 RID: 646 RVA: 0x0001135C File Offset: 0x0000F55C
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

	// Token: 0x06000287 RID: 647 RVA: 0x00003DE5 File Offset: 0x00001FE5
	private void OnDestroy()
	{
	Destroy(this.outlineMaskMaterial);
	Destroy(this.outlineFillMaterial);
	}

	// Token: 0x06000288 RID: 648 RVA: 0x000113B4 File Offset: 0x0000F5B4
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

	// Token: 0x06000289 RID: 649 RVA: 0x00011428 File Offset: 0x0000F628
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

	// Token: 0x0600028A RID: 650 RVA: 0x000114F4 File Offset: 0x0000F6F4
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

	// Token: 0x0600028B RID: 651 RVA: 0x00011644 File Offset: 0x0000F844
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

	// Token: 0x04000289 RID: 649
	private static HashSet<Mesh> registeredMeshes = new HashSet<Mesh>();

	// Token: 0x0400028A RID: 650
	[SerializeField]
	private Outline.Mode outlineMode;

	// Token: 0x0400028B RID: 651
	[SerializeField]
	private Color outlineColor = Color.white;

	// Token: 0x0400028C RID: 652
	[SerializeField]
	[Range(0f, 10f)]
	private float outlineWidth = 2f;

	// Token: 0x0400028D RID: 653
	[Header("Optional")]
	[SerializeField]
	[Tooltip("Precompute enabled: Per-vertex calculations are performed in the editor and serialized with the object. Precompute disabled: Per-vertex calculations are performed at runtime in Awake(). This may cause a pause for large meshes.")]
	private bool precomputeOutline;

	// Token: 0x0400028E RID: 654
	[SerializeField]
	[HideInInspector]
	private List<Mesh> bakeKeys = new List<Mesh>();

	// Token: 0x0400028F RID: 655
	[SerializeField]
	[HideInInspector]
	private List<Outline.ListVector3> bakeValues = new List<Outline.ListVector3>();

	// Token: 0x04000290 RID: 656
	private Renderer[] renderers;

	// Token: 0x04000291 RID: 657
	private Material outlineMaskMaterial;

	// Token: 0x04000292 RID: 658
	private Material outlineFillMaterial;

	// Token: 0x04000293 RID: 659
	private bool needsUpdate;

	// Token: 0x02000074 RID: 116
	public enum Mode
	{
		// Token: 0x04000295 RID: 661
		OutlineAll,
		// Token: 0x04000296 RID: 662
		OutlineVisible,
		// Token: 0x04000297 RID: 663
		OutlineHidden,
		// Token: 0x04000298 RID: 664
		OutlineAndSilhouette,
		// Token: 0x04000299 RID: 665
		SilhouetteOnly
	}

	// Token: 0x02000075 RID: 117
	[Serializable]
	private class ListVector3
	{
		// Token: 0x0400029A RID: 666
		public List<Vector3> data;
	}
}
