using System;
using UnityEngine;

public class Fireball : MonoBehaviour
{
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

	public InventoryItem fireball;

	public GameObject warningFx;
}
