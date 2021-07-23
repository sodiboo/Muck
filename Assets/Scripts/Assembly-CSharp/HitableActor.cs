using UnityEngine;

public class HitableActor : Hitable
{
    public enum ActorType
    {
        Player,
        Enemy
    }

    public ActorType actorType;

    public override void Hit(int damage, float sharpness, int hitEffect, Vector3 pos, int hitWeaponType)
    {
        if (GameManager.gameSettings.friendlyFire != 0 && actorType == ActorType.Player)
        {
            ClientSend.PlayerHit(damage, id, sharpness, hitEffect, pos);
        }
    }

    private void Update()
    {
    }

    public new virtual int Damage(int damage, int fromClient, int hitEffect, Vector3 pos)
    {
        Vector3 dir = GameManager.players[fromClient].transform.position - pos;
        SpawnParticles(pos, dir, hitEffect);
        Object.Instantiate(numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(damage, dir, (HitEffect)hitEffect);
        return hp;
    }

    public override void OnKill(Vector3 dir)
    {
    }

    protected override void ExecuteHit()
    {
    }
}
