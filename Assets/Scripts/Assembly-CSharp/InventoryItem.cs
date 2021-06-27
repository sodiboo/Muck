using System;
using UnityEngine;

// Token: 0x020000A2 RID: 162
[CreateAssetMenu]
public class InventoryItem : ScriptableObject
{
	// Token: 0x06000412 RID: 1042 RVA: 0x00014DC8 File Offset: 0x00012FC8
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
			this.fuel = Instantiate<ItemFuel>(item.fuel);
		}
		this.rarity = item.rarity;
		this.attackTypes = item.attackTypes;
		this.important = item.important;
	}

	// Token: 0x06000413 RID: 1043 RVA: 0x00014FDA File Offset: 0x000131DA
	public bool IsArmour()
	{
		return this.tag == InventoryItem.ItemTag.Helmet || this.tag == InventoryItem.ItemTag.Torso || this.tag == InventoryItem.ItemTag.Legs || this.tag == InventoryItem.ItemTag.Feet;
	}

	// Token: 0x06000414 RID: 1044 RVA: 0x00015004 File Offset: 0x00013204
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

	// Token: 0x06000415 RID: 1045 RVA: 0x00015043 File Offset: 0x00013243
	public bool Compare(InventoryItem other)
	{
		return !(other == null) && this.id == other.id;
	}

	// Token: 0x06000416 RID: 1046 RVA: 0x0001505E File Offset: 0x0001325E
	public string GetAmount()
	{
		if (!this.stackable || this.amount == 1)
		{
			return "";
		}
		return this.amount.ToString();
	}

	// Token: 0x040003D3 RID: 979
	[Header("Basic")]
	public bool important;

	// Token: 0x040003D4 RID: 980
	public int id;

	// Token: 0x040003D5 RID: 981
	public new string name;

	// Token: 0x040003D6 RID: 982
	public string description;

	// Token: 0x040003D7 RID: 983
	public InventoryItem.ItemType type;

	// Token: 0x040003D8 RID: 984
	public int tier;

	// Token: 0x040003D9 RID: 985
	[Header("Visuals")]
	public Sprite sprite;

	// Token: 0x040003DA RID: 986
	public Material material;

	// Token: 0x040003DB RID: 987
	public Mesh mesh;

	// Token: 0x040003DC RID: 988
	public Vector3 rotationOffset;

	// Token: 0x040003DD RID: 989
	public Vector3 positionOffset;

	// Token: 0x040003DE RID: 990
	public float scale = 1f;

	// Token: 0x040003DF RID: 991
	[Header("Inventory details")]
	public bool stackable = true;

	// Token: 0x040003E0 RID: 992
	public int amount;

	// Token: 0x040003E1 RID: 993
	public int max = 69;

	// Token: 0x040003E2 RID: 994
	[Header("Weapon")]
	public int resourceDamage = 1;

	// Token: 0x040003E3 RID: 995
	public int attackDamage = 1;

	// Token: 0x040003E4 RID: 996
	public float attackSpeed = 1f;

	// Token: 0x040003E5 RID: 997
	public Vector3 attackRange = Vector3.one;

	// Token: 0x040003E6 RID: 998
	public float sharpness;

	// Token: 0x040003E7 RID: 999
	[Header("Crafting")]
	public bool craftable;

	// Token: 0x040003E8 RID: 1000
	public bool unlockWithFirstRequirementOnly;

	// Token: 0x040003E9 RID: 1001
	public InventoryItem.CraftRequirement[] requirements;

	// Token: 0x040003EA RID: 1002
	public int craftAmount;

	// Token: 0x040003EB RID: 1003
	public InventoryItem stationRequirement;

	// Token: 0x040003EC RID: 1004
	[Header("Building")]
	public bool buildable;

	// Token: 0x040003ED RID: 1005
	public bool grid;

	// Token: 0x040003EE RID: 1006
	public GameObject prefab;

	// Token: 0x040003EF RID: 1007
	public Vector3 buildRotation;

	// Token: 0x040003F0 RID: 1008
	[Header("Processing")]
	public bool processable;

	// Token: 0x040003F1 RID: 1009
	public InventoryItem.ProcessType processType;

	// Token: 0x040003F2 RID: 1010
	public InventoryItem processedItem;

	// Token: 0x040003F3 RID: 1011
	public float processTime;

	// Token: 0x040003F4 RID: 1012
	[Header("Food")]
	public float heal;

	// Token: 0x040003F5 RID: 1013
	public float hunger;

	// Token: 0x040003F6 RID: 1014
	public float stamina;

	// Token: 0x040003F7 RID: 1015
	[Header("Other")]
	public int armor;

	// Token: 0x040003F8 RID: 1016
	public bool swingFx;

	// Token: 0x040003F9 RID: 1017
	public BowComponent bowComponent;

	// Token: 0x040003FA RID: 1018
	public ArmorComponent armorComponent;

	// Token: 0x040003FB RID: 1019
	[Header("Fuel")]
	public ItemFuel fuel;

	// Token: 0x040003FC RID: 1020
	[Header("Meta")]
	public InventoryItem.ItemTag tag;

	// Token: 0x040003FD RID: 1021
	public InventoryItem.ItemRarity rarity;

	// Token: 0x040003FE RID: 1022
	public MobType.Weakness[] attackTypes;

	// Token: 0x02000151 RID: 337
	public enum ItemType
	{
		// Token: 0x040008C7 RID: 2247
		Item,
		// Token: 0x040008C8 RID: 2248
		Axe,
		// Token: 0x040008C9 RID: 2249
		Pickaxe,
		// Token: 0x040008CA RID: 2250
		Sword,
		// Token: 0x040008CB RID: 2251
		Shield,
		// Token: 0x040008CC RID: 2252
		Shovel,
		// Token: 0x040008CD RID: 2253
		Storage,
		// Token: 0x040008CE RID: 2254
		Station,
		// Token: 0x040008CF RID: 2255
		Food,
		// Token: 0x040008D0 RID: 2256
		Bow
	}

	// Token: 0x02000152 RID: 338
	public enum ProcessType
	{
		// Token: 0x040008D2 RID: 2258
		Smelt,
		// Token: 0x040008D3 RID: 2259
		Cook,
		// Token: 0x040008D4 RID: 2260
		None
	}

	// Token: 0x02000153 RID: 339
	[Serializable]
	public enum ItemTag
	{
		// Token: 0x040008D6 RID: 2262
		None,
		// Token: 0x040008D7 RID: 2263
		Fuel,
		// Token: 0x040008D8 RID: 2264
		Food,
		// Token: 0x040008D9 RID: 2265
		LeftHanded,
		// Token: 0x040008DA RID: 2266
		Helmet,
		// Token: 0x040008DB RID: 2267
		Torso,
		// Token: 0x040008DC RID: 2268
		Legs,
		// Token: 0x040008DD RID: 2269
		Feet,
		// Token: 0x040008DE RID: 2270
		Arrow,
		// Token: 0x040008DF RID: 2271
		Armor,
		// Token: 0x040008E0 RID: 2272
		Gem
	}

	// Token: 0x02000154 RID: 340
	public enum ItemRarity
	{
		// Token: 0x040008E2 RID: 2274
		Common,
		// Token: 0x040008E3 RID: 2275
		Uncommon,
		// Token: 0x040008E4 RID: 2276
		Rare
	}

	// Token: 0x02000155 RID: 341
	[Serializable]
	public class CraftRequirement
	{
		// Token: 0x040008E5 RID: 2277
		public InventoryItem item;

		// Token: 0x040008E6 RID: 2278
		public int amount;
	}
}
