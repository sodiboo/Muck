using System;
using UnityEngine;

// Token: 0x02000046 RID: 70
public class Guardian : MonoBehaviour
{
	// Token: 0x0600019D RID: 413 RVA: 0x00009D6C File Offset: 0x00007F6C
	private void Start()
	{
		this.rend.material = this.guardianMaterial[(int)this.type];
		Material material = this.fxMaterial[(int)this.type];
		ParticleSystem[] array = this.particles;
		for (int i = 0; i < array.Length; i++)
		{
			ParticleSystemRenderer component = array[i].GetComponent<ParticleSystemRenderer>();
			component.material = material;
			component.trailMaterial = material;
		}
		LineRenderer[] array2 = this.lines;
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i].material = material;
		}
		TrailRenderer[] array3 = this.trails;
		for (int i = 0; i < array3.Length; i++)
		{
			array3[i].material = material;
		}
		if (this.type != Guardian.GuardianType.Basic)
		{
			Hitable component2 = base.GetComponent<Hitable>();
			LootDrop lootDrop = Instantiate<LootDrop>(component2.dropTable);
			LootDrop.LootItems[] array4 = new LootDrop.LootItems[lootDrop.loot.Length + 1];
			for (int j = 0; j < lootDrop.loot.Length; j++)
			{
				array4[j] = lootDrop.loot[j];
			}
			LootDrop.LootItems lootItems = new LootDrop.LootItems();
			lootItems.item = this.gems[this.type - Guardian.GuardianType.Red];
			lootItems.amountMin = 1;
			lootItems.amountMax = 1;
			lootItems.dropChance = 1f;
			array4[lootDrop.loot.Length] = lootItems;
			lootDrop.loot = array4;
			component2.dropTable = lootDrop;
			this.hitable.entityName = this.type + " " + this.hitable.entityName;
		}
	}

	// Token: 0x0600019E RID: 414 RVA: 0x00009EE8 File Offset: 0x000080E8
	private void OnDestroy()
	{
		for (int i = 0; i < this.destroyOnDeath.Length; i++)
		{
			Destroy(this.destroyOnDeath[i]);
		}
	}

	// Token: 0x0600019F RID: 415 RVA: 0x00009F18 File Offset: 0x00008118
	public static Color TypeToColor(Guardian.GuardianType t)
	{
		switch (t)
		{
		case Guardian.GuardianType.Basic:
			return Color.white;
		case Guardian.GuardianType.Red:
			return Color.red;
		case Guardian.GuardianType.Yellow:
			return Color.yellow;
		case Guardian.GuardianType.Green:
			return Color.green;
		case Guardian.GuardianType.Blue:
			return Color.blue;
		case Guardian.GuardianType.Pink:
			return Color.magenta;
		default:
			return Color.white;
		}
	}

	// Token: 0x04000192 RID: 402
	public Guardian.GuardianType type;

	// Token: 0x04000193 RID: 403
	public Material[] guardianMaterial;

	// Token: 0x04000194 RID: 404
	public Material[] fxMaterial;

	// Token: 0x04000195 RID: 405
	public InventoryItem[] gems;

	// Token: 0x04000196 RID: 406
	public SkinnedMeshRenderer rend;

	// Token: 0x04000197 RID: 407
	public ParticleSystem[] particles;

	// Token: 0x04000198 RID: 408
	public LineRenderer[] lines;

	// Token: 0x04000199 RID: 409
	public TrailRenderer[] trails;

	// Token: 0x0400019A RID: 410
	public Hitable hitable;

	// Token: 0x0400019B RID: 411
	public GameObject[] destroyOnDeath;

	// Token: 0x02000144 RID: 324
	public enum GuardianType
	{
		// Token: 0x04000893 RID: 2195
		Basic,
		// Token: 0x04000894 RID: 2196
		Red,
		// Token: 0x04000895 RID: 2197
		Yellow,
		// Token: 0x04000896 RID: 2198
		Green,
		// Token: 0x04000897 RID: 2199
		Blue,
		// Token: 0x04000898 RID: 2200
		Pink
	}
}
