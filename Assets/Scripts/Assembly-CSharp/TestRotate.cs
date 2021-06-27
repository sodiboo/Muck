using System;
using UnityEngine;

// Token: 0x02000123 RID: 291
public class TestRotate : MonoBehaviour
{
	// Token: 0x0600086F RID: 2159 RVA: 0x0002A4D3 File Offset: 0x000286D3
	private void Update()
	{
		base.transform.Rotate(Vector3.right, 20f * Time.deltaTime);
	}
}
