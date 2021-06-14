using System;
using UnityEngine;

// Token: 0x02000039 RID: 57
public class GronkSwordProjectile : MonoBehaviour
{
	// Token: 0x06000138 RID: 312 RVA: 0x0000C204 File Offset: 0x0000A404
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
