using UnityEngine;

// Token: 0x020000FD RID: 253
public class GrowableFoodZone : SpawnZone
{
	// Token: 0x060006A6 RID: 1702 RVA: 0x000227C0 File Offset: 0x000209C0
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

	// Token: 0x060006A7 RID: 1703 RVA: 0x0002283C File Offset: 0x00020A3C
	public override GameObject LocalSpawnEntity(Vector3 pos, int entityId, int objectId, int zoneId)
	{
		GameObject gameObject =Instantiate<GameObject>(ItemManager.Instance.allItems[entityId].prefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(objectId);
		ResourceManager.Instance.AddObject(objectId, gameObject);
		this.entities.Add(gameObject);
		return gameObject;
	}

	// Token: 0x060006A8 RID: 1704 RVA: 0x00022890 File Offset: 0x00020A90
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

	// Token: 0x04000691 RID: 1681
	public InventoryItem[] spawnItems;

	// Token: 0x04000692 RID: 1682
	public float[] spawnChance;

	// Token: 0x04000693 RID: 1683
	public float totalWeight;
}
