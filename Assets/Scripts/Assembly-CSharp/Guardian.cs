using UnityEngine;

public class Guardian : MonoBehaviour
{
    public enum GuardianType
    {
        Basic,
        Red,
        Yellow,
        Green,
        Blue,
        Pink
    }

    public GuardianType type;

    public Material[] guardianMaterial;

    public Material[] fxMaterial;

    public InventoryItem[] gems;

    public SkinnedMeshRenderer rend;

    public ParticleSystem[] particles;

    public LineRenderer[] lines;

    public TrailRenderer[] trails;

    public Hitable hitable;

    public GameObject[] destroyOnDeath;

    private void Start()
    {
        rend.material = guardianMaterial[(int)type];
        Material material = fxMaterial[(int)type];
        ParticleSystem[] array = particles;
        for (int i = 0; i < array.Length; i++)
        {
            ParticleSystemRenderer component = array[i].GetComponent<ParticleSystemRenderer>();
            component.material = material;
            component.trailMaterial = material;
        }
        LineRenderer[] array2 = lines;
        for (int i = 0; i < array2.Length; i++)
        {
            array2[i].material = material;
        }
        TrailRenderer[] array3 = trails;
        for (int i = 0; i < array3.Length; i++)
        {
            array3[i].material = material;
        }
        if (type != 0)
        {
            Hitable component2 = GetComponent<Hitable>();
            LootDrop lootDrop = Object.Instantiate(component2.dropTable);
            LootDrop.LootItems[] array4 = new LootDrop.LootItems[lootDrop.loot.Length + 1];
            for (int j = 0; j < lootDrop.loot.Length; j++)
            {
                array4[j] = lootDrop.loot[j];
            }
            LootDrop.LootItems lootItems = new LootDrop.LootItems();
            lootItems.item = gems[(int)(type - 1)];
            lootItems.amountMin = 1;
            lootItems.amountMax = 1;
            lootItems.dropChance = 1f;
            array4[lootDrop.loot.Length] = lootItems;
            lootDrop.loot = array4;
            component2.dropTable = lootDrop;
            hitable.entityName = string.Concat(type, " ", hitable.entityName);
        }
    }

    private void OnDestroy()
    {
        for (int i = 0; i < destroyOnDeath.Length; i++)
        {
            Object.Destroy(destroyOnDeath[i]);
        }
    }

    public static Color TypeToColor(GuardianType t)
    {
        switch (t)
        {
        case GuardianType.Basic:
            return Color.white;
        case GuardianType.Red:
            return Color.red;
        case GuardianType.Yellow:
            return Color.yellow;
        case GuardianType.Green:
            return Color.green;
        case GuardianType.Blue:
            return Color.blue;
        case GuardianType.Pink:
            return Color.magenta;
        default:
            return Color.white;
        }
    }
}
