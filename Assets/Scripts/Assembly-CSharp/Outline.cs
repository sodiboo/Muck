using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x02000083 RID: 131
[DisallowMultipleComponent]
public class Outline : MonoBehaviour
{
	// Token: 0x17000022 RID: 34
	// (get) Token: 0x0600030E RID: 782 RVA: 0x00010DB4 File Offset: 0x0000EFB4
	// (set) Token: 0x0600030F RID: 783 RVA: 0x00010DBC File Offset: 0x0000EFBC
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

	// Token: 0x17000023 RID: 35
	// (get) Token: 0x06000310 RID: 784 RVA: 0x00010DCC File Offset: 0x0000EFCC
	// (set) Token: 0x06000311 RID: 785 RVA: 0x00010DD4 File Offset: 0x0000EFD4
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

	// Token: 0x17000024 RID: 36
	// (get) Token: 0x06000312 RID: 786 RVA: 0x00010DE4 File Offset: 0x0000EFE4
	// (set) Token: 0x06000313 RID: 787 RVA: 0x00010DEC File Offset: 0x0000EFEC
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

	// Token: 0x06000314 RID: 788 RVA: 0x00010DFC File Offset: 0x0000EFFC
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

	// Token: 0x06000315 RID: 789 RVA: 0x00010E6C File Offset: 0x0000F06C
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

	// Token: 0x06000316 RID: 790 RVA: 0x00010EC0 File Offset: 0x0000F0C0
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

	// Token: 0x06000317 RID: 791 RVA: 0x00010F32 File Offset: 0x0000F132
	private void Update()
	{
		if (this.needsUpdate)
		{
			this.needsUpdate = false;
			this.UpdateMaterialProperties();
		}
	}

	// Token: 0x06000318 RID: 792 RVA: 0x00010F4C File Offset: 0x0000F14C
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

	// Token: 0x06000319 RID: 793 RVA: 0x00010FA2 File Offset: 0x0000F1A2
	private void OnDestroy()
	{
		Destroy(this.outlineMaskMaterial);
		Destroy(this.outlineFillMaterial);
	}

	// Token: 0x0600031A RID: 794 RVA: 0x00010FBC File Offset: 0x0000F1BC
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

	// Token: 0x0600031B RID: 795 RVA: 0x00011030 File Offset: 0x0000F230
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

	// Token: 0x0600031C RID: 796 RVA: 0x000110FC File Offset: 0x0000F2FC
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

	// Token: 0x0600031D RID: 797 RVA: 0x0001124C File Offset: 0x0000F44C
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

	// Token: 0x04000310 RID: 784
	private static HashSet<Mesh> registeredMeshes = new HashSet<Mesh>();

	// Token: 0x04000311 RID: 785
	[SerializeField]
	private Outline.Mode outlineMode;

	// Token: 0x04000312 RID: 786
	[SerializeField]
	private Color outlineColor = Color.white;

	// Token: 0x04000313 RID: 787
	[SerializeField]
	[Range(0f, 10f)]
	private float outlineWidth = 2f;

	// Token: 0x04000314 RID: 788
	[Header("Optional")]
	[SerializeField]
	[Tooltip("Precompute enabled: Per-vertex calculations are performed in the editor and serialized with the object. Precompute disabled: Per-vertex calculations are performed at runtime in Awake(). This may cause a pause for large meshes.")]
	private bool precomputeOutline;

	// Token: 0x04000315 RID: 789
	[SerializeField]
	[HideInInspector]
	private List<Mesh> bakeKeys = new List<Mesh>();

	// Token: 0x04000316 RID: 790
	[SerializeField]
	[HideInInspector]
	private List<Outline.ListVector3> bakeValues = new List<Outline.ListVector3>();

	// Token: 0x04000317 RID: 791
	private Renderer[] renderers;

	// Token: 0x04000318 RID: 792
	private Material outlineMaskMaterial;

	// Token: 0x04000319 RID: 793
	private Material outlineFillMaterial;

	// Token: 0x0400031A RID: 794
	private bool needsUpdate;

	// Token: 0x0200014B RID: 331
	public enum Mode
	{
		// Token: 0x040008B3 RID: 2227
		OutlineAll,
		// Token: 0x040008B4 RID: 2228
		OutlineVisible,
		// Token: 0x040008B5 RID: 2229
		OutlineHidden,
		// Token: 0x040008B6 RID: 2230
		OutlineAndSilhouette,
		// Token: 0x040008B7 RID: 2231
		SilhouetteOnly
	}

	// Token: 0x0200014C RID: 332
	[Serializable]
	private class ListVector3
	{
		// Token: 0x040008B8 RID: 2232
		public List<Vector3> data;
	}
}
