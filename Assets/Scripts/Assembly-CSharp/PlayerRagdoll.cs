using System;
using UnityEngine;

public class PlayerRagdoll : MonoBehaviour
{
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

	public TestRagdoll ragdoll;

	public SkinnedMeshRenderer[] armor;

	public MeshFilter filter;

	public Renderer render;
}
