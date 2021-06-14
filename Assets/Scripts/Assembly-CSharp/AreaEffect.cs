using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A2 RID: 162
public class AreaEffect : MonoBehaviour
{
	// Token: 0x060003C9 RID: 969 RVA: 0x00004AD8 File Offset: 0x00002CD8
	public void SetDamage(int d)
	{
		this.damage = d;
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x060003CA RID: 970 RVA: 0x00015F0C File Offset: 0x0001410C
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

	// Token: 0x040003C9 RID: 969
	private int damage;

	// Token: 0x040003CA RID: 970
	private List<GameObject> actorsHit;
}
