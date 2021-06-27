using System;
using UnityEngine;

// Token: 0x02000132 RID: 306
public class WaterSplash : MonoBehaviour
{
	// Token: 0x060008C4 RID: 2244 RVA: 0x0002B9D5 File Offset: 0x00029BD5
	private void Awake()
	{
		InvokeRepeating(nameof(SlowUpdate), 0.15f, 0.15f);
	}

	// Token: 0x060008C5 RID: 2245 RVA: 0x0002B9EC File Offset: 0x00029BEC
	private void SlowUpdate()
	{
		float y = World.Instance.water.transform.position.y;
		Vector3 position = base.transform.position;
		if (this.lastPos.y < y)
		{
			if (position.y > y)
			{
				Vector3 forward = position - this.lastPos;
				Instantiate<GameObject>(this.splashFx, base.transform.position, Quaternion.LookRotation(forward));
			}
		}
		else if (position.y < y)
		{
			Vector3 forward2 = position - this.lastPos;
			Instantiate<GameObject>(this.splashFx, base.transform.position, Quaternion.LookRotation(forward2));
		}
		this.lastPos = position;
	}

	// Token: 0x0400084F RID: 2127
	public GameObject splashFx;

	// Token: 0x04000850 RID: 2128
	private Rigidbody rb;

	// Token: 0x04000851 RID: 2129
	private Vector3 lastPos;
}
