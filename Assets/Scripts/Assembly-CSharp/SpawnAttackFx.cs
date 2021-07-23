using UnityEngine;

public class SpawnAttackFx : MonoBehaviour
{
    public GameObject[] attackFx;

    public Transform spawnPos;

    private Mob m;

    private void Awake()
    {
        m = GetComponent<Mob>();
    }

    public void SpawnFx(int n)
    {
        ImpactDamage componentInChildren = Object.Instantiate(attackFx[n], spawnPos.position, attackFx[n].transform.rotation).GetComponentInChildren<ImpactDamage>();
        componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * m.multiplier);
    }
}
