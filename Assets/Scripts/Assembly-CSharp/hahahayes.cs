using UnityEngine;

public class hahahayes : MonoBehaviour
{
    public GameObject interact;

    public Renderer woodmanRend;

    public MeshRenderer rend;

    public MeshFilter filter;

    public Mesh axe;

    public Mesh pickaxe;

    public Mesh sword;

    public Mesh bread;

    public Mesh bow;

    public Mesh chest;

    public Material[] axeMats;

    public Material[] pickaxeMats;

    public Material[] swordMats;

    public Material[] breadMat;

    public Material[] bowMats;

    public Material[] chestMats;

    public MeshFilter hatFilter;

    public MeshRenderer hatRender;

    public GameObject helmet;

    public GameObject pants;

    public GameObject shoes;

    public Mesh archerHat;

    public Mesh bean;

    public Mesh meat;

    public Mesh tree;

    public Material archerHatMat;

    public Material beanMat;

    public Material meatMat;

    public Material treeMat;

    private WoodmanBehaviour.WoodmanType type;

    public void Randomize(ConsistentRandom rand)
    {
        switch (type)
        {
        case WoodmanBehaviour.WoodmanType.Archer:
            filter.mesh = bow;
            rend.material = GetMaterial(bowMats, rand);
            hatFilter.mesh = archerHat;
            hatRender.material = archerHatMat;
            break;
        case WoodmanBehaviour.WoodmanType.Chef:
            filter.mesh = bread;
            rend.material = breadMat[0];
            rend.transform.localScale *= 0.5f;
            hatFilter.mesh = meat;
            hatRender.material = meatMat;
            hatRender.transform.localPosition = new Vector3(0f, 3.2f, 0f);
            hatRender.transform.localScale = Vector3.one * 1.9f;
            hatRender.transform.rotation = Quaternion.Euler(0f, -90f, -90f);
            break;
        case WoodmanBehaviour.WoodmanType.Smith:
            filter.mesh = pickaxe;
            rend.material = GetMaterial(pickaxeMats, rand);
            helmet.SetActive(value: true);
            break;
        case WoodmanBehaviour.WoodmanType.Wildcard:
            filter.mesh = bean;
            rend.material = beanMat;
            pants.SetActive(value: true);
            break;
        case WoodmanBehaviour.WoodmanType.Woodcutter:
            filter.mesh = axe;
            rend.material = GetMaterial(axeMats, rand);
            shoes.SetActive(value: true);
            hatFilter.mesh = tree;
            hatRender.material = treeMat;
            hatRender.transform.localPosition = new Vector3(-0.03f, 1.27f, 0.11f);
            hatRender.transform.localScale = Vector3.one * 0.455f;
            hatRender.transform.rotation = Quaternion.Euler(0f, -132f, 0f);
            break;
        default:
        {
            Mesh mesh = bean;
            filter.mesh = mesh;
            rend.material = beanMat;
            break;
        }
        }
    }

    public void SetType(WoodmanBehaviour.WoodmanType type)
    {
        this.type = type;
    }

    public void SkinColor(ConsistentRandom rand)
    {
        Material material = woodmanRend.materials[0];
        float num = (float)rand.NextDouble();
        material.color = (material.color + new Color(num, num, num)) / 2f;
        woodmanRend.materials[0] = material;
    }

    private Material GetMaterial(Material[] mats, ConsistentRandom rand)
    {
        return mats[rand.Next(0, mats.Length)];
    }
}
