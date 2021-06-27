using System;
using UnityEngine;

// Token: 0x0200007E RID: 126
public class PreviewPlayer : MonoBehaviour
{
	// Token: 0x060002F7 RID: 759 RVA: 0x00010173 File Offset: 0x0000E373
	private void Awake()
	{
		PreviewPlayer.Instance = this;
	}

	// Token: 0x060002F8 RID: 760 RVA: 0x0001017C File Offset: 0x0000E37C
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

	// Token: 0x060002F9 RID: 761 RVA: 0x0001020C File Offset: 0x0000E40C
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

	// Token: 0x060002FA RID: 762 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x040002F9 RID: 761
	public SkinnedMeshRenderer[] armor;

	// Token: 0x040002FA RID: 762
	public static PreviewPlayer Instance;

	// Token: 0x040002FB RID: 763
	public MeshFilter filter;

	// Token: 0x040002FC RID: 764
	public Renderer render;
}
