using UnityEngine;
using UnityEngine.AI;

public class JumpAttack : MonoBehaviour
{
	public RotateWhenRangedAttack rangedRotation;
	public NavMeshAgent agent;
	public Mob mob;
	public GameObject warningPrefab;
	public GameObject jumpFx;
	public GameObject landingFx;
	public float jumpTime;
	public Transform raycastPos;
	public LayerMask whatIsHittable;
	public LayerMask whatIsGroundOnly;
}
