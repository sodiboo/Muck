
using UnityEngine;
using UnityEngine.AI;

// Token: 0x020000F2 RID: 242
public class TestPlayerAnimations : MonoBehaviour
{
	// Token: 0x17000052 RID: 82
	// (get) Token: 0x06000719 RID: 1817 RVA: 0x00023770 File Offset: 0x00021970
	// (set) Token: 0x0600071A RID: 1818 RVA: 0x00023778 File Offset: 0x00021978
	public float hpRatio { get; set; } = 1f;

	// Token: 0x0600071B RID: 1819 RVA: 0x00023781 File Offset: 0x00021981
	private void Start()
	{
		this.grounded = true;
		base.InvokeRepeating("FindRandomPosition", 1f, 5f);
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x0600071C RID: 1820 RVA: 0x000237C4 File Offset: 0x000219C4
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

	// Token: 0x0600071D RID: 1821 RVA: 0x00023848 File Offset: 0x00021A48
	private void FixedUpdate()
	{
		this.animator.SetFloat("Speed", this.agent.speed);
	}

	// Token: 0x0600071E RID: 1822 RVA: 0x00023868 File Offset: 0x00021A68
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

	// Token: 0x0600071F RID: 1823 RVA: 0x0002392B File Offset: 0x00021B2B
	private void LateUpdate()
	{
		this.fallSpeed = this.rb.velocity.y;
		MonoBehaviour.print("fallspeed: " + this.fallSpeed);
	}

	// Token: 0x06000720 RID: 1824 RVA: 0x0002395D File Offset: 0x00021B5D
	public void AttackAnimation()
	{
		this.animator.Play("Attack");
	}

	// Token: 0x06000721 RID: 1825 RVA: 0x00023970 File Offset: 0x00021B70
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

	// Token: 0x06000722 RID: 1826 RVA: 0x000239D7 File Offset: 0x00021BD7
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x06000723 RID: 1827 RVA: 0x000239E6 File Offset: 0x00021BE6
	private void Animate()
	{
		this.animator.SetBool("Grounded", this.grounded);
	}

	// Token: 0x06000724 RID: 1828 RVA: 0x00011AAB File Offset: 0x0000FCAB
	private float DistToPlayer()
	{
		return 1f;
	}

	// Token: 0x040006A5 RID: 1701
	public Animator animator;

	// Token: 0x040006A6 RID: 1702
	public Rigidbody rb;

	// Token: 0x040006A7 RID: 1703
	public Vector3 desiredPos;

	// Token: 0x040006A8 RID: 1704
	public float orientationY;

	// Token: 0x040006A9 RID: 1705
	public float orientationX;

	// Token: 0x040006AA RID: 1706
	private float blendX;

	// Token: 0x040006AB RID: 1707
	private float blendY;

	// Token: 0x040006AC RID: 1708
	public bool grounded;

	// Token: 0x040006AD RID: 1709
	public bool dashing;

	// Token: 0x040006AE RID: 1710
	public LayerMask whatIsGround;

	// Token: 0x040006AF RID: 1711
	public GameObject jumpSfx;

	// Token: 0x040006B0 RID: 1712
	public GameObject dashFx;

	// Token: 0x040006B1 RID: 1713
	private float moveSpeed = 15f;

	// Token: 0x040006B2 RID: 1714
	private float rotationSpeed = 13f;

	// Token: 0x040006B3 RID: 1715
	private float animationBlendSpeed = 8f;

	// Token: 0x040006B4 RID: 1716
	public GameObject weapon;

	// Token: 0x040006B5 RID: 1717
	private MeshFilter filter;

	// Token: 0x040006B6 RID: 1718
	private MeshRenderer renderer;

	// Token: 0x040006B7 RID: 1719
	public Transform hpBar;

	// Token: 0x040006B9 RID: 1721
	public Transform upperBody;

	// Token: 0x040006BA RID: 1722
	public NavMeshAgent agent;

	// Token: 0x040006BB RID: 1723
	private float fallSpeed;
}
