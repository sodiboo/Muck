using UnityEngine;

public class Titan : MonoBehaviour
{
    public GameObject stompAttack;

    public GameObject jumpFx;

    public Transform stompPosition;

    private Mob m;

    private void Awake()
    {
        m = GetComponent<Mob>();
    }

    public void StompFx()
    {
        ImpactDamage componentInChildren = Object.Instantiate(stompAttack, stompPosition.transform.position, stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
        componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * m.multiplier);
    }

    public void JumpFx()
    {
        ImpactDamage componentInChildren = Object.Instantiate(jumpFx, stompPosition.transform.position, stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
        componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * m.multiplier);
    }
}
