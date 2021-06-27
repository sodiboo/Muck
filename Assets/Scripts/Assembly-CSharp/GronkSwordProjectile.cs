using System;
using UnityEngine;

// Token: 0x02000043 RID: 67
public class GronkSwordProjectile : MonoBehaviour
{
	// Token: 0x06000191 RID: 401 RVA: 0x00009734 File Offset: 0x00007934
	private void Start()
	{
		Vector3 forward = base.transform.forward;
		Vector3 euler = base.transform.rotation.eulerAngles + new Vector3(0f, 0f, -90f);
		base.transform.rotation = Quaternion.Euler(euler);
		Rigidbody component = base.GetComponent<Rigidbody>();
		component.maxAngularVelocity = 9999f;
		component.AddRelativeTorque(component.angularVelocity * 2000f);
		component.angularVelocity = Vector3.zero;
	}
}
