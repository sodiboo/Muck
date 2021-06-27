using System;
using UnityEngine;

// Token: 0x02000036 RID: 54
public class Fireball : MonoBehaviour
{
	// Token: 0x06000140 RID: 320 RVA: 0x00007CA8 File Offset: 0x00005EA8
	private void Start()
	{
		Vector3 forward = base.transform.forward;
		Vector3 euler = base.transform.rotation.eulerAngles + new Vector3(0f, 0f, -90f);
		base.transform.rotation = Quaternion.Euler(euler);
		Rigidbody component = base.GetComponent<Rigidbody>();
		component.velocity = forward * this.fireball.bowComponent.projectileSpeed;
		component.maxAngularVelocity = 9999f;
		component.AddRelativeTorque(component.angularVelocity * 2000f);
		component.angularVelocity = Vector3.zero;
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, base.transform.forward, out raycastHit, 5000f, GameManager.instance.whatIsGround))
		{
			EnemyAttackIndicator component2 = Instantiate<GameObject>(this.warningFx, raycastHit.point, this.warningFx.transform.rotation).GetComponent<EnemyAttackIndicator>();
			float num = Vector3.Distance(base.transform.position, raycastHit.point);
			float magnitude = component.velocity.magnitude;
			float time = num / magnitude;
			component2.SetWarning(time, 5f);
		}
	}

	// Token: 0x0400013C RID: 316
	public InventoryItem fireball;

	// Token: 0x0400013D RID: 317
	public GameObject warningFx;
}
