using UnityEngine;

public class ProjectileAttack : MonoBehaviour
{
	public GameObject projectile;
	public Transform spawnPos;
	public float launchAngle;
	public bool useLowestLaunchAngle;
	public Vector3 angularVel;
	public float disableColliderTime;
}
