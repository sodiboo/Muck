using UnityEngine;

public class PreviewPlayer : MonoBehaviour
{
    public SkinnedMeshRenderer[] armor;

    public static PreviewPlayer Instance;

    public MeshFilter filter;

    public Renderer render;

    private void Awake()
    {
        Instance = this;
    }

    public void SetArmor(int armorSlot, int itemId)
    {
        MonoBehaviour.print("armor slot: " + armorSlot + ", item id: " + itemId);
        if (itemId == -1)
        {
            armor[armorSlot].gameObject.SetActive(value: false);
            return;
        }
        armor[armorSlot].gameObject.SetActive(value: true);
        InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
        armor[armorSlot].material = inventoryItem.material;
    }

    public void WeaponInHand(int itemId)
    {
        if (itemId == -1)
        {
            filter.mesh = null;
            return;
        }
        InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
        filter.mesh = inventoryItem.mesh;
        render.material = inventoryItem.material;
    }

    private void Update()
    {
    }
}
