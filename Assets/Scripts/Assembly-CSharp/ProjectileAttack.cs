﻿using System;
using UnityEngine;

// Token: 0x0200007F RID: 127
public class ProjectileAttack : MonoBehaviour
{
	// Token: 0x060002FC RID: 764 RVA: 0x00010260 File Offset: 0x0000E460
	public void SpawnProjectile()
	{
		Vector3 position = base.GetComponent<Mob>().target.position;
		GameObject gameObject = Instantiate<GameObject>(this.projectile, this.spawnPos.position, Quaternion.identity);
		Rigidbody component = gameObject.GetComponent<Rigidbody>();
		Vector3 vector = this.findLaunchVelocity(position, gameObject);
		float mass = component.mass;
		float fixedDeltaTime = Time.fixedDeltaTime;
		float magnitude = vector.magnitude;
		component.AddForce(mass * (magnitude / fixedDeltaTime) * vector.normalized);
		component.angularVelocity = this.angularVel;
	}

	// Token: 0x060002FD RID: 765 RVA: 0x000102E4 File Offset: 0x0000E4E4
	private Vector3 findLaunchVelocity(Vector3 targetPosition, GameObject newProjectile)
	{
		if (this.useLowestLaunchAngle)
		{
			Quaternion quaternion = Quaternion.LookRotation(targetPosition - this.spawnPos.position);
			float num = quaternion.eulerAngles.x;
			MonoBehaviour.print("raw ang: " + num);
			if (num < 180f)
			{
				num = -num;
			}
			else
			{
				num = 360f - num;
			}
			MonoBehaviour.print("ang: " + (360f - quaternion.eulerAngles.x));
			this.launchAngle = num + this.launchAngle;
		}
		Vector3 a = new Vector3(this.spawnPos.position.x, this.spawnPos.position.y, this.spawnPos.position.z);
		Vector3 vector = new Vector3(targetPosition.x, this.spawnPos.position.y, targetPosition.z);
		float num2 = Vector3.Distance(a, vector);
		newProjectile.transform.LookAt(vector);
		float y = Physics.gravity.y;
		float num3 = Mathf.Tan(this.launchAngle * 0.017453292f);
		float num4 = targetPosition.y - this.spawnPos.position.y;
		float num5 = Mathf.Sqrt(y * num2 * num2 / (2f * (num4 - num2 * num3)));
		float y2 = num3 * num5;
		Vector3 direction = new Vector3(0f, y2, num5);
		return newProjectile.transform.TransformDirection(direction);
	}

	// Token: 0x040002FD RID: 765
	public GameObject projectile;

	// Token: 0x040002FE RID: 766
	public Transform spawnPos;

	// Token: 0x040002FF RID: 767
	public float launchAngle = 40f;

	// Token: 0x04000300 RID: 768
	public bool useLowestLaunchAngle;

	// Token: 0x04000301 RID: 769
	public Vector3 angularVel;

	// Token: 0x04000302 RID: 770
	public float disableColliderTime;
}
