using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
	public GameObject playerJumpSmokeFx;
	public GameObject footstepFx;
	public Transform playerCam;
	public Transform orientation;
	public bool dead;
	public bool grounded;
	public LayerMask whatIsGround;
	public float extraGravity;
	public ParticleSystem ps;
	public GameObject playerSmokeFx;
	public LayerMask whatIsHittable;
}
