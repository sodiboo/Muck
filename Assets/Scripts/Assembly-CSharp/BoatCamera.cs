using System;
using UnityEngine;

// Token: 0x02000007 RID: 7
public class BoatCamera : MonoBehaviour
{
	// Token: 0x06000027 RID: 39 RVA: 0x00002EDD File Offset: 0x000010DD
	private void Awake()
	{
		this.target = Boat.Instance.rbTransform;
		this.dragonTransform = Dragon.Instance.transform;
		Invoke(nameof(StopCamera), 5f);
	}

	// Token: 0x06000028 RID: 40 RVA: 0x00002F0F File Offset: 0x0000110F
	private void StopCamera()
	{
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000029 RID: 41 RVA: 0x00002F20 File Offset: 0x00001120
	private void Update()
	{
		if (base.transform != this.dragonTransform && this.dragonTransform.position.y > this.target.transform.position.y)
		{
			this.target = this.dragonTransform;
		}
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6f);
	}

	// Token: 0x04000030 RID: 48
	private Transform target;

	// Token: 0x04000031 RID: 49
	private Transform dragonTransform;
}
