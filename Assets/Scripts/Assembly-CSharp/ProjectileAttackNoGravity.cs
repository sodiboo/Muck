using UnityEngine;

public class ProjectileAttackNoGravity : MonoBehaviour
{
	public InventoryItem projectile;
	public InventoryItem predictionProjectile;
	public InventoryItem warningAttack;
	public Transform spawnPos;
	public Transform predictionPos;
	public float attackForce;
	public float launchAngle;
	public bool useLowestLaunchAngle;
	public Vector3 angularVel;
}
