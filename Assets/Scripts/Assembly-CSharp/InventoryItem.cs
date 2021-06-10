using System;
using UnityEngine;

// Token: 0x0200007C RID: 124
[CreateAssetMenu]
public class InventoryItem : ScriptableObject
{
	// Token: 0x0600032F RID: 815 RVA: 0x0001052C File Offset: 0x0000E72C
	public void Copy(InventoryItem item, int amount)
	{
		this.name = item.name;
		this.description = item.description;
		this.sprite = item.sprite;
		this.amount = amount;
		this.max = item.max;
		this.stackable = item.stackable;
		this.material = item.material;
		this.mesh = item.mesh;
		this.id = item.id;
		this.attackRange = item.attackRange;
		this.resourceDamage = item.resourceDamage;
		this.tier = item.tier;
		this.type = item.type;
		this.attackSpeed = item.attackSpeed;
		this.craftable = item.craftable;
		this.requirements = item.requirements;
		this.craftAmount = item.craftAmount;
		this.unlockWithFirstRequirementOnly = item.unlockWithFirstRequirementOnly;
		this.buildable = item.buildable;
		this.grid = item.grid;
		this.prefab = item.prefab;
		this.attackDamage = item.attackDamage;
		this.rotationOffset = item.rotationOffset;
		this.positionOffset = item.positionOffset;
		this.scale = item.scale;
		this.buildRotation = item.buildRotation;
		this.processable = item.processable;
		this.processType = item.processType;
		this.processedItem = item.processedItem;
		this.tag = item.tag;
		this.heal = item.heal;
		this.hunger = item.hunger;
		this.stamina = item.stamina;
		this.armor = item.armor;
		this.projectileSpeed = item.projectileSpeed;
		this.swingFx = item.swingFx;
		this.processTime = item.processTime;
		if (item.fuel)
		{
			this.fuel = Instantiate<ItemFuel>(item.fuel);
		}
		this.rarity = item.rarity;
	}

	// Token: 0x06000330 RID: 816 RVA: 0x0001071A File Offset: 0x0000E91A
	public bool IsArmour()
	{
		return this.tag == InventoryItem.ItemTag.Helmet || this.tag == InventoryItem.ItemTag.Torso || this.tag == InventoryItem.ItemTag.Legs || this.tag == InventoryItem.ItemTag.Feet;
	}

	// Token: 0x06000331 RID: 817 RVA: 0x00010744 File Offset: 0x0000E944
	public Color GetOutlineColor()
	{
		switch (this.rarity)
		{
		case InventoryItem.ItemRarity.Common:
			return Color.white;
		case InventoryItem.ItemRarity.Uncommon:
			return Color.green;
		case InventoryItem.ItemRarity.Rare:
			return Color.red;
		default:
			return Color.white;
		}
	}

	// Token: 0x06000332 RID: 818 RVA: 0x00010783 File Offset: 0x0000E983
	public bool Compare(InventoryItem other)
	{
		return !(other == null) && this.id == other.id;
	}

	// Token: 0x06000333 RID: 819 RVA: 0x0001079E File Offset: 0x0000E99E
	public string GetAmount()
	{
		if (!this.stackable || this.amount == 1)
		{
			return "";
		}
		return this.amount.ToString();
	}

	// Token: 0x040002DB RID: 731
	[Header("Basic")]
	public int id;

	// Token: 0x040002DC RID: 732
	public new string name;

	// Token: 0x040002DD RID: 733
	public string description;

	// Token: 0x040002DE RID: 734
	public InventoryItem.ItemType type;

	// Token: 0x040002DF RID: 735
	public int tier;

	// Token: 0x040002E0 RID: 736
	[Header("Visuals")]
	public Sprite sprite;

	// Token: 0x040002E1 RID: 737
	public Material material;

	// Token: 0x040002E2 RID: 738
	public Mesh mesh;

	// Token: 0x040002E3 RID: 739
	public Vector3 rotationOffset;

	// Token: 0x040002E4 RID: 740
	public Vector3 positionOffset;

	// Token: 0x040002E5 RID: 741
	public float scale = 1f;

	// Token: 0x040002E6 RID: 742
	[Header("Inventory details")]
	public bool stackable = true;

	// Token: 0x040002E7 RID: 743
	public int amount;

	// Token: 0x040002E8 RID: 744
	public int max = 69;

	// Token: 0x040002E9 RID: 745
	[Header("Weapon")]
	public int resourceDamage = 1;

	// Token: 0x040002EA RID: 746
	public int attackDamage = 1;

	// Token: 0x040002EB RID: 747
	public float attackSpeed = 1f;

	// Token: 0x040002EC RID: 748
	public Vector3 attackRange = Vector3.one;

	// Token: 0x040002ED RID: 749
	public float sharpness;

	// Token: 0x040002EE RID: 750
	[Header("Crafting")]
	public bool craftable;

	// Token: 0x040002EF RID: 751
	public bool unlockWithFirstRequirementOnly;

	// Token: 0x040002F0 RID: 752
	public InventoryItem.CraftRequirement[] requirements;

	// Token: 0x040002F1 RID: 753
	public int craftAmount;

	// Token: 0x040002F2 RID: 754
	public InventoryItem stationRequirement;

	// Token: 0x040002F3 RID: 755
	[Header("Building")]
	public bool buildable;

	// Token: 0x040002F4 RID: 756
	public bool grid;

	// Token: 0x040002F5 RID: 757
	public GameObject prefab;

	// Token: 0x040002F6 RID: 758
	public Vector3 buildRotation;

	// Token: 0x040002F7 RID: 759
	[Header("Processing")]
	public bool processable;

	// Token: 0x040002F8 RID: 760
	public InventoryItem.ProcessType processType;

	// Token: 0x040002F9 RID: 761
	public InventoryItem processedItem;

	// Token: 0x040002FA RID: 762
	public float processTime;

	// Token: 0x040002FB RID: 763
	[Header("Food")]
	public float heal;

	// Token: 0x040002FC RID: 764
	public float hunger;

	// Token: 0x040002FD RID: 765
	public float stamina;

	// Token: 0x040002FE RID: 766
	[Header("Other")]
	public int armor;

	// Token: 0x040002FF RID: 767
	public float projectileSpeed;

	// Token: 0x04000300 RID: 768
	public bool swingFx;

	// Token: 0x04000301 RID: 769
	[Header("Fuel")]
	public ItemFuel fuel;

	// Token: 0x04000302 RID: 770
	[Header("Meta")]
	public InventoryItem.ItemTag tag;

	// Token: 0x04000303 RID: 771
	public InventoryItem.ItemRarity rarity;

	// Token: 0x02000117 RID: 279
	public enum ItemType
	{
		// Token: 0x0400075D RID: 1885
		Item,
		// Token: 0x0400075E RID: 1886
		Axe,
		// Token: 0x0400075F RID: 1887
		Pickaxe,
		// Token: 0x04000760 RID: 1888
		Sword,
		// Token: 0x04000761 RID: 1889
		Shield,
		// Token: 0x04000762 RID: 1890
		Shovel,
		// Token: 0x04000763 RID: 1891
		Storage,
		// Token: 0x04000764 RID: 1892
		Station,
		// Token: 0x04000765 RID: 1893
		Food,
		// Token: 0x04000766 RID: 1894
		Bow
	}

	// Token: 0x02000118 RID: 280
	public enum ProcessType
	{
		// Token: 0x04000768 RID: 1896
		Smelt,
		// Token: 0x04000769 RID: 1897
		Cook,
		// Token: 0x0400076A RID: 1898
		None
	}

	// Token: 0x02000119 RID: 281
	[Serializable]
	public enum ItemTag
	{
		// Token: 0x0400076C RID: 1900
		None,
		// Token: 0x0400076D RID: 1901
		Fuel,
		// Token: 0x0400076E RID: 1902
		Food,
		// Token: 0x0400076F RID: 1903
		LeftHanded,
		// Token: 0x04000770 RID: 1904
		Helmet,
		// Token: 0x04000771 RID: 1905
		Torso,
		// Token: 0x04000772 RID: 1906
		Legs,
		// Token: 0x04000773 RID: 1907
		Feet,
		// Token: 0x04000774 RID: 1908
		Arrow,
		// Token: 0x04000775 RID: 1909
		Armor
	}

	// Token: 0x0200011A RID: 282
	public enum ItemRarity
	{
		// Token: 0x04000777 RID: 1911
		Common,
		// Token: 0x04000778 RID: 1912
		Uncommon,
		// Token: 0x04000779 RID: 1913
		Rare
	}

	// Token: 0x0200011B RID: 283
	[Serializable]
	public class CraftRequirement
	{
		// Token: 0x0400077A RID: 1914
		public InventoryItem item;

		// Token: 0x0400077B RID: 1915
		public int amount;
	}
}
