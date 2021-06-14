using System;
using UnityEngine;

// Token: 0x02000071 RID: 113
public class ProjectileAttackNoGravity : MonoBehaviour
{
	// Token: 0x06000272 RID: 626 RVA: 0x00003D52 File Offset: 0x00001F52
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x06000273 RID: 627 RVA: 0x00010B74 File Offset: 0x0000ED74
	private void SpawnProjectile()
	{
		if (!LocalClient.serverOwner || this.mob.target == null)
		{
			return;
		}
		Vector3 position = this.spawnPos.position;
		Vector3 normalized = (this.mob.target.position + Vector3.up * 1f - this.spawnPos.position).normalized;
		float force = this.projectile.bowComponent.projectileSpeed * this.attackForce;
		int id = this.projectile.id;
		int id2 = this.mob.id;
		ServerSend.MobSpawnProjectile(position, normalized, force, id, id2);
		ProjectileController.Instance.SpawnMobProjectile(position, normalized, force, id, id2);
	}

	// Token: 0x06000274 RID: 628 RVA: 0x00010C34 File Offset: 0x0000EE34
	public void SpawnProjectilePredictionTrajectory()
	{
		if (!LocalClient.serverOwner || this.mob.target == null)
		{
			return;
		}
		Vector3 position = this.mob.target.position;
		Rigidbody component = this.projectile.prefab.GetComponent<Rigidbody>();
		Vector3 vector = this.findLaunchVelocity(position, this.spawnPos.gameObject);
		float mass = component.mass;
		float fixedDeltaTime = Time.fixedDeltaTime;
		float magnitude = vector.magnitude;
		Vector3 position2 = this.spawnPos.position;
		Vector3 normalized = vector.normalized;
		float force = mass * (magnitude / fixedDeltaTime);
		int id = this.projectile.id;
		int id2 = this.mob.id;
		ServerSend.MobSpawnProjectile(position2, normalized, force, id, id2);
		ProjectileController.Instance.SpawnMobProjectile(position2, normalized, force, id, id2);
	}

	// Token: 0x06000275 RID: 629 RVA: 0x00010CFC File Offset: 0x0000EEFC
	public void SpawnProjectilePredictNextPosition()
	{
		if (!LocalClient.serverOwner || this.mob.target == null)
		{
			return;
		}
		Rigidbody component = this.mob.target.GetComponent<Rigidbody>();
		Vector3 position = this.mob.target.position;
		Vector3 a = Vector3.zero;
		if (component)
		{
			a = VectorExtensions.XZVector(component.velocity);
		}
		float projectileSpeed = this.predictionProjectile.bowComponent.projectileSpeed;
		Vector3 position2 = this.predictionPos.position;
		float d = Vector3.Distance(position, position2) / projectileSpeed;
		Vector3 vector = position + a * d;
		Debug.DrawLine(position, vector, Color.black, 10f);
		Vector3 position3 = this.predictionPos.position;
		Vector3 vector2 = vector - position3;
		int id = this.predictionProjectile.id;
		int id2 = this.mob.id;
		float force = 0f;
		ServerSend.MobSpawnProjectile(position3, vector2, force, id, id2);
		ProjectileController.Instance.SpawnMobProjectile(position3, vector2, force, id, id2);
	}

	// Token: 0x06000276 RID: 630 RVA: 0x00010E0C File Offset: 0x0000F00C
	private Vector3 findLaunchVelocity(Vector3 targetPosition, GameObject newProjectile)
	{
		if (this.useLowestLaunchAngle)
		{
			Vector3 normalized = (targetPosition - newProjectile.transform.position).normalized;
			if (normalized.x > 1f)
			{
				normalized.x = 1f;
			}
			if (normalized.y > 1f)
			{
				normalized.y = 1f;
			}
			if (normalized.z > 1f)
			{
				normalized.z = 1f;
			}
			MonoBehaviour.print("y component: " + normalized.y);
			float num = Mathf.Asin(normalized.y);
			this.launchAngle = num + this.launchAngle;
			MonoBehaviour.print("launch angle: " + this.launchAngle);
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
		Vector3 vector2 = newProjectile.transform.TransformDirection(direction);
		if (float.IsNaN(vector2.x))
		{
			vector2 = (targetPosition - newProjectile.transform.position).normalized;
		}
		return vector2;
	}

	// Token: 0x0400027F RID: 639
	public InventoryItem projectile;

	// Token: 0x04000280 RID: 640
	public InventoryItem predictionProjectile;

	// Token: 0x04000281 RID: 641
	public Transform spawnPos;

	// Token: 0x04000282 RID: 642
	public Transform predictionPos;

	// Token: 0x04000283 RID: 643
	public float attackForce = 1000f;

	// Token: 0x04000284 RID: 644
	public float launchAngle = 40f;

	// Token: 0x04000285 RID: 645
	public bool useLowestLaunchAngle;

	// Token: 0x04000286 RID: 646
	public Vector3 angularVel;

	// Token: 0x04000287 RID: 647
	private Mob mob;
}
