using System;
using UnityEngine;

// Token: 0x020000C3 RID: 195
public class OnlinePlayer : MonoBehaviour
{
	// Token: 0x17000036 RID: 54
	// (get) Token: 0x060004E2 RID: 1250 RVA: 0x0000535F File Offset: 0x0000355F
	// (set) Token: 0x060004E3 RID: 1251 RVA: 0x00005367 File Offset: 0x00003567
	public float hpRatio { get; set; } = 1f;

	// Token: 0x060004E4 RID: 1252 RVA: 0x00005370 File Offset: 0x00003570
	private void Start()
	{
		this.grounded = true;
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x060004E5 RID: 1253 RVA: 0x0001AC08 File Offset: 0x00018E08
	private void FixedUpdate()
	{
		this.fallSpeed = Mathf.Abs(this.rb.velocity.y);
		Vector3 position = Vector3.Lerp(this.rb.position, this.desiredPos, Time.deltaTime * this.moveSpeed);
		this.rb.MovePosition(position);
	}

	// Token: 0x060004E6 RID: 1254 RVA: 0x0001AC60 File Offset: 0x00018E60
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

	// Token: 0x060004E7 RID: 1255 RVA: 0x0001AD34 File Offset: 0x00018F34
	private void LateUpdate()
	{
		this.currentTorsoRotation = Mathf.Lerp(this.currentTorsoRotation, this.orientationX, Time.deltaTime * this.rotationSpeed);
		this.upperBody.localRotation = Quaternion.Euler(this.currentTorsoRotation, this.upperBody.localRotation.y, this.upperBody.localRotation.z);
		this.lastFallSpeed = this.rb.velocity.y;
	}

	// Token: 0x060004E8 RID: 1256 RVA: 0x0001ADB0 File Offset: 0x00018FB0
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

	// Token: 0x17000037 RID: 55
	// (get) Token: 0x060004E9 RID: 1257 RVA: 0x0000539B File Offset: 0x0000359B
	// (set) Token: 0x060004EA RID: 1258 RVA: 0x000053A3 File Offset: 0x000035A3
	public int currentWeaponId { get; set; } = -1;

	// Token: 0x060004EB RID: 1259 RVA: 0x0001AE4C File Offset: 0x0001904C
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

	// Token: 0x060004EC RID: 1260 RVA: 0x000053AC File Offset: 0x000035AC
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x060004ED RID: 1261 RVA: 0x000053BB File Offset: 0x000035BB
	public void SpawnSmoke()
	{
		if (this.DistToPlayer() > 30f)
		{
			return;
		}
	Instantiate<GameObject>(this.smokeFx, this.jumpSmokeFxPos.position, Quaternion.LookRotation(Vector3.up));
	}

	// Token: 0x060004EE RID: 1262 RVA: 0x0001AEBC File Offset: 0x000190BC
	private void Animate()
	{
		float b = Mathf.Clamp(this.rb.velocity.magnitude * 0.1f, 0f, 1f);
		this.speed = Mathf.Lerp(this.speed, b, Time.deltaTime * 10f);
		this.animator.SetBool("Grounded", this.grounded);
		this.animator.SetFloat("FallSpeed", this.lastFallSpeed);
		this.animator.SetFloat("Speed", this.speed);
	}

	// Token: 0x060004EF RID: 1263 RVA: 0x000053EC File Offset: 0x000035EC
	private float DistToPlayer()
	{
		if (!PlayerMovement.Instance)
		{
			return 1000f;
		}
		return Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	// Token: 0x060004F0 RID: 1264 RVA: 0x0001AF54 File Offset: 0x00019154
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

	// Token: 0x04000471 RID: 1137
	public Animator animator;

	// Token: 0x04000472 RID: 1138
	public Rigidbody rb;

	// Token: 0x04000473 RID: 1139
	public Vector3 desiredPos;

	// Token: 0x04000474 RID: 1140
	public float orientationY;

	// Token: 0x04000475 RID: 1141
	public float orientationX;

	// Token: 0x04000476 RID: 1142
	private float blendX;

	// Token: 0x04000477 RID: 1143
	private float blendY;

	// Token: 0x04000478 RID: 1144
	public bool grounded;

	// Token: 0x04000479 RID: 1145
	public bool dashing;

	// Token: 0x0400047A RID: 1146
	public LayerMask whatIsGround;

	// Token: 0x0400047B RID: 1147
	public GameObject jumpSfx;

	// Token: 0x0400047C RID: 1148
	public GameObject dashFx;

	// Token: 0x0400047D RID: 1149
	private float moveSpeed = 15f;

	// Token: 0x0400047E RID: 1150
	private float rotationSpeed = 13f;

	// Token: 0x0400047F RID: 1151
	private float animationBlendSpeed = 8f;

	// Token: 0x04000480 RID: 1152
	public GameObject weapon;

	// Token: 0x04000481 RID: 1153
	private MeshFilter filter;

	// Token: 0x04000482 RID: 1154
	private MeshRenderer renderer;

	// Token: 0x04000483 RID: 1155
	public Transform hpBar;

	// Token: 0x04000485 RID: 1157
	public Transform upperBody;

	// Token: 0x04000486 RID: 1158
	public SkinnedMeshRenderer[] armor;

	// Token: 0x04000487 RID: 1159
	private float currentTorsoRotation;

	// Token: 0x04000488 RID: 1160
	private float lastFallSpeed;

	// Token: 0x04000489 RID: 1161
	public GameObject footstepFx;

	// Token: 0x0400048A RID: 1162
	private float distance;

	// Token: 0x0400048B RID: 1163
	private float fallSpeed;

	// Token: 0x0400048D RID: 1165
	public GameObject smokeFx;

	// Token: 0x0400048E RID: 1166
	public Transform jumpSmokeFxPos;

	// Token: 0x0400048F RID: 1167
	private float speed;

	// Token: 0x020000C4 RID: 196
	public enum SharedAnimation
	{
		// Token: 0x04000491 RID: 1169
		Attack,
		// Token: 0x04000492 RID: 1170
		Eat,
		// Token: 0x04000493 RID: 1171
		Charge
	}
}
