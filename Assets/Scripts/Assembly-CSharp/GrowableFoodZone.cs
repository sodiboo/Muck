using UnityEngine;

// Token: 0x020000E8 RID: 232
public class GrowableFoodZone : SpawnZone
{
	// Token: 0x0600072D RID: 1837 RVA: 0x00024D78 File Offset: 0x00022F78
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

	// Token: 0x0600072E RID: 1838 RVA: 0x00024DF4 File Offset: 0x00022FF4
	public override GameObject LocalSpawnEntity(Vector3 pos, int entityId, int objectId, int zoneId)
	{
		GameObject gameObject = Instantiate<GameObject>(ItemManager.Instance.allItems[entityId].prefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(objectId);
		ResourceManager.Instance.AddObject(objectId, gameObject);
		this.entities.Add(gameObject);
		return gameObject;
	}

	// Token: 0x0600072F RID: 1839 RVA: 0x00024E48 File Offset: 0x00023048
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

	// Token: 0x040006B0 RID: 1712
	public InventoryItem[] spawnItems;

	// Token: 0x040006B1 RID: 1713
	public float[] spawnChance;

	// Token: 0x040006B2 RID: 1714
	public float totalWeight;
}
