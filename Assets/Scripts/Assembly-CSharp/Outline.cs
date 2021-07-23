using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[DisallowMultipleComponent]
public class Outline : MonoBehaviour
{
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

    private static HashSet<Mesh> registeredMeshes = new HashSet<Mesh>();

    [SerializeField]
    private Mode outlineMode;

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
    private List<ListVector3> bakeValues = new List<ListVector3>();

    private Renderer[] renderers;

    private Material outlineMaskMaterial;

    private Material outlineFillMaterial;

    private bool needsUpdate;

    public Mode OutlineMode
    {
        get
        {
            return outlineMode;
        }
        set
        {
            outlineMode = value;
            needsUpdate = true;
        }
    }

    public Color OutlineColor
    {
        get
        {
            return outlineColor;
        }
        set
        {
            outlineColor = value;
            needsUpdate = true;
        }
    }

    public float OutlineWidth
    {
        get
        {
            return outlineWidth;
        }
        set
        {
            outlineWidth = value;
            needsUpdate = true;
        }
    }

    private void Awake()
    {
        renderers = GetComponentsInChildren<Renderer>();
        outlineMaskMaterial = UnityEngine.Object.Instantiate(Resources.Load<Material>("Materials/OutlineMask"));
        outlineFillMaterial = UnityEngine.Object.Instantiate(Resources.Load<Material>("Materials/OutlineFill"));
        outlineMaskMaterial.name = "OutlineMask (Instance)";
        outlineFillMaterial.name = "OutlineFill (Instance)";
        LoadSmoothNormals();
        needsUpdate = true;
    }

    private void OnEnable()
    {
        Renderer[] array = renderers;
        foreach (Renderer obj in array)
        {
            List<Material> list = obj.sharedMaterials.ToList();
            list.Add(outlineMaskMaterial);
            list.Add(outlineFillMaterial);
            obj.materials = list.ToArray();
        }
    }

    private void OnValidate()
    {
        needsUpdate = true;
        if ((!precomputeOutline && bakeKeys.Count != 0) || bakeKeys.Count != bakeValues.Count)
        {
            bakeKeys.Clear();
            bakeValues.Clear();
        }
        if (precomputeOutline && bakeKeys.Count == 0)
        {
            Bake();
        }
    }

    private void Update()
    {
        if (needsUpdate)
        {
            needsUpdate = false;
            UpdateMaterialProperties();
        }
    }

    private void OnDisable()
    {
        Renderer[] array = renderers;
        foreach (Renderer obj in array)
        {
            List<Material> list = obj.sharedMaterials.ToList();
            list.Remove(outlineMaskMaterial);
            list.Remove(outlineFillMaterial);
            obj.materials = list.ToArray();
        }
    }

    private void OnDestroy()
    {
        UnityEngine.Object.Destroy(outlineMaskMaterial);
        UnityEngine.Object.Destroy(outlineFillMaterial);
    }

    private void Bake()
    {
        HashSet<Mesh> hashSet = new HashSet<Mesh>();
        MeshFilter[] componentsInChildren = GetComponentsInChildren<MeshFilter>();
        foreach (MeshFilter meshFilter in componentsInChildren)
        {
            if (hashSet.Add(meshFilter.sharedMesh))
            {
                List<Vector3> data = SmoothNormals(meshFilter.sharedMesh);
                bakeKeys.Add(meshFilter.sharedMesh);
                bakeValues.Add(new ListVector3
                {
                    data = data
                });
            }
        }
    }

    private void LoadSmoothNormals()
    {
        MeshFilter[] componentsInChildren = GetComponentsInChildren<MeshFilter>();
        foreach (MeshFilter meshFilter in componentsInChildren)
        {
            if (registeredMeshes.Add(meshFilter.sharedMesh))
            {
                int num = bakeKeys.IndexOf(meshFilter.sharedMesh);
                List<Vector3> uvs = ((num >= 0) ? bakeValues[num].data : SmoothNormals(meshFilter.sharedMesh));
                meshFilter.sharedMesh.SetUVs(3, uvs);
            }
        }
        SkinnedMeshRenderer[] componentsInChildren2 = GetComponentsInChildren<SkinnedMeshRenderer>();
        foreach (SkinnedMeshRenderer skinnedMeshRenderer in componentsInChildren2)
        {
            if (registeredMeshes.Add(skinnedMeshRenderer.sharedMesh))
            {
                skinnedMeshRenderer.sharedMesh.uv4 = new Vector2[skinnedMeshRenderer.sharedMesh.vertexCount];
            }
        }
    }

    private List<Vector3> SmoothNormals(Mesh mesh)
    {
        IEnumerable<IGrouping<Vector3, KeyValuePair<Vector3, int>>> enumerable = mesh.vertices.Select((Vector3 vertex, int index) => new KeyValuePair<Vector3, int>(vertex, index)).GroupBy((KeyValuePair<Vector3, int> pair) => pair.Key);
        List<Vector3> list = new List<Vector3>(mesh.normals);
        foreach (IGrouping<Vector3, KeyValuePair<Vector3, int>> item in enumerable)
        {
            if (item.Count() == 1)
            {
                continue;
            }
            Vector3 zero = Vector3.zero;
            foreach (KeyValuePair<Vector3, int> item2 in item)
            {
                zero += mesh.normals[item2.Value];
            }
            zero.Normalize();
            foreach (KeyValuePair<Vector3, int> item3 in item)
            {
                list[item3.Value] = zero;
            }
        }
        return list;
    }

    private void UpdateMaterialProperties()
    {
        outlineFillMaterial.SetColor("_OutlineColor", outlineColor);
        switch (outlineMode)
        {
        case Mode.OutlineAll:
            outlineMaskMaterial.SetFloat("_ZTest", 8f);
            outlineFillMaterial.SetFloat("_ZTest", 8f);
            outlineFillMaterial.SetFloat("_OutlineWidth", outlineWidth);
            break;
        case Mode.OutlineVisible:
            outlineMaskMaterial.SetFloat("_ZTest", 8f);
            outlineFillMaterial.SetFloat("_ZTest", 4f);
            outlineFillMaterial.SetFloat("_OutlineWidth", outlineWidth);
            break;
        case Mode.OutlineHidden:
            outlineMaskMaterial.SetFloat("_ZTest", 8f);
            outlineFillMaterial.SetFloat("_ZTest", 5f);
            outlineFillMaterial.SetFloat("_OutlineWidth", outlineWidth);
            break;
        case Mode.OutlineAndSilhouette:
            outlineMaskMaterial.SetFloat("_ZTest", 4f);
            outlineFillMaterial.SetFloat("_ZTest", 8f);
            outlineFillMaterial.SetFloat("_OutlineWidth", outlineWidth);
            break;
        case Mode.SilhouetteOnly:
            outlineMaskMaterial.SetFloat("_ZTest", 4f);
            outlineFillMaterial.SetFloat("_ZTest", 5f);
            outlineFillMaterial.SetFloat("_OutlineWidth", 0f);
            break;
        }
    }
}
