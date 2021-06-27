using System;
using UnityEngine;

public class OnlinePlayer : MonoBehaviour
{
	public float hpRatio { get; set; } = 1f;

	private void Start()
	{
		this.grounded = true;
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	private void FixedUpdate()
	{
		this.fallSpeed = Mathf.Abs(this.rb.velocity.y);
		Vector3 position = Vector3.Lerp(this.rb.position, this.desiredPos, Time.deltaTime * this.moveSpeed);
		this.rb.MovePosition(position);
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
		this.Animate();
		this.Sfx();
		this.FootSteps();
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(0f, this.orientationY, 0f), Time.deltaTime * this.rotationSpeed);
		float x = Mathf.Lerp(this.hpBar.localScale.x, this.hpRatio, Time.deltaTime * 10f);
		this.hpBar.localScale = new Vector3(x, 1f, 1f);
	}

	private void LateUpdate()
	{
		this.currentTorsoRotation = Mathf.Lerp(this.currentTorsoRotation, this.orientationX, Time.deltaTime * this.rotationSpeed);
		this.upperBody.localRotation = Quaternion.Euler(this.currentTorsoRotation, this.upperBody.localRotation.y, this.upperBody.localRotation.z);
		this.lastFallSpeed = this.rb.velocity.y;
	}

	private void FootSteps()
	{
		if (this.DistToPlayer() > 30f)
		{
			return;
		}
		if (this.grounded)
		{
			float num = 1f;
			float num2 = this.rb.velocity.magnitude;
			if (num2 > 20f)
			{
				num2 = 20f;
			}
			this.distance += num2 * Time.deltaTime * 50f;
			if (this.distance > 300f / num)
			{
				Instantiate<GameObject>(this.footstepFx, base.transform.position, Quaternion.identity);
				this.distance = 0f;
			}
		}
	}

	public int currentWeaponId { get; set; } = -1;

	public void UpdateWeapon(int objectID)
	{
		this.currentWeaponId = objectID;
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

	public void SpawnSmoke()
	{
		if (this.DistToPlayer() > 30f)
		{
			return;
		}
		Instantiate<GameObject>(this.smokeFx, this.jumpSmokeFxPos.position, Quaternion.LookRotation(Vector3.up));
	}

	private void Animate()
	{
		float b = Mathf.Clamp(this.rb.velocity.magnitude * 0.1f, 0f, 1f);
		this.speed = Mathf.Lerp(this.speed, b, Time.deltaTime * 10f);
		this.animator.SetBool("Grounded", this.grounded);
		this.animator.SetFloat("FallSpeed", this.lastFallSpeed);
		this.animator.SetFloat("Speed", this.speed);
	}

	private float DistToPlayer()
	{
		if (!PlayerMovement.Instance)
		{
			return 1000f;
		}
		return Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	public void NewAnimation(int animation, bool b)
	{
		if (animation == 0)
		{
			this.animator.Play("Attack");
			return;
		}
		if (animation == 1)
		{
			this.animator.SetBool("Eating", b);
			return;
		}
		if (animation == 2)
		{
			this.animator.SetBool("Charging", b);
		}
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

	public SkinnedMeshRenderer[] armor;

	private float currentTorsoRotation;

	private float lastFallSpeed;

	public GameObject footstepFx;

	private float distance;

	private float fallSpeed;

	public GameObject smokeFx;

	public Transform jumpSmokeFxPos;

	private float speed;

	public enum SharedAnimation
	{
		Attack,
		Eat,
		Charge
	}
}
