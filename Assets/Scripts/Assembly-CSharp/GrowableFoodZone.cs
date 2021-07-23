using UnityEngine;

public class GrowableFoodZone : SpawnZone
{
    public InventoryItem[] spawnItems;

    public float[] spawnChance;

    public float totalWeight;

    public override void ServerSpawnEntity()
    {
        MonoBehaviour.print("spawning food from id: " + id);
        Vector3 vector = FindRandomPos();
        if (!(vector == Vector3.zero))
        {
            entityBuffer--;
            int nextId = ResourceManager.Instance.GetNextId();
            int num = FindItemToSpawn();
            LocalSpawnEntity(vector, num, nextId, id);
            ServerSend.PickupZoneSpawn(vector, num, nextId, id);
        }
    }

    public override GameObject LocalSpawnEntity(Vector3 pos, int entityId, int objectId, int zoneId)
    {
        GameObject gameObject = Object.Instantiate(ItemManager.Instance.allItems[entityId].prefab, pos, Quaternion.identity);
        gameObject.GetComponentInChildren<SharedObject>().SetId(objectId);
        ResourceManager.Instance.AddObject(objectId, gameObject);
        entities.Add(gameObject);
        return gameObject;
    }

    public int FindItemToSpawn()
    {
        float num = Random.Range(0f, 1f);
        float num2 = 0f;
        for (int i = 0; i < spawnItems.Length; i++)
        {
            num2 += spawnChance[i];
            if (num < num2 / totalWeight)
            {
                return spawnItems[i].id;
            }
        }
        return spawnItems[0].id;
    }
}
