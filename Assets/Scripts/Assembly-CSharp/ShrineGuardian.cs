using UnityEngine;

public class ShrineGuardian : MonoBehaviour, SharedObject, Interactable
{
    public Guardian.GuardianType type;

    private bool started;

    private int id;

    public MobType boss;

    public GameObject destroyShrineFx;

    public MeshRenderer gemRend;

    public Material[] gemMats;

    private void Start()
    {
        gemRend.material = gemMats[(int)(type - 1)];
        Boat.Instance.guardians.Add(this);
    }

    public void Interact()
    {
        if (!started)
        {
            ClientSend.Interact(id);
        }
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
        started = true;
        Object.Instantiate(destroyShrineFx, base.transform.position, destroyShrineFx.transform.rotation);
        Invoke(nameof(RemoveFromResources), 1.33f);
    }

    public void ServerExecute(int fromClient)
    {
        started = true;
        Invoke(nameof(SpawnBoss), 1.3f);
        Object.Instantiate(destroyShrineFx, base.transform.position, destroyShrineFx.transform.rotation);
        ServerSend.SendChatMessage(-1, "", "<color=orange>" + GameManager.players[fromClient].username + " summoned <color=red>" + boss.name);
    }

    private void SpawnBoss()
    {
        int nextId = MobManager.Instance.GetNextId();
        float bossMultiplier = 0.9f + 0.1f * (float)GameManager.instance.GetPlayersAlive();
        float multiplier = 1.5f;
        if (Random.Range(0f, 1f) < 0.2f)
        {
            multiplier = 1.5f;
        }
        Vector3 position = base.transform.position;
        MobSpawner.Instance.ServerSpawnNewMob(nextId, boss.id, position, multiplier, bossMultiplier, Mob.BossType.BossShrine, (int)type);
    }

    private void RemoveFromResources()
    {
        ResourceManager.Instance.RemoveInteractItem(id);
        Object.Destroy(base.gameObject.transform.root.gameObject);
    }

    public void RemoveObject()
    {
        Object.Destroy(base.gameObject);
    }

    public string GetName()
    {
        return "Challenge " + boss.name;
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
