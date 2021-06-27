using UnityEngine;

public class GrowableFoodZone : SpawnZone
{
	public override void ServerSpawnEntity()
	{
		MonoBehaviour.print("spawning food from id: " + this.id);
		Vector3 vector = base.FindRandomPos();
		if (vector == Vector3.zero)
		{
			return;
		}
		this.entityBuffer--;
		int nextId = ResourceManager.Instance.GetNextId();
		int num = this.FindItemToSpawn();
		this.LocalSpawnEntity(vector, num, nextId, this.id);
		ServerSend.PickupZoneSpawn(vector, num, nextId, this.id);
	}

	public override GameObject LocalSpawnEntity(Vector3 pos, int entityId, int objectId, int zoneId)
	{
		GameObject gameObject = Instantiate<GameObject>(ItemManager.Instance.allItems[entityId].prefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(objectId);
		ResourceManager.Instance.AddObject(objectId, gameObject);
		this.entities.Add(gameObject);
		return gameObject;
	}

	public int FindItemToSpawn()
	{
		float num = Random.Range(0f, 1f);
		float num2 = 0f;
		for (int i = 0; i < this.spawnItems.Length; i++)
		{
			num2 += this.spawnChance[i];
			if (num < num2 / this.totalWeight)
			{
				return this.spawnItems[i].id;
			}
		}
		return this.spawnItems[0].id;
	}

	public InventoryItem[] spawnItems;

	public float[] spawnChance;

	public float totalWeight;
}
