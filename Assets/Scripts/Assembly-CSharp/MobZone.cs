using UnityEngine;

public class MobZone : SpawnZone
{
    public MobType mobType;

    public override void ServerSpawnEntity()
    {
        MonoBehaviour.print("spawning mob from id: " + id);
        MonoBehaviour.print("queue: " + entityQueue);
        Vector3 vector = FindRandomPos();
        if (!(vector == Vector3.zero))
        {
            entityBuffer--;
            int nextId = MobManager.Instance.GetNextId();
            int entityType = mobType.id;
            GameObject gameObject = LocalSpawnEntity(vector, entityType, nextId, id);
            MobServerNeutral component = gameObject.GetComponent<MobServerNeutral>();
            if ((bool)component)
            {
                component.mobZoneId = id;
            }
            ServerSend.MobZoneSpawn(vector, entityType, nextId, id);
            if (mobType.name == "Woodman")
            {
                gameObject.GetComponent<WoodmanBehaviour>().mobZoneId = id;
            }
            else if (mobType.behaviour != 0)
            {
                gameObject.AddComponent<DontAttackUntilPlayerSpotted>().mobZoneId = id;
            }
        }
    }

    public override GameObject LocalSpawnEntity(Vector3 pos, int mobType, int mobId, int zoneId)
    {
        Mob component = Object.Instantiate(MobSpawner.Instance.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
        component.tag = "DontCount";
        MobManager.Instance.AddMob(component, mobId);
        entities.Add(component.gameObject);
        return component.gameObject;
    }
}
