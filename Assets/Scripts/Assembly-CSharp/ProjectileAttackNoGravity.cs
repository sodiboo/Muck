using System;
using UnityEngine;


public class ProjectileAttackNoGravity : MonoBehaviour
{

	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}


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


	public InventoryItem projectile;


	public InventoryItem predictionProjectile;


	public Transform spawnPos;


	public Transform predictionPos;


	public float attackForce = 1000f;


	public float launchAngle = 40f;


	public bool useLowestLaunchAngle;


	public Vector3 angularVel;


	private Mob mob;
}
