using System;
using UnityEngine;

// Token: 0x02000127 RID: 295
public class Titan : MonoBehaviour
{
	// Token: 0x0600087C RID: 2172 RVA: 0x0002A6C2 File Offset: 0x000288C2
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x0600087D RID: 2173 RVA: 0x0002A6D0 File Offset: 0x000288D0
	public void StompFx()
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.stompAttack, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x0600087E RID: 2174 RVA: 0x0002A728 File Offset: 0x00028928
	public void JumpFx()
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.jumpFx, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x04000814 RID: 2068
	public GameObject stompAttack;

	// Token: 0x04000815 RID: 2069
	public GameObject jumpFx;

	// Token: 0x04000816 RID: 2070
	public Transform stompPosition;

	// Token: 0x04000817 RID: 2071
	private Mob m;
}
