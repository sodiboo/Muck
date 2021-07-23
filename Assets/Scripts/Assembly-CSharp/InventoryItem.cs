using UnityEngine;
using System;

public class InventoryItem : ScriptableObject
{
	[Serializable]
	public class CraftRequirement
	{
		public InventoryItem item;
		public int amount;
	}

	public enum ItemType
	{
		Item = 0,
		Axe = 1,
		Pickaxe = 2,
		Sword = 3,
		Shield = 4,
		Shovel = 5,
		Storage = 6,
		Station = 7,
		Food = 8,
		Bow = 9,
	}

	public enum ProcessType
	{
		Smelt = 0,
		Cook = 1,
		None = 2,
	}

	public enum ItemTag
	{
		None = 0,
		Fuel = 1,
		Food = 2,
		LeftHanded = 3,
		Helmet = 4,
		Torso = 5,
		Legs = 6,
		Feet = 7,
		Arrow = 8,
		Armor = 9,
		Gem = 10,
	}

	public enum ItemRarity
	{
		Common = 0,
		Uncommon = 1,
		Rare = 2,
	}

	public bool important;
	public int id;
	public new string name;
	public string description;
	public ItemType type;
	public int tier;
	public Sprite sprite;
	public Material material;
	public Mesh mesh;
	public Vector3 rotationOffset;
	public Vector3 positionOffset;
	public float scale;
	public bool stackable;
	public int amount;
	public int max;
	public int resourceDamage;
	public int attackDamage;
	public float attackSpeed;
	public float attackRange;
	public float sharpness;
	public bool craftable;
	public bool unlockWithFirstRequirementOnly;
	public CraftRequirement[] requirements;
	public int craftAmount;
	public InventoryItem stationRequirement;
	public bool buildable;
	public bool grid;
	public GameObject prefab;
	public Vector3 buildRotation;
	public bool processable;
	public ProcessType processType;
	public InventoryItem processedItem;
	public float processTime;
	public float heal;
	public float hunger;
	public float stamina;
	public int armor;
	public bool swingFx;
	public BowComponent bowComponent;
	public ArmorComponent armorComponent;
	public ItemFuel fuel;
	public ItemTag tag;
	public ItemRarity rarity;
	public MobType.Weakness[] attackTypes;
}
