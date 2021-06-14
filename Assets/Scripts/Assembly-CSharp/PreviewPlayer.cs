using System;
using UnityEngine;

// Token: 0x0200006F RID: 111
public class PreviewPlayer : MonoBehaviour
{
	// Token: 0x0600026A RID: 618 RVA: 0x00003D37 File Offset: 0x00001F37
	private void Awake()
	{
		PreviewPlayer.Instance = this;
	}

	// Token: 0x0600026B RID: 619 RVA: 0x00010890 File Offset: 0x0000EA90
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

	// Token: 0x0600026C RID: 620 RVA: 0x00010920 File Offset: 0x0000EB20
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

	// Token: 0x0600026D RID: 621 RVA: 0x00002147 File Offset: 0x00000347
	private void Update()
	{
	}

	// Token: 0x04000275 RID: 629
	public SkinnedMeshRenderer[] armor;

	// Token: 0x04000276 RID: 630
	public static PreviewPlayer Instance;

	// Token: 0x04000277 RID: 631
	public MeshFilter filter;

	// Token: 0x04000278 RID: 632
	public Renderer render;
}
