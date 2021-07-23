using UnityEngine;

public class ShrineInteractable : MonoBehaviour, SharedObject, Interactable
{
    private int id;

    public MeshRenderer[] lights;

    public Material lightMat;

    private int[] mobIds;

    public bool started;

    public LayerMask whatIsGround;

    public GameObject destroyShrineFx;

    private void Start()
    {
    }

    private void CheckLights()
    {
        int num = 0;
        int[] array = mobIds;
        foreach (int key in array)
        {
            if (!MobManager.Instance.mobs.ContainsKey(key))
            {
                num++;
            }
        }
        for (int j = 0; j < num; j++)
        {
            lights[j].material = lightMat;
        }
        if (num >= 3)
        {
            CancelInvoke("CheckLights");
            if (LocalClient.serverOwner)
            {
                Invoke("DropPowerup", 1.33f);
            }
            Object.Instantiate(destroyShrineFx, base.transform.position, destroyShrineFx.transform.rotation);
            Invoke("DestroyShrine", 1.33f);
        }
    }

    private void DestroyShrine()
    {
        ResourceManager.Instance.RemoveInteractItem(id);
    }

    private void DropPowerup()
    {
        Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(0.3f, 0.2f, 0.1f);
        int nextId = ItemManager.Instance.GetNextId();
        ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
        ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
    }

    public void Interact()
    {
        if (!started)
        {
            ClientSend.StartCombatShrine(id);
            AchievementManager.Instance.StartBattleTotem();
        }
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
    }

    public void StartShrine(int[] mobIds)
    {
        this.mobIds = mobIds;
        started = true;
        InvokeRepeating("CheckLights", 0.5f, 0.5f);
        Object.Destroy(GetComponent<Collider>());
    }

    public void ServerExecute(int fromClient)
    {
        if (started)
        {
            return;
        }
        mobIds = new int[3];
        MobType mobType = GameLoop.Instance.SelectMobToSpawn(shrine: true);
        int num = 3;
        for (int i = 0; i < num; i++)
        {
            int nextId = MobManager.Instance.GetNextId();
            int mobType2 = mobType.id;
            if (Physics.Raycast(base.transform.position + new Vector3(Random.Range(-1f, 1f) * 10f, 100f, Random.Range(-1f, 1f) * 10f), Vector3.down, out var hitInfo, 200f, whatIsGround))
            {
                MobSpawner.Instance.ServerSpawnNewMob(nextId, mobType2, hitInfo.point, 1.75f, 1f);
                mobIds[i] = nextId;
            }
        }
        StartShrine(mobIds);
        ServerSend.ShrineStart(mobIds, id);
    }

    public void RemoveObject()
    {
        Object.Destroy(base.gameObject.transform.root.gameObject);
    }

    public string GetName()
    {
        return "Start battle";
    }

    public bool IsStarted()
    {
        return started;
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
