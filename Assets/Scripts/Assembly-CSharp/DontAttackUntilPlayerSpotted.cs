using UnityEngine;

public class DontAttackUntilPlayerSpotted : MonoBehaviour
{
    private Mob mob;

    private Vector3 headOffset;

    public int mobZoneId;

    private MobServerNeutral neutral;

    private void Start()
    {
        mob = GetComponent<Mob>();
        Object.Destroy(base.gameObject.GetComponent<MobServer>());
        GetComponent<MobServer>().enabled = false;
        neutral = base.gameObject.AddComponent<MobServerNeutral>();
        neutral.mobZoneId = mobZoneId;
        Mesh sharedMesh = GetComponentInChildren<SkinnedMeshRenderer>().sharedMesh;
        headOffset = Vector3.up * sharedMesh.bounds.extents.y * 1.5f;
        InvokeRepeating(nameof(CheckForPlayers), 0.5f, 0.5f);
    }

    private void CheckForPlayers()
    {
        Vector3 forward = base.transform.forward;
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if (!value)
            {
                continue;
            }
            float num = Vector3.Distance(base.transform.position, value.transform.position);
            if (num < 5f)
            {
                FoundPlayer();
            }
            if (num < 40f)
            {
                Vector3 vector = value.transform.position - base.transform.position;
                if (Mathf.Abs(Vector3.SignedAngle(VectorExtensions.XZVector(vector), VectorExtensions.XZVector(forward), Vector3.up)) < 55f)
                {
                    Debug.DrawLine(base.transform.position + headOffset, base.transform.position + headOffset + vector * num, Color.black, 2f);
                    if (Physics.Raycast(base.transform.position + headOffset, vector, out var hitInfo, num, GameManager.instance.whatIsGroundAndObject))
                    {
                        if (hitInfo.collider.gameObject.layer == LayerMask.NameToLayer("Player"))
                        {
                            FoundPlayer();
                        }
                    }
                    else
                    {
                        FoundPlayer();
                    }
                }
            }
            if (mob.hitable.hp < mob.hitable.maxHp)
            {
                FoundPlayer();
            }
        }
    }

    private void FoundPlayer()
    {
        mob.ready = true;
        Object.Destroy(neutral);
        if (mob.mobType.behaviour == MobType.MobBehaviour.Enemy)
        {
            base.gameObject.AddComponent<MobServerEnemy>();
        }
        else
        {
            base.gameObject.AddComponent<MobServerEnemyMeleeAndRanged>();
        }
        Object.Destroy(this);
    }
}
