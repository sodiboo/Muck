using System;
using UnityEngine;

public class ProjectileAttackNoGravity : MonoBehaviour
{
    public InventoryItem projectile;

    public InventoryItem predictionProjectile;

    public InventoryItem warningAttack;

    public Transform spawnPos;

    public Transform predictionPos;

    public float attackForce = 1000f;

    public float launchAngle = 40f;

    public bool useLowestLaunchAngle;

    public Vector3 angularVel;

    private Mob mob;

    private void Awake()
    {
        mob = GetComponent<Mob>();
    }

    private void SpawnProjectile()
    {
        if (LocalClient.serverOwner && !(mob.target == null))
        {
            Vector3 position = spawnPos.position;
            Vector3 normalized = (mob.target.position + Vector3.up * 1f - spawnPos.position).normalized;
            float force = projectile.bowComponent.projectileSpeed * attackForce;
            int id = projectile.id;
            int id2 = mob.id;
            ServerSend.MobSpawnProjectile(position, normalized, force, id, id2);
            ProjectileController.Instance.SpawnMobProjectile(position, normalized, force, id, id2);
        }
    }

    public void SpawnPredictedWarningAttack()
    {
        if (LocalClient.serverOwner && !(mob.target == null))
        {
            Rigidbody component = mob.target.GetComponent<Rigidbody>();
            Vector3 position = mob.target.position;
            Vector3 vector = Vector3.zero;
            if ((bool)component)
            {
                vector = VectorExtensions.XZVector(component.velocity);
            }
            float timeToImpact = warningAttack.bowComponent.timeToImpact;
            Vector3 vector2;
            Vector3 vector3 = (vector2 = position + vector * timeToImpact) - vector2;
            float force = 0f;
            int id = warningAttack.id;
            int id2 = mob.id;
            ServerSend.MobSpawnProjectile(vector2, vector3, force, id, id2);
            ProjectileController.Instance.SpawnMobProjectile(vector2, vector3, force, id, id2);
        }
    }

    public void SpawnProjectilePredictionTrajectory()
    {
        if (LocalClient.serverOwner && !(mob.target == null))
        {
            Vector3 position = mob.target.position;
            Rigidbody component = projectile.prefab.GetComponent<Rigidbody>();
            Vector3 vector = findLaunchVelocity(position, spawnPos.gameObject);
            float mass = component.mass;
            float fixedDeltaTime = Time.fixedDeltaTime;
            float magnitude = vector.magnitude;
            Vector3 position2 = spawnPos.position;
            Vector3 normalized = vector.normalized;
            float force = mass * (magnitude / fixedDeltaTime);
            int id = projectile.id;
            int id2 = mob.id;
            ServerSend.MobSpawnProjectile(position2, normalized, force, id, id2);
            ProjectileController.Instance.SpawnMobProjectile(position2, normalized, force, id, id2);
        }
    }

    public void SpawnProjectilePredictNextPosition()
    {
        if (LocalClient.serverOwner && !(mob.target == null))
        {
            Rigidbody component = mob.target.GetComponent<Rigidbody>();
            Vector3 position = mob.target.position;
            Vector3 vector = Vector3.zero;
            if ((bool)component)
            {
                vector = VectorExtensions.XZVector(component.velocity);
            }
            float projectileSpeed = predictionProjectile.bowComponent.projectileSpeed;
            Vector3 position2 = predictionPos.position;
            float num = Vector3.Distance(position, position2) / projectileSpeed;
            Vector3 vector2 = position + vector * num;
            Vector3 position3 = predictionPos.position;
            Vector3 vector3 = vector2 - position3;
            float num2 = 1000f;
            int id = predictionProjectile.id;
            int id2 = mob.id;
            num2 = 0f;
            ServerSend.MobSpawnProjectile(position3, vector3, num2, id, id2);
            ProjectileController.Instance.SpawnMobProjectile(position3, vector3, num2, id, id2);
        }
    }

    private Vector3 findLaunchVelocity(Vector3 targetPosition, GameObject newProjectile)
    {
        if (useLowestLaunchAngle)
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
            launchAngle = num + launchAngle;
            MonoBehaviour.print("launch angle: " + launchAngle);
        }
        Vector3 a = new Vector3(spawnPos.position.x, spawnPos.position.y, spawnPos.position.z);
        Vector3 vector = new Vector3(targetPosition.x, spawnPos.position.y, targetPosition.z);
        float num2 = Vector3.Distance(a, vector);
        newProjectile.transform.LookAt(vector);
        float y = Physics.gravity.y;
        float num3 = Mathf.Tan(launchAngle * ((float)Math.PI / 180f));
        float num4 = targetPosition.y - spawnPos.position.y;
        float num5 = Mathf.Sqrt(y * num2 * num2 / (2f * (num4 - num2 * num3)));
        float y2 = num3 * num5;
        Vector3 direction = new Vector3(0f, y2, num5);
        Vector3 result = newProjectile.transform.TransformDirection(direction);
        if (float.IsNaN(result.x))
        {
            result = (targetPosition - newProjectile.transform.position).normalized;
        }
        return result;
    }
}
