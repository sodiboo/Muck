
using UnityEngine;

// Token: 0x020000F7 RID: 247
public class Titan : MonoBehaviour
{
	// Token: 0x06000738 RID: 1848 RVA: 0x00023DE2 File Offset: 0x00021FE2
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x06000739 RID: 1849 RVA: 0x00023DF0 File Offset: 0x00021FF0
	public void StompFx()
	{
		ImpactDamage componentInChildren =Instantiate(this.stompAttack, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x0600073A RID: 1850 RVA: 0x00023E48 File Offset: 0x00022048
	public void JumpFx()
	{
		ImpactDamage componentInChildren =Instantiate(this.jumpFx, this.stompPosition.transform.position, this.stompAttack.transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x040006CF RID: 1743
	public GameObject stompAttack;

	// Token: 0x040006D0 RID: 1744
	public GameObject jumpFx;

	// Token: 0x040006D1 RID: 1745
	public Transform stompPosition;

	// Token: 0x040006D2 RID: 1746
	private Mob m;
}
