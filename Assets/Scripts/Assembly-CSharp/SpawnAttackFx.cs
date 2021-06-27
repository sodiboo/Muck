using System;
using UnityEngine;

public class SpawnAttackFx : MonoBehaviour
{
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	public void SpawnFx(int n)
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.attackFx[n], this.spawnPos.position, this.attackFx[n].transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	public GameObject[] attackFx;

	public Transform spawnPos;

	private Mob m;
}
