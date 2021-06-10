
using UnityEngine;

// Token: 0x020000E1 RID: 225
public class SpawnAttackFx : MonoBehaviour
{
	// Token: 0x060006AB RID: 1707 RVA: 0x0002184A File Offset: 0x0001FA4A
	private void Awake()
	{
		this.m = base.GetComponent<Mob>();
	}

	// Token: 0x060006AC RID: 1708 RVA: 0x00021858 File Offset: 0x0001FA58
	public void SpawnFx(int n)
	{
		ImpactDamage componentInChildren =Instantiate(this.attackFx[n], this.spawnPos.position, this.attackFx[n].transform.rotation).GetComponentInChildren<ImpactDamage>();
		componentInChildren.baseDamage = (int)((float)componentInChildren.baseDamage * this.m.multiplier);
	}

	// Token: 0x0400064C RID: 1612
	public GameObject[] attackFx;

	// Token: 0x0400064D RID: 1613
	public Transform spawnPos;

	// Token: 0x0400064E RID: 1614
	private Mob m;
}
