using System;
using UnityEngine;


[CreateAssetMenu]
public class InventoryItem : ScriptableObject
{

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
		this.mats = item.mats;
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
		this.buildOffset = item.buildOffset;
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
	}


	public bool IsArmour()
	{
		return this.tag == InventoryItem.ItemTag.Helmet || this.tag == InventoryItem.ItemTag.Torso || this.tag == InventoryItem.ItemTag.Legs || this.tag == InventoryItem.ItemTag.Feet;
	}


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


	public bool Compare(InventoryItem other)
	{
		return !(other == null) && this.id == other.id;
	}


	public string GetAmount()
	{
		if (!this.stackable || this.amount == 1)
		{
			return "";
		}
		return this.amount.ToString();
	}


	[Header("Basic")]
	public int id;


	public new string name;


	public string description;


	public InventoryItem.ItemType type;


	public int tier;


	[Header("Visuals")]
	public Sprite sprite;


	public Material material;


	public Mesh mesh;
	public int mats = 1;


	public Vector3 rotationOffset;


	public Vector3 positionOffset;


	public float scale = 1f;


	[Header("Inventory details")]
	public bool stackable = true;


	public int amount;


	public int max = 69;


	[Header("Weapon")]
	public int resourceDamage = 1;


	public int attackDamage = 1;


	public float attackSpeed = 1f;


	public Vector3 attackRange = Vector3.one;


	public float sharpness;


	[Header("Crafting")]
	public bool craftable;


	public bool unlockWithFirstRequirementOnly;


	public InventoryItem.CraftRequirement[] requirements;


	public int craftAmount;


	public InventoryItem stationRequirement;


	[Header("Building")]
	public bool buildable;


	public bool grid;


	public GameObject prefab;


	public Vector3 buildRotation;
	public Vector3 buildOffset;


	[Header("Processing")]
	public bool processable;


	public InventoryItem.ProcessType processType;


	public InventoryItem processedItem;


	public float processTime;


	[Header("Food")]
	public float heal;


	public float hunger;


	public float stamina;


	[Header("Other")]
	public int armor;


	public bool swingFx;


	public BowComponent bowComponent;


	public ArmorComponent armorComponent;


	[Header("Fuel")]
	public ItemFuel fuel;


	[Header("Meta")]
	public InventoryItem.ItemTag tag;


	public InventoryItem.ItemRarity rarity;


	public MobType.Weakness[] attackTypes;


	public enum ItemType
	{

		Item,

		Axe,

		Pickaxe,

		Sword,

		Shield,

		Shovel,

		Storage,

		Station,

		Food,

		Bow,
		Car,
	}


	public enum ProcessType
	{

		Smelt,

		Cook,

		None,
	}


	[Serializable]
	public enum ItemTag
	{

		None,

		Fuel,

		Food,

		LeftHanded,

		Helmet,

		Torso,

		Legs,

		Feet,

		Arrow,

		Armor,
		Trigger,
		Precision,
	}


	public enum ItemRarity
	{

		Common,

		Uncommon,

		Rare,
	}


	[Serializable]
	public class CraftRequirement
	{

		public InventoryItem item;


		public int amount;
	}
}
