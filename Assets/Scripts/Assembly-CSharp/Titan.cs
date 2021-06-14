using System;
using UnityEngine;

// Token: 0x0200014B RID: 331
public class Titan : MonoBehaviour
{
	// Token: 0x060007F4 RID: 2036 RVA: 0x0000739B File Offset: 0x0000559B
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x060007F5 RID: 2037 RVA: 0x0002715C File Offset: 0x0002535C
	public void StompFx()
	{
		ImpactDamage componentInChildren =Instantiate<GameObject>(this.stompAttack, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x060007F6 RID: 2038 RVA: 0x000271B4 File Offset: 0x000253B4
	public void JumpFx()
	{
		ImpactDamage componentInChildren =Instantiate<GameObject>(this.jumpFx, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x04000835 RID: 2101
	public GameObject stompAttack;

	// Token: 0x04000836 RID: 2102
	public GameObject jumpFx;

	// Token: 0x04000837 RID: 2103
	public Transform stompPosition;

	// Token: 0x04000838 RID: 2104
	private Mob m;
}
