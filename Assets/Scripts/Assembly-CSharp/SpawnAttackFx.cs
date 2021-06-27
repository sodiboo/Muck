using System;
using UnityEngine;

// Token: 0x0200010D RID: 269
public class SpawnAttackFx : MonoBehaviour
{
	// Token: 0x060007E6 RID: 2022 RVA: 0x00027E8E File Offset: 0x0002608E
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x060007E7 RID: 2023 RVA: 0x00027E9C File Offset: 0x0002609C
	public void SpawnFx(int n)
	{
		ImpactDamage componentInChildren = Instantiate<GameObject>(this.attackFx[n], this.spawnPos.position, this.attackFx[n].transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x04000787 RID: 1927
	public GameObject[] attackFx;

	// Token: 0x04000788 RID: 1928
	public Transform spawnPos;

	// Token: 0x04000789 RID: 1929
	private Mob m;
}
