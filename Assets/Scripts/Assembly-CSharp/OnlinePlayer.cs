using System;
using UnityEngine;

// Token: 0x020000BC RID: 188
public class OnlinePlayer : MonoBehaviour
{
	// Token: 0x1700003A RID: 58
	// (get) Token: 0x06000568 RID: 1384 RVA: 0x0001C00C File Offset: 0x0001A20C
	// (set) Token: 0x06000569 RID: 1385 RVA: 0x0001C014 File Offset: 0x0001A214
	public float hpRatio { get; set; } = 1f;

	// Token: 0x0600056A RID: 1386 RVA: 0x0001C01D File Offset: 0x0001A21D
	private void Start()
	{
		this.grounded = true;
		this.filter = this.weapon.GetComponent<MeshFilter>();
		this.renderer = this.weapon.GetComponent<MeshRenderer>();
	}

	// Token: 0x0600056B RID: 1387 RVA: 0x0001C048 File Offset: 0x0001A248
	private void FixedUpdate()
	{
		this.fallSpeed = Mathf.Abs(this.rb.velocity.y);
		Vector3 position = Vector3.Lerp(this.rb.position, this.desiredPos, Time.deltaTime * this.moveSpeed);
		this.rb.MovePosition(position);
	}

	// Token: 0x0600056C RID: 1388 RVA: 0x0001C0A0 File Offset: 0x0001A2A0
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

	// Token: 0x0600056D RID: 1389 RVA: 0x0001C174 File Offset: 0x0001A374
	private void LateUpdate()
	{
		this.currentTorsoRotation = Mathf.Lerp(this.currentTorsoRotation, this.orientationX, Time.deltaTime * this.rotationSpeed);
		this.upperBody.localRotation = Quaternion.Euler(this.currentTorsoRotation, this.upperBody.localRotation.y, this.upperBody.localRotation.z);
		this.lastFallSpeed = this.rb.velocity.y;
	}

	// Token: 0x0600056E RID: 1390 RVA: 0x0001C1F0 File Offset: 0x0001A3F0
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

	// Token: 0x1700003B RID: 59
	// (get) Token: 0x0600056F RID: 1391 RVA: 0x0001C28B File Offset: 0x0001A48B
	// (set) Token: 0x06000570 RID: 1392 RVA: 0x0001C293 File Offset: 0x0001A493
	public int currentWeaponId { get; set; } = -1;

	// Token: 0x06000571 RID: 1393 RVA: 0x0001C29C File Offset: 0x0001A49C
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

	// Token: 0x06000572 RID: 1394 RVA: 0x0001C30A File Offset: 0x0001A50A
	private void Sfx()
	{
		this.DistToPlayer();
	}

	// Token: 0x06000573 RID: 1395 RVA: 0x0001C319 File Offset: 0x0001A519
	public void SpawnSmoke()
	{
		if (this.DistToPlayer() > 30f)
		{
			return;
		}
		Instantiate<GameObject>(this.smokeFx, this.jumpSmokeFxPos.position, Quaternion.LookRotation(Vector3.up));
	}

	// Token: 0x06000574 RID: 1396 RVA: 0x0001C34C File Offset: 0x0001A54C
	private void Animate()
	{
		float b = Mathf.Clamp(this.rb.velocity.magnitude * 0.1f, 0f, 1f);
		this.speed = Mathf.Lerp(this.speed, b, Time.deltaTime * 10f);
		this.animator.SetBool("Grounded", this.grounded);
		this.animator.SetFloat("FallSpeed", this.lastFallSpeed);
		this.animator.SetFloat("Speed", this.speed);
	}

	// Token: 0x06000575 RID: 1397 RVA: 0x0001C3E1 File Offset: 0x0001A5E1
	private float DistToPlayer()
	{
		if (!PlayerMovement.Instance)
		{
			return 1000f;
		}
		return Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	// Token: 0x06000576 RID: 1398 RVA: 0x0001C414 File Offset: 0x0001A614
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

	// Token: 0x040004B3 RID: 1203
	public Animator animator;

	// Token: 0x040004B4 RID: 1204
	public Rigidbody rb;

	// Token: 0x040004B5 RID: 1205
	public Vector3 desiredPos;

	// Token: 0x040004B6 RID: 1206
	public float orientationY;

	// Token: 0x040004B7 RID: 1207
	public float orientationX;

	// Token: 0x040004B8 RID: 1208
	private float blendX;

	// Token: 0x040004B9 RID: 1209
	private float blendY;

	// Token: 0x040004BA RID: 1210
	public bool grounded;

	// Token: 0x040004BB RID: 1211
	public bool dashing;

	// Token: 0x040004BC RID: 1212
	public LayerMask whatIsGround;

	// Token: 0x040004BD RID: 1213
	public GameObject jumpSfx;

	// Token: 0x040004BE RID: 1214
	public GameObject dashFx;

	// Token: 0x040004BF RID: 1215
	private float moveSpeed = 15f;

	// Token: 0x040004C0 RID: 1216
	private float rotationSpeed = 13f;

	// Token: 0x040004C1 RID: 1217
	private float animationBlendSpeed = 8f;

	// Token: 0x040004C2 RID: 1218
	public GameObject weapon;

	// Token: 0x040004C3 RID: 1219
	private MeshFilter filter;

	// Token: 0x040004C4 RID: 1220
	private MeshRenderer renderer;

	// Token: 0x040004C5 RID: 1221
	public Transform hpBar;

	// Token: 0x040004C7 RID: 1223
	public Transform upperBody;

	// Token: 0x040004C8 RID: 1224
	public SkinnedMeshRenderer[] armor;

	// Token: 0x040004C9 RID: 1225
	private float currentTorsoRotation;

	// Token: 0x040004CA RID: 1226
	private float lastFallSpeed;

	// Token: 0x040004CB RID: 1227
	public GameObject footstepFx;

	// Token: 0x040004CC RID: 1228
	private float distance;

	// Token: 0x040004CD RID: 1229
	private float fallSpeed;

	// Token: 0x040004CF RID: 1231
	public GameObject smokeFx;

	// Token: 0x040004D0 RID: 1232
	public Transform jumpSmokeFxPos;

	// Token: 0x040004D1 RID: 1233
	private float speed;

	// Token: 0x02000162 RID: 354
	public enum SharedAnimation
	{
		// Token: 0x04000915 RID: 2325
		Attack,
		// Token: 0x04000916 RID: 2326
		Eat,
		// Token: 0x04000917 RID: 2327
		Charge
	}
}
