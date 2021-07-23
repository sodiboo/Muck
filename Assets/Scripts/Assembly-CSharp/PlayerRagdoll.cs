using UnityEngine;

public class PlayerRagdoll : MonoBehaviour
{
    public TestRagdoll ragdoll;

    public SkinnedMeshRenderer[] armor;

    public MeshFilter filter;

    public Renderer render;

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

    public void SetRagdoll(int id, Vector3 dir)
    {
        ragdoll.MakeRagdoll(dir);
        if (LocalClient.instance.myId == id)
        {
            if (Hotbar.Instance.currentItem != null)
            {
                WeaponInHand(Hotbar.Instance.currentItem.id);
            }
            for (int i = 0; i < PlayerStatus.Instance.armor.Length; i++)
            {
                if ((bool)PlayerStatus.Instance.armor[i])
                {
                    SetArmor(i, PlayerStatus.Instance.armor[i].id);
                }
            }
            return;
        }
        OnlinePlayer onlinePlayer = GameManager.players[id].onlinePlayer;
        WeaponInHand(onlinePlayer.currentWeaponId);
        for (int j = 0; j < onlinePlayer.armor.Length; j++)
        {
            if (onlinePlayer.armor[j].gameObject.activeInHierarchy)
            {
                armor[j].material = onlinePlayer.armor[j].material;
                armor[j].gameObject.SetActive(value: true);
            }
        }
    }
}
