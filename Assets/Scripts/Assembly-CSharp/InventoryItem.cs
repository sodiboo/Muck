using System;
using UnityEngine;

// Token: 0x02000095 RID: 149
[CreateAssetMenu]
public class InventoryItem : ScriptableObject
{
	// Token: 0x06000373 RID: 883 RVA: 0x000140EC File Offset: 0x000122EC
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
		this.armorComponent = item.armorComponent;
		this.bowComponent = item.bowComponent;
		this.swingFx = item.swingFx;
		this.processTime = item.processTime;
		if (item.fuel)
		{
			this.fuel =Instantiate<ItemFuel>(item.fuel);
		}
		this.rarity = item.rarity;
		this.attackTypes = item.attackTypes;
	}

	// Token: 0x06000374 RID: 884 RVA: 0x000047E1 File Offset: 0x000029E1
	public bool IsArmour()
	{
		return this.tag == InventoryItem.ItemTag.Helmet || this.tag == InventoryItem.ItemTag.Torso || this.tag == InventoryItem.ItemTag.Legs || this.tag == InventoryItem.ItemTag.Feet;
	}

	// Token: 0x06000375 RID: 885 RVA: 0x000142F4 File Offset: 0x000124F4
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

	// Token: 0x06000376 RID: 886 RVA: 0x00004809 File Offset: 0x00002A09
	public bool Compare(InventoryItem other)
	{
		return !(other == null) && this.id == other.id;
	}

	// Token: 0x06000377 RID: 887 RVA: 0x00004824 File Offset: 0x00002A24
	public string GetAmount()
	{
		if (!this.stackable || this.amount == 1)
		{
			return "";
		}
		return this.amount.ToString();
	}

	// Token: 0x04000343 RID: 835
	[Header("Basic")]
	public int id;

	// Token: 0x04000344 RID: 836
	public new string name;

	// Token: 0x04000345 RID: 837
	public string description;

	// Token: 0x04000346 RID: 838
	public InventoryItem.ItemType type;

	// Token: 0x04000347 RID: 839
	public int tier;

	// Token: 0x04000348 RID: 840
	[Header("Visuals")]
	public Sprite sprite;

	// Token: 0x04000349 RID: 841
	public Material material;

	// Token: 0x0400034A RID: 842
	public Mesh mesh;

	// Token: 0x0400034B RID: 843
	public Vector3 rotationOffset;

	// Token: 0x0400034C RID: 844
	public Vector3 positionOffset;

	// Token: 0x0400034D RID: 845
	public float scale = 1f;

	// Token: 0x0400034E RID: 846
	[Header("Inventory details")]
	public bool stackable = true;

	// Token: 0x0400034F RID: 847
	public int amount;

	// Token: 0x04000350 RID: 848
	public int max = 69;

	// Token: 0x04000351 RID: 849
	[Header("Weapon")]
	public int resourceDamage = 1;

	// Token: 0x04000352 RID: 850
	public int attackDamage = 1;

	// Token: 0x04000353 RID: 851
	public float attackSpeed = 1f;

	// Token: 0x04000354 RID: 852
	public Vector3 attackRange = Vector3.one;

	// Token: 0x04000355 RID: 853
	public float sharpness;

	// Token: 0x04000356 RID: 854
	[Header("Crafting")]
	public bool craftable;

	// Token: 0x04000357 RID: 855
	public bool unlockWithFirstRequirementOnly;

	// Token: 0x04000358 RID: 856
	public InventoryItem.CraftRequirement[] requirements;

	// Token: 0x04000359 RID: 857
	public int craftAmount;

	// Token: 0x0400035A RID: 858
	public InventoryItem stationRequirement;

	// Token: 0x0400035B RID: 859
	[Header("Building")]
	public bool buildable;

	// Token: 0x0400035C RID: 860
	public bool grid;

	// Token: 0x0400035D RID: 861
	public GameObject prefab;

	// Token: 0x0400035E RID: 862
	public Vector3 buildRotation;

	// Token: 0x0400035F RID: 863
	[Header("Processing")]
	public bool processable;

	// Token: 0x04000360 RID: 864
	public InventoryItem.ProcessType processType;

	// Token: 0x04000361 RID: 865
	public InventoryItem processedItem;

	// Token: 0x04000362 RID: 866
	public float processTime;

	// Token: 0x04000363 RID: 867
	[Header("Food")]
	public float heal;

	// Token: 0x04000364 RID: 868
	public float hunger;

	// Token: 0x04000365 RID: 869
	public float stamina;

	// Token: 0x04000366 RID: 870
	[Header("Other")]
	public int armor;

	// Token: 0x04000367 RID: 871
	public bool swingFx;

	// Token: 0x04000368 RID: 872
	public BowComponent bowComponent;

	// Token: 0x04000369 RID: 873
	public ArmorComponent armorComponent;

	// Token: 0x0400036A RID: 874
	[Header("Fuel")]
	public ItemFuel fuel;

	// Token: 0x0400036B RID: 875
	[Header("Meta")]
	public InventoryItem.ItemTag tag;

	// Token: 0x0400036C RID: 876
	public InventoryItem.ItemRarity rarity;

	// Token: 0x0400036D RID: 877
	public MobType.Weakness[] attackTypes;

	// Token: 0x02000096 RID: 150
	public enum ItemType
	{
		// Token: 0x0400036F RID: 879
		Item,
		// Token: 0x04000370 RID: 880
		Axe,
		// Token: 0x04000371 RID: 881
		Pickaxe,
		// Token: 0x04000372 RID: 882
		Sword,
		// Token: 0x04000373 RID: 883
		Shield,
		// Token: 0x04000374 RID: 884
		Shovel,
		// Token: 0x04000375 RID: 885
		Storage,
		// Token: 0x04000376 RID: 886
		Station,
		// Token: 0x04000377 RID: 887
		Food,
		// Token: 0x04000378 RID: 888
		Bow
	}

	// Token: 0x02000097 RID: 151
	public enum ProcessType
	{
		// Token: 0x0400037A RID: 890
		Smelt,
		// Token: 0x0400037B RID: 891
		Cook,
		// Token: 0x0400037C RID: 892
		None
	}

	// Token: 0x02000098 RID: 152
	[Serializable]
	public enum ItemTag
	{
		// Token: 0x0400037E RID: 894
		None,
		// Token: 0x0400037F RID: 895
		Fuel,
		// Token: 0x04000380 RID: 896
		Food,
		// Token: 0x04000381 RID: 897
		LeftHanded,
		// Token: 0x04000382 RID: 898
		Helmet,
		// Token: 0x04000383 RID: 899
		Torso,
		// Token: 0x04000384 RID: 900
		Legs,
		// Token: 0x04000385 RID: 901
		Feet,
		// Token: 0x04000386 RID: 902
		Arrow,
		// Token: 0x04000387 RID: 903
		Armor
	}

	// Token: 0x02000099 RID: 153
	public enum ItemRarity
	{
		// Token: 0x04000389 RID: 905
		Common,
		// Token: 0x0400038A RID: 906
		Uncommon,
		// Token: 0x0400038B RID: 907
		Rare
	}

	// Token: 0x0200009A RID: 154
	[Serializable]
	public class CraftRequirement
	{
		// Token: 0x0400038C RID: 908
		public InventoryItem item;

		// Token: 0x0400038D RID: 909
		public int amount;
	}
}
