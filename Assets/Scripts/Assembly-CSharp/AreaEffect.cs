using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000083 RID: 131
public class AreaEffect : MonoBehaviour
{
	// Token: 0x0600037D RID: 893 RVA: 0x000122A5 File Offset: 0x000104A5
	public void SetDamage(int d)
	{
		this.damage = d;
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x0600037E RID: 894 RVA: 0x000122BC File Offset: 0x000104BC
	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Build"))
		{
			return;
		}
		Hitable component = other.GetComponent<Hitable>();
		if (component == null)
		{
			return;
		}
		if (other.transform.root.CompareTag("Local"))
		{
			return;
		}
		component.Hit(this.damage, 0f, 3, base.transform.position);
	Destroy(this);
	}

	// Token: 0x04000339 RID: 825
	private int damage;

	// Token: 0x0400033A RID: 826
	private List<GameObject> actorsHit;
}
