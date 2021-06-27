using UnityEngine;
using UnityEngine.AI;

public class TestPlayerAnimations : MonoBehaviour
{
	public float hpRatio { get; set; } = 1f;

	private void Start()
	{
		this.grounded = true;
		InvokeRepeating(nameof(FindRandomPosition), 1f, 5f);
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	private void FindRandomPosition()
	{
		Vector3 b = new Vector3(Random.Range(-20f, 20f), 20f, Random.Range(-20f, 20f));
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + b, Vector3.down, out raycastHit, 70f, this.whatIsGround))
		{
			this.agent.destination = raycastHit.point;
			this.agent.isStopped = false;
		}
	}

	private void FixedUpdate()
	{
		this.animator.SetFloat("Speed", this.agent.speed);
	}

	private void Update()
	{
		if (Physics.Raycast(base.transform.position, Vector3.down, 2.4f, this.whatIsGround))
		{
			this.grounded = true;
		}
		else
		{
			this.grounded = false;
		}
		this.animator.SetFloat("FallSpeed", this.fallSpeed);
		this.Animate();
		this.Sfx();
		this.orientationX = -60f;
		this.upperBody.localRotation = Quaternion.Lerp(this.upperBody.localRotation, Quaternion.Euler(this.orientationX, this.upperBody.localRotation.y, this.upperBody.localRotation.z), Time.deltaTime * this.rotationSpeed);
	}

	private void LateUpdate()
	{
		this.fallSpeed = this.rb.velocity.y;
		MonoBehaviour.print("fallspeed: " + this.fallSpeed);
	}

	public void AttackAnimation()
	{
		this.animator.Play("Attack");
	}

	public void UpdateWeapon(int objectID)
	{
		if (objectID == -1)
		{
			this.filter.mesh = null;
			return;
		}
		InventoryItem inventoryItem = ItemManager.Instance.allItems[objectID];
		this.filter.mesh = inventoryItem.mesh;
		this.renderer.material = inventoryItem.material;
		this.animator.SetFloat("AnimationSpeed", inventoryItem.attackSpeed);
	}

	private void Sfx()
	{
		this.DistToPlayer();
	}

	private void Animate()
	{
		this.animator.SetBool("Grounded", this.grounded);
	}

	private float DistToPlayer()
	{
		return 1f;
	}

	public Animator animator;

	public Rigidbody rb;

	public Vector3 desiredPos;

	public float orientationY;

	public float orientationX;

	private float blendX;

	private float blendY;

	public bool grounded;

	public bool dashing;

	public LayerMask whatIsGround;

	public GameObject jumpSfx;

	public GameObject dashFx;

	private float moveSpeed = 15f;

	private float rotationSpeed = 13f;

	private float animationBlendSpeed = 8f;

	public GameObject weapon;

	private MeshFilter filter;

	private MeshRenderer renderer;

	public Transform hpBar;

	public Transform upperBody;

	public NavMeshAgent agent;

	private float fallSpeed;
}
