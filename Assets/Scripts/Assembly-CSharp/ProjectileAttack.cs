using System;
using UnityEngine;

public class ProjectileAttack : MonoBehaviour
{
    public GameObject projectile;

    public Transform spawnPos;

    public float launchAngle = 40f;

    public bool useLowestLaunchAngle;

    public Vector3 angularVel;

    public float disableColliderTime;

    public void SpawnProjectile()
    {
        Vector3 position = GetComponent<Mob>().target.position;
        GameObject gameObject = UnityEngine.Object.Instantiate(projectile, spawnPos.position, Quaternion.identity);
        Rigidbody component = gameObject.GetComponent<Rigidbody>();
        Vector3 vector = findLaunchVelocity(position, gameObject);
        float mass = component.mass;
        float fixedDeltaTime = Time.fixedDeltaTime;
        float magnitude = vector.magnitude;
        component.AddForce(mass * (magnitude / fixedDeltaTime) * vector.normalized);
        component.angularVelocity = angularVel;
    }

    private Vector3 findLaunchVelocity(Vector3 targetPosition, GameObject newProjectile)
    {
        if (useLowestLaunchAngle)
        {
            Quaternion quaternion = Quaternion.LookRotation(targetPosition - spawnPos.position);
            float x = quaternion.eulerAngles.x;
            MonoBehaviour.print("raw ang: " + x);
            x = ((!(x < 180f)) ? (360f - x) : (0f - x));
            MonoBehaviour.print("ang: " + (360f - quaternion.eulerAngles.x));
            launchAngle = x + launchAngle;
        }
        Vector3 a = new Vector3(spawnPos.position.x, spawnPos.position.y, spawnPos.position.z);
        Vector3 vector = new Vector3(targetPosition.x, spawnPos.position.y, targetPosition.z);
        float num = Vector3.Distance(a, vector);
        newProjectile.transform.LookAt(vector);
        float y = Physics.gravity.y;
        float num2 = Mathf.Tan(launchAngle * ((float)Math.PI / 180f));
        float num3 = targetPosition.y - spawnPos.position.y;
        float num4 = Mathf.Sqrt(y * num * num / (2f * (num3 - num * num2)));
        float y2 = num2 * num4;
        Vector3 direction = new Vector3(0f, y2, num4);
        return newProjectile.transform.TransformDirection(direction);
    }
}
