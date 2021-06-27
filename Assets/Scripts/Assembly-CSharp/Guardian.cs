using System;
using UnityEngine;

public class Guardian : MonoBehaviour
{
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

	private void OnDestroy()
	{
		for (int i = 0; i < this.destroyOnDeath.Length; i++)
		{
			Destroy(this.destroyOnDeath[i]);
		}
	}

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

	public Guardian.GuardianType type;

	public Material[] guardianMaterial;

	public Material[] fxMaterial;

	public InventoryItem[] gems;

	public SkinnedMeshRenderer rend;

	public ParticleSystem[] particles;

	public LineRenderer[] lines;

	public TrailRenderer[] trails;

	public Hitable hitable;

	public GameObject[] destroyOnDeath;

	public enum GuardianType
	{
		Basic,
		Red,
		Yellow,
		Green,
		Blue,
		Pink
	}
}
