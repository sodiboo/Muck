using UnityEngine;

public class MobServerNeutral : MobServer
{
    public int mobZoneId { get; set; }

    private void Start()
    {
        FindPositionInterval = 12f;
    }

    protected override void Behaviour()
    {
    }

    public override void TookDamage()
    {
        mob.SetSpeed(2f);
        SyncFindNextPosition();
    }

    protected override Vector3 FindNextPosition()
    {
        Invoke(nameof(SyncFindNextPosition), 12f);
        return MobZoneManager.Instance.zones[mobZoneId].FindRandomPos();
    }

    private void OnDisable()
    {
        CancelInvoke();
    }

    private void OnEnable()
    {
        FindPositionInterval = 10f;
        StartRoutines();
    }
}
