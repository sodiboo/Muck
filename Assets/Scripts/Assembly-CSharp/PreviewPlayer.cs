
using UnityEngine;

// Token: 0x0200005E RID: 94
public class PreviewPlayer : MonoBehaviour
{
	// Token: 0x0600023A RID: 570 RVA: 0x0000C383 File Offset: 0x0000A583
	private void Awake()
	{
		PreviewPlayer.Instance = this;
	}

	// Token: 0x0600023B RID: 571 RVA: 0x0000C38C File Offset: 0x0000A58C
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

	// Token: 0x0600023C RID: 572 RVA: 0x0000C41C File Offset: 0x0000A61C
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

	// Token: 0x0600023D RID: 573 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x04000224 RID: 548
	public SkinnedMeshRenderer[] armor;

	// Token: 0x04000225 RID: 549
	public static PreviewPlayer Instance;

	// Token: 0x04000226 RID: 550
	public MeshFilter filter;

	// Token: 0x04000227 RID: 551
	public Renderer render;
}
