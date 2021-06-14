using UnityEngine;
using UnityEngine.AI;

public class TestPlayerAnimations : MonoBehaviour
{
	public Animator animator;
	public Rigidbody rb;
	public Vector3 desiredPos;
	public float orientationY;
	public float orientationX;
	public bool grounded;
	public bool dashing;
	public LayerMask whatIsGround;
	public GameObject jumpSfx;
	public GameObject dashFx;
	public GameObject weapon;
	public Transform hpBar;
	public Transform upperBody;
	public NavMeshAgent agent;
}
