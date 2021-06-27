using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A9 RID: 169
public class AreaEffect : MonoBehaviour
{
	// Token: 0x0600046A RID: 1130 RVA: 0x000170D5 File Offset: 0x000152D5
	public void SetDamage(int d)
	{
		this.damage = d;
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x0600046B RID: 1131 RVA: 0x000170EC File Offset: 0x000152EC
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

	// Token: 0x04000436 RID: 1078
	private int damage;

	// Token: 0x04000437 RID: 1079
	private List<GameObject> actorsHit;
}
