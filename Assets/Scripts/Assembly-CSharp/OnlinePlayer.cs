
using UnityEngine;

// Token: 0x02000095 RID: 149
public class OnlinePlayer : MonoBehaviour
{
	// Token: 0x1700002E RID: 46
	// (get) Token: 0x0600046B RID: 1131 RVA: 0x000168FC File Offset: 0x00014AFC
	// (set) Token: 0x0600046C RID: 1132 RVA: 0x00016904 File Offset: 0x00014B04
	public float hpRatio { get; set; } = 1f;

	// Token: 0x0600046D RID: 1133 RVA: 0x0001690D File Offset: 0x00014B0D
	private void Start()
	{
		this.grounded = true;
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x0600046E RID: 1134 RVA: 0x00016938 File Offset: 0x00014B38
	private void FixedUpdate()
	{
		this.fallSpeed = Mathf.Abs(this.rb.velocity.y);
		Vector3 position = Vector3.Lerp(this.rb.position, this.desiredPos, Time.deltaTime * this.moveSpeed);
		this.rb.MovePosition(position);
	}

	// Token: 0x0600046F RID: 1135 RVA: 0x00016990 File Offset: 0x00014B90
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

	// Token: 0x06000470 RID: 1136 RVA: 0x00016A64 File Offset: 0x00014C64
	private void LateUpdate()
	{
		this.currentTorsoRotation = Mathf.Lerp(this.currentTorsoRotation, this.orientationX, Time.deltaTime * this.rotationSpeed);
		this.upperBody.localRotation = Quaternion.Euler(this.currentTorsoRotation, this.upperBody.localRotation.y, this.upperBody.localRotation.z);
		this.lastFallSpeed = this.rb.velocity.y;
	}

	// Token: 0x06000471 RID: 1137 RVA: 0x00016AE0 File Offset: 0x00014CE0
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
			Instantiate(this.footstepFx, base.transform.position, Quaternion.identity);
				this.distance = 0f;
			}
		}
	}

	// Token: 0x1700002F RID: 47
	// (get) Token: 0x06000472 RID: 1138 RVA: 0x00016B7B File Offset: 0x00014D7B
	// (set) Token: 0x06000473 RID: 1139 RVA: 0x00016B83 File Offset: 0x00014D83
	public int currentWeaponId { get; set; } = -1;

	// Token: 0x06000474 RID: 1140 RVA: 0x00016B8C File Offset: 0x00014D8C
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

	// Token: 0x06000475 RID: 1141 RVA: 0x00016BFA File Offset: 0x00014DFA
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x06000476 RID: 1142 RVA: 0x00016C09 File Offset: 0x00014E09
	public void SpawnSmoke()
	{
		if (this.DistToPlayer() > 30f)
		{
			return;
		}
	Instantiate(this.smokeFx, this.jumpSmokeFxPos.position, Quaternion.LookRotation(Vector3.up));
	}

	// Token: 0x06000477 RID: 1143 RVA: 0x00016C3C File Offset: 0x00014E3C
	private void Animate()
	{
		float b = Mathf.Clamp(this.rb.velocity.magnitude * 0.1f, 0f, 1f);
		this.speed = Mathf.Lerp(this.speed, b, Time.deltaTime * 10f);
		this.animator.SetBool("Grounded", this.grounded);
		this.animator.SetFloat("FallSpeed", this.lastFallSpeed);
		this.animator.SetFloat("Speed", this.speed);
	}

	// Token: 0x06000478 RID: 1144 RVA: 0x00016CD1 File Offset: 0x00014ED1
	private float DistToPlayer()
	{
		if (!PlayerMovement.Instance)
		{
			return 1000f;
		}
		return Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	// Token: 0x06000479 RID: 1145 RVA: 0x00016D04 File Offset: 0x00014F04
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

	// Token: 0x040003A4 RID: 932
	public Animator animator;

	// Token: 0x040003A5 RID: 933
	public Rigidbody rb;

	// Token: 0x040003A6 RID: 934
	public Vector3 desiredPos;

	// Token: 0x040003A7 RID: 935
	public float orientationY;

	// Token: 0x040003A8 RID: 936
	public float orientationX;

	// Token: 0x040003A9 RID: 937
	private float blendX;

	// Token: 0x040003AA RID: 938
	private float blendY;

	// Token: 0x040003AB RID: 939
	public bool grounded;

	// Token: 0x040003AC RID: 940
	public bool dashing;

	// Token: 0x040003AD RID: 941
	public LayerMask whatIsGround;

	// Token: 0x040003AE RID: 942
	public GameObject jumpSfx;

	// Token: 0x040003AF RID: 943
	public GameObject dashFx;

	// Token: 0x040003B0 RID: 944
	private float moveSpeed = 15f;

	// Token: 0x040003B1 RID: 945
	private float rotationSpeed = 13f;

	// Token: 0x040003B2 RID: 946
	private float animationBlendSpeed = 8f;

	// Token: 0x040003B3 RID: 947
	public GameObject weapon;

	// Token: 0x040003B4 RID: 948
	private MeshFilter filter;

	// Token: 0x040003B5 RID: 949
	private MeshRenderer renderer;

	// Token: 0x040003B6 RID: 950
	public Transform hpBar;

	// Token: 0x040003B8 RID: 952
	public Transform upperBody;

	// Token: 0x040003B9 RID: 953
	public SkinnedMeshRenderer[] armor;

	// Token: 0x040003BA RID: 954
	private float currentTorsoRotation;

	// Token: 0x040003BB RID: 955
	private float lastFallSpeed;

	// Token: 0x040003BC RID: 956
	public GameObject footstepFx;

	// Token: 0x040003BD RID: 957
	private float distance;

	// Token: 0x040003BE RID: 958
	private float fallSpeed;

	// Token: 0x040003C0 RID: 960
	public GameObject smokeFx;

	// Token: 0x040003C1 RID: 961
	public Transform jumpSmokeFxPos;

	// Token: 0x040003C2 RID: 962
	private float speed;

	// Token: 0x02000125 RID: 293
	public enum SharedAnimation
	{
		// Token: 0x0400079C RID: 1948
		Attack,
		// Token: 0x0400079D RID: 1949
		Eat,
		// Token: 0x0400079E RID: 1950
		Charge
	}
}
