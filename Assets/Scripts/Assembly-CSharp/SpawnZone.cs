using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public abstract class SpawnZone : MonoBehaviour, SharedObject
{
    public int id;

    public List<GameObject> entities;

    protected int entityBuffer;

    protected int entityQueue;

    public float roamDistance;

    public float renderDistance;

    public bool despawn = true;

    public int entityCap = 3;

    public float respawnTime = 60f;

    public float updateRate = 2f;

    private bool rendered;

    public LayerMask whatIsGround;

    private void Start()
    {
        entityQueue = entityCap;
        entityBuffer = entityCap;
        if (Application.isPlaying)
        {
            entities = new List<GameObject>();
            InvokeRepeating(nameof(SlowUpdate), Random.Range(0f, updateRate), updateRate);
        }
    }

    private void SlowUpdate()
    {
        if (!LocalClient.serverOwner || GameManager.state != GameManager.GameState.Playing)
        {
            return;
        }
        entities.RemoveAll((GameObject item) => item == null);
        if (entities.Count + entityBuffer < entityCap)
        {
            if (respawnTime >= 0f)
            {
                Invoke(nameof(QueueEntity), respawnTime);
            }
            entityBuffer++;
        }
        bool flag = false;
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if (!(value == null) && Vector3.Distance(base.transform.position, value.transform.position) < renderDistance)
            {
                flag = true;
                break;
            }
        }
        if (flag)
        {
            int num = entityQueue;
            for (int i = 0; i < num; i++)
            {
                MonoBehaviour.print("dequeing");
                ServerSpawnEntity();
                entityQueue--;
            }
            if (!rendered)
            {
                ServerSend.MobZoneToggle(show: true, id);
                rendered = true;
            }
        }
        else if (rendered)
        {
            rendered = false;
            if (despawn)
            {
                ServerSend.MobZoneToggle(show: false, id);
            }
        }
    }

    private void QueueEntity()
    {
        entityQueue++;
    }

    public abstract void ServerSpawnEntity();

    public Vector3 FindRandomPos()
    {
        Vector2 insideUnitCircle = Random.insideUnitCircle;
        Vector3 origin = base.transform.position + new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y) * roamDistance;
        origin.y = 200f;
        if (Physics.Raycast(origin, Vector3.down, out var hitInfo, 500f, whatIsGround))
        {
            return hitInfo.point;
        }
        return Vector3.zero;
    }

    public abstract GameObject LocalSpawnEntity(Vector3 pos, int entityType, int objectId, int zoneId);

    public void ToggleEntities(bool show)
    {
        foreach (GameObject entity in entities)
        {
            if (entity != null)
            {
                entity.gameObject.SetActive(show);
            }
        }
    }

    private void OnDrawGizmos()
    {
    }

    public void SetId(int id)
    {
        this.id = id;
    }

    public int GetId()
    {
        return id;
    }
}
