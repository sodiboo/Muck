using System;
using UnityEngine;

public class Titan : MonoBehaviour
{
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	public void StompFx()
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.stompAttack, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	public void JumpFx()
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.jumpFx, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	public GameObject stompAttack;

	public GameObject jumpFx;

	public Transform stompPosition;

	private Mob m;
}
