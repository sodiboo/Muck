using System;
using UnityEngine;

// Token: 0x0200007A RID: 122
public class PlayerRagdoll : MonoBehaviour
{
	// Token: 0x060002B3 RID: 691 RVA: 0x0000F01C File Offset: 0x0000D21C
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

	// Token: 0x060002B4 RID: 692 RVA: 0x0000F0AC File Offset: 0x0000D2AC
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

	// Token: 0x060002B5 RID: 693 RVA: 0x0000F100 File Offset: 0x0000D300
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

	// Token: 0x040002C5 RID: 709
	public TestRagdoll ragdoll;

	// Token: 0x040002C6 RID: 710
	public SkinnedMeshRenderer[] armor;

	// Token: 0x040002C7 RID: 711
	public MeshFilter filter;

	// Token: 0x040002C8 RID: 712
	public Renderer render;
}
