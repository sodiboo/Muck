
using UnityEngine;

// Token: 0x0200005A RID: 90
public class PlayerRagdoll : MonoBehaviour
{
	// Token: 0x060001FB RID: 507 RVA: 0x0000B59C File Offset: 0x0000979C
	public void SetArmor(int armorSlot, int itemId)
	{
		MonoBehaviour.print(string.Concat(new object[]
		{
			"armor slot: ",
			armorSlot,
			", item id: ",
			itemId
		}));
		if (itemId == -1)
		{
			this.armor[armorSlot].gameObject.SetActive(false);
			return;
		}
		this.armor[armorSlot].gameObject.SetActive(true);
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
		this.armor[armorSlot].material = inventoryItem.material;
	}

	// Token: 0x060001FC RID: 508 RVA: 0x0000B62C File Offset: 0x0000982C
	public void WeaponInHand(int itemId)
	{
		if (itemId == -1)
		{
			this.filter.mesh = null;
			return;
		}
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemId];
		this.filter.mesh = inventoryItem.mesh;
		this.render.material = inventoryItem.material;
	}

	// Token: 0x060001FD RID: 509 RVA: 0x0000B680 File Offset: 0x00009880
	public void SetRagdoll(int id, Vector3 dir)
	{
		this.ragdoll.MakeRagdoll(dir);
		if (LocalClient.instance.myId == id)
		{
			if (Hotbar.Instance.currentItem != null)
			{
				this.WeaponInHand(Hotbar.Instance.currentItem.id);
			}
			for (int i = 0; i < PlayerStatus.Instance.armor.Length; i++)
			{
				if (PlayerStatus.Instance.armor[i])
				{
					this.SetArmor(i, PlayerStatus.Instance.armor[i].id);
				}
			}
			return;
		}
		OnlinePlayer onlinePlayer = GameManager.players[id].onlinePlayer;
		this.WeaponInHand(onlinePlayer.currentWeaponId);
		for (int j = 0; j < onlinePlayer.armor.Length; j++)
		{
			if (onlinePlayer.armor[j].gameObject.activeInHierarchy)
			{
				this.armor[j].material = onlinePlayer.armor[j].material;
				this.armor[j].gameObject.SetActive(true);
			}
		}
	}

	// Token: 0x040001FA RID: 506
	public TestRagdoll ragdoll;

	// Token: 0x040001FB RID: 507
	public SkinnedMeshRenderer[] armor;

	// Token: 0x040001FC RID: 508
	public MeshFilter filter;

	// Token: 0x040001FD RID: 509
	public Renderer render;
}
