using System;
using UnityEngine;

// Token: 0x0200012D RID: 301
public class SpawnAttackFx : MonoBehaviour
{
	// Token: 0x06000758 RID: 1880 RVA: 0x00006D8F File Offset: 0x00004F8F
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x06000759 RID: 1881 RVA: 0x00024B8C File Offset: 0x00022D8C
	public void SpawnFx(int n)
	{
		ImpactDamage componentInChildren =Instantiate<GameObject>(this.attackFx[n], this.spawnPos.position, this.attackFx[n].transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x04000797 RID: 1943
	public GameObject[] attackFx;

	// Token: 0x04000798 RID: 1944
	public Transform spawnPos;

	// Token: 0x04000799 RID: 1945
	private Mob m;
}
