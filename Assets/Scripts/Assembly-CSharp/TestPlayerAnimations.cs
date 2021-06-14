using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000146 RID: 326
public class TestPlayerAnimations : MonoBehaviour
{
	// Token: 0x1700005B RID: 91
	// (get) Token: 0x060007D5 RID: 2005 RVA: 0x000071E7 File Offset: 0x000053E7
	// (set) Token: 0x060007D6 RID: 2006 RVA: 0x000071EF File Offset: 0x000053EF
	public float hpRatio { get; set; } = 1f;

	// Token: 0x060007D7 RID: 2007 RVA: 0x000071F8 File Offset: 0x000053F8
	private void Start()
	{
		this.grounded = true;
		base.InvokeRepeating(nameof(FindRandomPosition), 1f, 5f);
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x060007D8 RID: 2008 RVA: 0x00026CB8 File Offset: 0x00024EB8
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

	// Token: 0x060007D9 RID: 2009 RVA: 0x00007238 File Offset: 0x00005438
	private void FixedUpdate()
	{
		this.animator.SetFloat("Speed", this.agent.speed);
	}

	// Token: 0x060007DA RID: 2010 RVA: 0x00026D3C File Offset: 0x00024F3C
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

	// Token: 0x060007DB RID: 2011 RVA: 0x00007255 File Offset: 0x00005455
	private void LateUpdate()
	{
		this.fallSpeed = this.rb.velocity.y;
		MonoBehaviour.print("fallspeed: " + this.fallSpeed);
	}

	// Token: 0x060007DC RID: 2012 RVA: 0x00007287 File Offset: 0x00005487
	public void AttackAnimation()
	{
		this.animator.Play("Attack");
	}

	// Token: 0x060007DD RID: 2013 RVA: 0x00026E00 File Offset: 0x00025000
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

	// Token: 0x060007DE RID: 2014 RVA: 0x00007299 File Offset: 0x00005499
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x060007DF RID: 2015 RVA: 0x000072A8 File Offset: 0x000054A8
	private void Animate()
	{
		this.animator.SetBool("Grounded", this.grounded);
	}

	// Token: 0x060007E0 RID: 2016 RVA: 0x00004A23 File Offset: 0x00002C23
	private float DistToPlayer()
	{
		return 1f;
	}

	// Token: 0x0400080B RID: 2059
	public Animator animator;

	// Token: 0x0400080C RID: 2060
	public Rigidbody rb;

	// Token: 0x0400080D RID: 2061
	public Vector3 desiredPos;

	// Token: 0x0400080E RID: 2062
	public float orientationY;

	// Token: 0x0400080F RID: 2063
	public float orientationX;

	// Token: 0x04000810 RID: 2064
	private float blendX;

	// Token: 0x04000811 RID: 2065
	private float blendY;

	// Token: 0x04000812 RID: 2066
	public bool grounded;

	// Token: 0x04000813 RID: 2067
	public bool dashing;

	// Token: 0x04000814 RID: 2068
	public LayerMask whatIsGround;

	// Token: 0x04000815 RID: 2069
	public GameObject jumpSfx;

	// Token: 0x04000816 RID: 2070
	public GameObject dashFx;

	// Token: 0x04000817 RID: 2071
	private float moveSpeed = 15f;

	// Token: 0x04000818 RID: 2072
	private float rotationSpeed = 13f;

	// Token: 0x04000819 RID: 2073
	private float animationBlendSpeed = 8f;

	// Token: 0x0400081A RID: 2074
	public GameObject weapon;

	// Token: 0x0400081B RID: 2075
	private MeshFilter filter;

	// Token: 0x0400081C RID: 2076
	private MeshRenderer renderer;

	// Token: 0x0400081D RID: 2077
	public Transform hpBar;

	// Token: 0x0400081F RID: 2079
	public Transform upperBody;

	// Token: 0x04000820 RID: 2080
	public NavMeshAgent agent;

	// Token: 0x04000821 RID: 2081
	private float fallSpeed;
}
