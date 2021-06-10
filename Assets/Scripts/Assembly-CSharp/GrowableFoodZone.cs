
using UnityEngine;

// Token: 0x020000C0 RID: 192
public class GrowableFoodZone : SpawnZone
{
	// Token: 0x06000613 RID: 1555 RVA: 0x0001ECD4 File Offset: 0x0001CED4
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

	// Token: 0x06000614 RID: 1556 RVA: 0x0001ED50 File Offset: 0x0001CF50
	public override GameObject LocalSpawnEntity(Vector3 pos, int entityId, int objectId, int zoneId)
	{
		GameObject gameObject =Instantiate(ItemManager.Instance.allItems[entityId].prefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(objectId);
		ResourceManager.Instance.AddObject(objectId, gameObject);
		this.entities.Add(gameObject);
		return gameObject;
	}

	// Token: 0x06000615 RID: 1557 RVA: 0x0001EDA4 File Offset: 0x0001CFA4
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

	// Token: 0x0400058A RID: 1418
	public InventoryItem[] spawnItems;

	// Token: 0x0400058B RID: 1419
	public float[] spawnChance;

	// Token: 0x0400058C RID: 1420
	public float totalWeight;
}
