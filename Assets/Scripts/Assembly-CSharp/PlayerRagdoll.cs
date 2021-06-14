using System;
using UnityEngine;

// Token: 0x0200006B RID: 107
public class PlayerRagdoll : MonoBehaviour
{
	// Token: 0x06000228 RID: 552 RVA: 0x0000FAC8 File Offset: 0x0000DCC8
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

	// Token: 0x06000229 RID: 553 RVA: 0x0000FB58 File Offset: 0x0000DD58
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

	// Token: 0x0600022A RID: 554 RVA: 0x0000FBAC File Offset: 0x0000DDAC
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

	// Token: 0x04000246 RID: 582
	public TestRagdoll ragdoll;

	// Token: 0x04000247 RID: 583
	public SkinnedMeshRenderer[] armor;

	// Token: 0x04000248 RID: 584
	public MeshFilter filter;

	// Token: 0x04000249 RID: 585
	public Renderer render;
}
