using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000121 RID: 289
public class TestPlayerAnimations : MonoBehaviour
{
	// Token: 0x17000062 RID: 98
	// (get) Token: 0x0600085B RID: 2139 RVA: 0x0002A048 File Offset: 0x00028248
	// (set) Token: 0x0600085C RID: 2140 RVA: 0x0002A050 File Offset: 0x00028250
	public float hpRatio { get; set; } = 1f;

	// Token: 0x0600085D RID: 2141 RVA: 0x0002A059 File Offset: 0x00028259
	private void Start()
	{
		this.grounded = true;
		InvokeRepeating(nameof(FindRandomPosition), 1f, 5f);
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x0600085E RID: 2142 RVA: 0x0002A09C File Offset: 0x0002829C
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

	// Token: 0x0600085F RID: 2143 RVA: 0x0002A120 File Offset: 0x00028320
	private void FixedUpdate()
	{
		this.animator.SetFloat("Speed", this.agent.speed);
	}

	// Token: 0x06000860 RID: 2144 RVA: 0x0002A140 File Offset: 0x00028340
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

	// Token: 0x06000861 RID: 2145 RVA: 0x0002A203 File Offset: 0x00028403
	private void LateUpdate()
	{
		this.fallSpeed = this.rb.velocity.y;
		MonoBehaviour.print("fallspeed: " + this.fallSpeed);
	}

	// Token: 0x06000862 RID: 2146 RVA: 0x0002A235 File Offset: 0x00028435
	public void AttackAnimation()
	{
		this.animator.Play("Attack");
	}

	// Token: 0x06000863 RID: 2147 RVA: 0x0002A248 File Offset: 0x00028448
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

	// Token: 0x06000864 RID: 2148 RVA: 0x0002A2AF File Offset: 0x000284AF
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x06000865 RID: 2149 RVA: 0x0002A2BE File Offset: 0x000284BE
	private void Animate()
	{
		this.animator.SetBool("Grounded", this.grounded);
	}

	// Token: 0x06000866 RID: 2150 RVA: 0x0001670F File Offset: 0x0001490F
	private float DistToPlayer()
	{
		return 1f;
	}

	// Token: 0x040007EA RID: 2026
	public Animator animator;

	// Token: 0x040007EB RID: 2027
	public Rigidbody rb;

	// Token: 0x040007EC RID: 2028
	public Vector3 desiredPos;

	// Token: 0x040007ED RID: 2029
	public float orientationY;

	// Token: 0x040007EE RID: 2030
	public float orientationX;

	// Token: 0x040007EF RID: 2031
	private float blendX;

	// Token: 0x040007F0 RID: 2032
	private float blendY;

	// Token: 0x040007F1 RID: 2033
	public bool grounded;

	// Token: 0x040007F2 RID: 2034
	public bool dashing;

	// Token: 0x040007F3 RID: 2035
	public LayerMask whatIsGround;

	// Token: 0x040007F4 RID: 2036
	public GameObject jumpSfx;

	// Token: 0x040007F5 RID: 2037
	public GameObject dashFx;

	// Token: 0x040007F6 RID: 2038
	private float moveSpeed = 15f;

	// Token: 0x040007F7 RID: 2039
	private float rotationSpeed = 13f;

	// Token: 0x040007F8 RID: 2040
	private float animationBlendSpeed = 8f;

	// Token: 0x040007F9 RID: 2041
	public GameObject weapon;

	// Token: 0x040007FA RID: 2042
	private MeshFilter filter;

	// Token: 0x040007FB RID: 2043
	private MeshRenderer renderer;

	// Token: 0x040007FC RID: 2044
	public Transform hpBar;

	// Token: 0x040007FE RID: 2046
	public Transform upperBody;

	// Token: 0x040007FF RID: 2047
	public NavMeshAgent agent;

	// Token: 0x04000800 RID: 2048
	private float fallSpeed;
}
