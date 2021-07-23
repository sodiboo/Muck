using UnityEngine;

public class MobSpawner : MonoBehaviour
{
    public MobType[] mobsInspector;

    public MobType[] allMobs;

    public static MobSpawner Instance;

    private void Awake()
    {
        Instance = this;
        FillList();
    }

    private void FillList()
    {
        allMobs = new MobType[mobsInspector.Length];
        for (int i = 0; i < mobsInspector.Length; i++)
        {
            allMobs[i] = mobsInspector[i];
            allMobs[i].id = i;
        }
    }

    public void ServerSpawnNewMob(int mobId, int mobType, Vector3 pos, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None, int guardianType = -1)
    {
        SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, bossType, guardianType);
        ServerSend.MobSpawn(pos, mobType, mobId, multiplier, bossMultiplier, guardianType);
    }

    public void SpawnMob(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None, int guardianType = -1)
    {
        Mob component = Object.Instantiate(allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
        MobManager.Instance.AddMob(component, mobId);
        component.multiplier = multiplier;
        component.bossMultiplier = bossMultiplier;
        if (component.bossType != Mob.BossType.BossShrine || bossType != 0)
        {
            component.bossType = bossType;
        }
        if (guardianType != -1)
        {
            component.GetComponent<Guardian>().type = (Guardian.GuardianType)guardianType;
        }
        MonoBehaviour.print("spawned new mob with id: " + mobId);
    }
}
