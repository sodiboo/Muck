using System;
using UnityEngine;

// Token: 0x020000B2 RID: 178
public class PlayerMovement : MonoBehaviour
{
	// Token: 0x1700003F RID: 63
	// (get) Token: 0x060005A4 RID: 1444 RVA: 0x0001CC6C File Offset: 0x0001AE6C
	// (set) Token: 0x060005A5 RID: 1445 RVA: 0x0001CC74 File Offset: 0x0001AE74
	public bool sprinting { get; private set; }

	// Token: 0x17000040 RID: 64
	// (get) Token: 0x060005A6 RID: 1446 RVA: 0x0001CC7D File Offset: 0x0001AE7D
	// (set) Token: 0x060005A7 RID: 1447 RVA: 0x0001CC84 File Offset: 0x0001AE84
	public static PlayerMovement Instance { get; private set; }

	// Token: 0x060005A8 RID: 1448 RVA: 0x0001CC8C File Offset: 0x0001AE8C
	private void Awake()
	{
		PlayerMovement.Instance = this;
		this.rb = base.GetComponent<Rigidbody>();
		this.playerStatus = base.GetComponent<PlayerStatus>();
	}

	// Token: 0x060005A9 RID: 1449 RVA: 0x0001CCAC File Offset: 0x0001AEAC
	private void Start()
	{
		this.playerScale = base.transform.localScale;
		this.playerCollider = base.GetComponent<Collider>();
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x060005AA RID: 1450 RVA: 0x0001CCD7 File Offset: 0x0001AED7
	private void Update()
	{
		if (this.dead)
		{
			return;
		}
		this.FootSteps();
		this.fallSpeed = this.rb.velocity.y;
	}

	// Token: 0x060005AB RID: 1451 RVA: 0x0001CCFE File Offset: 0x0001AEFE
	public void SetInput(Vector2 dir, bool crouching, bool jumping, bool sprinting)
	{
		this.x = dir.x;
		this.y = dir.y;
		this.crouching = crouching;
		this.jumping = jumping;
		this.sprinting = sprinting;
	}

	// Token: 0x060005AC RID: 1452 RVA: 0x0001CD30 File Offset: 0x0001AF30
	private void CheckInput()
	{
		if (this.crouching && !this.sliding)
		{
			this.StartCrouch();
		}
		if (!this.crouching && this.sliding)
		{
			this.StopCrouch();
		}
		if (this.sprinting && this.playerStatus.CanRun())
		{
			this.maxSpeed = this.maxRunSpeed;
			return;
		}
		this.maxSpeed = this.maxWalkSpeed;
	}

	// Token: 0x060005AD RID: 1453 RVA: 0x0001CD98 File Offset: 0x0001AF98
	public void StartCrouch()
	{
		if (this.sliding)
		{
			return;
		}
		this.sliding = true;
		base.transform.localScale = this.crouchScale;
		base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y - 0.65f, base.transform.position.z);
		if (this.rb.velocity.magnitude > 0.5f && this.grounded)
		{
			this.rb.AddForce(this.orientation.transform.forward * this.slideForce);
		}
	}

	// Token: 0x060005AE RID: 1454 RVA: 0x0001CE54 File Offset: 0x0001B054
	public void StopCrouch()
	{
		this.sliding = false;
		base.transform.localScale = this.playerScale;
		base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 0.65f, base.transform.position.z);
	}

	// Token: 0x060005AF RID: 1455 RVA: 0x0001CEC0 File Offset: 0x0001B0C0
	private void FootSteps()
	{
		if (this.crouching || this.dead)
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

	// Token: 0x060005B0 RID: 1456 RVA: 0x0001CF60 File Offset: 0x0001B160
	public void Movement(float x, float y)
	{
		this.UpdateCollisionChecks();
		this.x = x;
		this.y = y;
		if (this.dead)
		{
			return;
		}
		this.CheckInput();
		if (WorldUtility.WorldHeightToBiome(base.transform.position.y + 1.6f) == TextureData.TerrainType.Water)
		{
			this.maxSpeed *= 0.4f;
		}
		if (!this.grounded)
		{
			this.rb.AddForce(Vector3.down * this.extraGravity);
		}
		Vector2 vector = this.FindVelRelativeToLook();
		float num = vector.x;
		float num2 = vector.y;
		this.CounterMovement(x, y, vector);
		this.RampMovement(vector);
		if (this.readyToJump && this.jumping && this.grounded)
		{
			this.Jump();
		}
		if (this.crouching && this.grounded && this.readyToJump)
		{
			this.rb.AddForce(Vector3.down * 60f);
			return;
		}
		float num3 = x;
		float num4 = y;
		float num5 = this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
		if (x > 0f && num > num5)
		{
			num3 = 0f;
		}
		if (x < 0f && num < -num5)
		{
			num3 = 0f;
		}
		if (y > 0f && num2 > num5)
		{
			num4 = 0f;
		}
		if (y < 0f && num2 < -num5)
		{
			num4 = 0f;
		}
		float d = 1f;
		float d2 = 1f;
		if (!this.grounded)
		{
			d = 0.2f;
			d2 = 0.2f;
			if (this.IsHoldingAgainstVerticalVel(vector))
			{
				float num6 = Mathf.Abs(vector.y * 0.025f);
				if (num6 < 0.5f)
				{
					num6 = 0.5f;
				}
				d2 = Mathf.Abs(num6);
			}
		}
		if (this.grounded && this.crouching)
		{
			d2 = 0f;
		}
		if (this.surfing)
		{
			d = 0.6f;
			d2 = 0.3f;
		}
		float d3 = 0.01f;
		this.rb.AddForce(this.orientation.forward * num4 * this.moveSpeed * 0.02f * d2);
		this.rb.AddForce(this.orientation.right * num3 * this.moveSpeed * 0.02f * d);
		if (!this.grounded)
		{
			if (num3 != 0f)
			{
				this.rb.AddForce(-this.orientation.forward * vector.y * this.moveSpeed * 0.02f * d3);
			}
			if (num4 != 0f)
			{
				this.rb.AddForce(-this.orientation.right * vector.x * this.moveSpeed * 0.02f * d3);
			}
		}
		if (!this.readyToJump)
		{
			this.resetJumpCounter++;
			if (this.resetJumpCounter >= this.jumpCounterResetTime)
			{
				this.ResetJump();
			}
		}
	}

	// Token: 0x060005B1 RID: 1457 RVA: 0x0001D28C File Offset: 0x0001B48C
	private void RampMovement(Vector2 mag)
	{
		if (this.grounded && this.onRamp && !this.surfing && !this.crouching && !this.jumping && this.resetJumpCounter >= this.jumpCounterResetTime && Math.Abs(this.x) < 0.05f && Math.Abs(this.y) < 0.05f)
		{
			this.rb.useGravity = false;
			if (this.rb.velocity.y > 0f)
			{
				this.rb.velocity = new Vector3(this.rb.velocity.x, 0f, this.rb.velocity.z);
				return;
			}
			if (this.rb.velocity.y <= 0f && Math.Abs(mag.magnitude) < 1f)
			{
				this.rb.velocity = Vector3.zero;
				return;
			}
		}
		else
		{
			this.rb.useGravity = true;
		}
	}

	// Token: 0x060005B2 RID: 1458 RVA: 0x0001D3AB File Offset: 0x0001B5AB
	private void ResetJump()
	{
		this.readyToJump = true;
		base.CancelInvoke("JumpCooldown");
	}

	// Token: 0x060005B3 RID: 1459 RVA: 0x0001D3C0 File Offset: 0x0001B5C0
	public void Jump()
	{
		if ((this.grounded || this.surfing || (!this.grounded && this.jumps > 0)) && this.readyToJump && this.playerStatus.CanJump())
		{
			if (this.grounded)
			{
				this.jumps = PowerupInventory.Instance.GetExtraJumps(null);
			}
			this.rb.isKinematic = false;
			if (!this.grounded)
			{
				this.jumps--;
			}
			this.readyToJump = false;
			base.CancelInvoke("JumpCooldown");
			base.Invoke("JumpCooldown", 0.25f);
			this.resetJumpCounter = 0;
			float d = this.jumpForce * PowerupInventory.Instance.GetJumpMultiplier(null);
			this.rb.AddForce(Vector3.up * d * 1.5f, ForceMode.Impulse);
			this.rb.AddForce(this.normalVector * d * 0.5f, ForceMode.Impulse);
			Vector3 velocity = this.rb.velocity;
			if (this.rb.velocity.y < 0.5f)
			{
				this.rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
			}
			else if (this.rb.velocity.y > 0f)
			{
				this.rb.velocity = new Vector3(velocity.x, 0f, velocity.z);
			}
			ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = Instantiate<GameObject>(this.playerJumpSmokeFx, base.transform.position, Quaternion.LookRotation(Vector3.up)).GetComponent<ParticleSystem>().velocityOverLifetime;
			velocityOverLifetime.x = this.rb.velocity.x * 2f;
			velocityOverLifetime.z = this.rb.velocity.z * 2f;
			this.playerStatus.Jump();
		}
	}

	// Token: 0x060005B4 RID: 1460 RVA: 0x0001D5C1 File Offset: 0x0001B7C1
	private void JumpCooldown()
	{
		this.readyToJump = true;
	}

	// Token: 0x060005B5 RID: 1461 RVA: 0x0001D5CC File Offset: 0x0001B7CC
	private void CounterMovement(float x, float y, Vector2 mag)
	{
		if (x == 0f && y == 0f && this.rb.velocity.magnitude < 1f && this.grounded && !this.jumping && this.playerStatus.CanJump())
		{
			this.rb.isKinematic = true;
		}
		else
		{
			this.rb.isKinematic = false;
		}
		if (!this.grounded || (this.jumping && this.playerStatus.CanJump()))
		{
			return;
		}
		if (this.crouching)
		{
			this.rb.AddForce(this.moveSpeed * 0.02f * -this.rb.velocity.normalized * this.slideCounterMovement);
			return;
		}
		if (Math.Abs(mag.x) > this.threshold && Math.Abs(x) < 0.05f && this.readyToCounterX > 1)
		{
			this.rb.AddForce(this.moveSpeed * this.orientation.transform.right * 0.02f * -mag.x * this.counterMovement);
		}
		if (Math.Abs(mag.y) > this.threshold && Math.Abs(y) < 0.05f && this.readyToCounterY > 1)
		{
			this.rb.AddForce(this.moveSpeed * this.orientation.transform.forward * 0.02f * -mag.y * this.counterMovement);
		}
		if (this.IsHoldingAgainstHorizontalVel(mag))
		{
			this.rb.AddForce(this.moveSpeed * this.orientation.transform.right * 0.02f * -mag.x * this.counterMovement * 2f);
		}
		if (this.IsHoldingAgainstVerticalVel(mag))
		{
			this.rb.AddForce(this.moveSpeed * this.orientation.transform.forward * 0.02f * -mag.y * this.counterMovement * 2f);
		}
		if (Mathf.Sqrt(Mathf.Pow(this.rb.velocity.x, 2f) + Mathf.Pow(this.rb.velocity.z, 2f)) > this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null))
		{
			float num = this.rb.velocity.y;
			Vector3 vector = this.rb.velocity.normalized * this.maxSpeed * PowerupInventory.Instance.GetSpeedMultiplier(null);
			this.rb.velocity = new Vector3(vector.x, num, vector.z);
		}
		if (Math.Abs(x) < 0.05f)
		{
			this.readyToCounterX++;
		}
		else
		{
			this.readyToCounterX = 0;
		}
		if (Math.Abs(y) < 0.05f)
		{
			this.readyToCounterY++;
			return;
		}
		this.readyToCounterY = 0;
	}

	// Token: 0x060005B6 RID: 1462 RVA: 0x0001D926 File Offset: 0x0001BB26
	private bool IsHoldingAgainstHorizontalVel(Vector2 vel)
	{
		return (vel.x < -this.threshold && this.x > 0f) || (vel.x > this.threshold && this.x < 0f);
	}

	// Token: 0x060005B7 RID: 1463 RVA: 0x0001D963 File Offset: 0x0001BB63
	private bool IsHoldingAgainstVerticalVel(Vector2 vel)
	{
		return (vel.y < -this.threshold && this.y > 0f) || (vel.y > this.threshold && this.y < 0f);
	}

	// Token: 0x060005B8 RID: 1464 RVA: 0x0001D9A0 File Offset: 0x0001BBA0
	public Vector2 FindVelRelativeToLook()
	{
		float current = this.orientation.transform.eulerAngles.y;
		float target = Mathf.Atan2(this.rb.velocity.x, this.rb.velocity.z) * 57.29578f;
		float num = Mathf.DeltaAngle(current, target);
		float num2 = 90f - num;
		float magnitude = new Vector2(this.rb.velocity.x, this.rb.velocity.z).magnitude;
		float num3 = magnitude * Mathf.Cos(num * 0.017453292f);
		return new Vector2(magnitude * Mathf.Cos(num2 * 0.017453292f), num3);
	}

	// Token: 0x060005B9 RID: 1465 RVA: 0x0001DA4D File Offset: 0x0001BC4D
	private bool IsFloor(Vector3 v)
	{
		return Vector3.Angle(Vector3.up, v) < this.maxSlopeAngle;
	}

	// Token: 0x060005BA RID: 1466 RVA: 0x0001DA64 File Offset: 0x0001BC64
	private bool IsSurf(Vector3 v)
	{
		float num = Vector3.Angle(Vector3.up, v);
		return num < 89f && num > this.maxSlopeAngle;
	}

	// Token: 0x060005BB RID: 1467 RVA: 0x0001DA90 File Offset: 0x0001BC90
	private bool IsWall(Vector3 v)
	{
		return Math.Abs(90f - Vector3.Angle(Vector3.up, v)) < 0.1f;
	}

	// Token: 0x060005BC RID: 1468 RVA: 0x0001DAAF File Offset: 0x0001BCAF
	private bool IsRoof(Vector3 v)
	{
		return v.y == -1f;
	}

	// Token: 0x060005BD RID: 1469 RVA: 0x0001DAC0 File Offset: 0x0001BCC0
	private void OnCollisionEnter(Collision other)
	{
		int layer = other.gameObject.layer;
		Vector3 normal = other.contacts[0].normal;
		if (this.whatIsGround != (this.whatIsGround | 1 << layer))
		{
			return;
		}
		if (this.IsFloor(normal) && this.fallSpeed < -12f)
		{
			MoveCamera.Instance.BobOnce(new Vector3(0f, this.fallSpeed, 0f));
			Vector3 point = other.contacts[0].point;
			ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = Instantiate<GameObject>(this.playerSmokeFx, point, Quaternion.LookRotation(base.transform.position - point)).GetComponent<ParticleSystem>().velocityOverLifetime;
			velocityOverLifetime.x = this.rb.velocity.x * 2f;
			velocityOverLifetime.z = this.rb.velocity.z * 2f;
		}
	}

	// Token: 0x060005BE RID: 1470 RVA: 0x0001DBCC File Offset: 0x0001BDCC
	private void OnCollisionStay(Collision other)
	{
		int layer = other.gameObject.layer;
		if (this.whatIsGround != (this.whatIsGround | 1 << layer))
		{
			return;
		}
		for (int i = 0; i < other.contactCount; i++)
		{
			Vector3 normal = other.contacts[i].normal;
			if (this.IsFloor(normal))
			{
				if (!this.grounded)
				{
					bool flag = this.crouching;
				}
				if (Vector3.Angle(Vector3.up, normal) > 1f)
				{
					this.onRamp = true;
				}
				else
				{
					this.onRamp = false;
				}
				this.grounded = true;
				this.normalVector = normal;
				this.cancellingGrounded = false;
				this.groundCancel = 0;
			}
			if (this.IsSurf(normal))
			{
				this.surfing = true;
				this.cancellingSurf = false;
				this.surfCancel = 0;
			}
		}
	}

	// Token: 0x060005BF RID: 1471 RVA: 0x0001DCA4 File Offset: 0x0001BEA4
	private void UpdateCollisionChecks()
	{
		if (!this.cancellingGrounded)
		{
			this.cancellingGrounded = true;
		}
		else
		{
			this.groundCancel++;
			if ((float)this.groundCancel > this.delay)
			{
				this.StopGrounded();
			}
		}
		if (!this.cancellingSurf)
		{
			this.cancellingSurf = true;
			this.surfCancel = 1;
			return;
		}
		this.surfCancel++;
		if ((float)this.surfCancel > this.delay)
		{
			this.StopSurf();
		}
	}

	// Token: 0x060005C0 RID: 1472 RVA: 0x0001DD1F File Offset: 0x0001BF1F
	private void StopGrounded()
	{
		this.grounded = false;
	}

	// Token: 0x060005C1 RID: 1473 RVA: 0x0001DD28 File Offset: 0x0001BF28
	private void StopSurf()
	{
		this.surfing = false;
	}

	// Token: 0x060005C2 RID: 1474 RVA: 0x0001DD31 File Offset: 0x0001BF31
	public Vector3 GetVelocity()
	{
		return this.rb.velocity;
	}

	// Token: 0x060005C3 RID: 1475 RVA: 0x0001DD3E File Offset: 0x0001BF3E
	public float GetFallSpeed()
	{
		return this.rb.velocity.y;
	}

	// Token: 0x060005C4 RID: 1476 RVA: 0x0001DD50 File Offset: 0x0001BF50
	public Collider GetPlayerCollider()
	{
		return this.playerCollider;
	}

	// Token: 0x060005C5 RID: 1477 RVA: 0x0001DD58 File Offset: 0x0001BF58
	public Transform GetPlayerCamTransform()
	{
		return this.playerCam.transform;
	}

	// Token: 0x060005C6 RID: 1478 RVA: 0x0001DD68 File Offset: 0x0001BF68
	public Vector3 HitPoint()
	{
		RaycastHit[] array = Physics.RaycastAll(this.playerCam.transform.position, this.playerCam.transform.forward, 100f, this.whatIsHittable);
		if (array.Length < 1)
		{
			return this.playerCam.transform.position + this.playerCam.transform.forward * 100f;
		}
		if (array.Length > 1)
		{
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].transform.gameObject.layer == LayerMask.NameToLayer("Enemy") || array[i].transform.gameObject.layer == LayerMask.NameToLayer("Object") || array[i].transform.gameObject.layer == LayerMask.NameToLayer("Ground"))
				{
					return array[i].point;
				}
			}
		}
		return array[0].point;
	}

	// Token: 0x060005C7 RID: 1479 RVA: 0x0001DE77 File Offset: 0x0001C077
	public bool IsCrouching()
	{
		return this.crouching;
	}

	// Token: 0x060005C8 RID: 1480 RVA: 0x0001DE7F File Offset: 0x0001C07F
	public bool IsDead()
	{
		return this.dead;
	}

	// Token: 0x060005C9 RID: 1481 RVA: 0x0001DE87 File Offset: 0x0001C087
	public Rigidbody GetRb()
	{
		return this.rb;
	}

	// Token: 0x040004F4 RID: 1268
	public GameObject playerJumpSmokeFx;

	// Token: 0x040004F5 RID: 1269
	public GameObject footstepFx;

	// Token: 0x040004F6 RID: 1270
	public Transform playerCam;

	// Token: 0x040004F7 RID: 1271
	public Transform orientation;

	// Token: 0x040004F8 RID: 1272
	private Rigidbody rb;

	// Token: 0x040004F9 RID: 1273
	public bool dead;

	// Token: 0x040004FA RID: 1274
	private float moveSpeed = 3500f;

	// Token: 0x040004FB RID: 1275
	private float maxWalkSpeed = 6.5f;

	// Token: 0x040004FC RID: 1276
	private float maxRunSpeed = 13f;

	// Token: 0x040004FD RID: 1277
	private float maxSpeed = 6.5f;

	// Token: 0x040004FE RID: 1278
	public bool grounded;

	// Token: 0x040004FF RID: 1279
	public LayerMask whatIsGround;

	// Token: 0x04000500 RID: 1280
	public float extraGravity = 5f;

	// Token: 0x04000501 RID: 1281
	private Vector3 crouchScale = new Vector3(1f, 1.05f, 1f);

	// Token: 0x04000502 RID: 1282
	private Vector3 playerScale;

	// Token: 0x04000503 RID: 1283
	private float slideForce = 800f;

	// Token: 0x04000504 RID: 1284
	private float slideCounterMovement = 0.12f;

	// Token: 0x04000505 RID: 1285
	private bool readyToJump = true;

	// Token: 0x04000506 RID: 1286
	private float jumpCooldown = 0.25f;

	// Token: 0x04000507 RID: 1287
	private float jumpForce = 12f;

	// Token: 0x04000508 RID: 1288
	private int jumps = 1;

	// Token: 0x04000509 RID: 1289
	private float x;

	// Token: 0x0400050A RID: 1290
	private float y;

	// Token: 0x0400050B RID: 1291
	private float mouseDeltaX;

	// Token: 0x0400050C RID: 1292
	private float mouseDeltaY;

	// Token: 0x0400050D RID: 1293
	private bool jumping;

	// Token: 0x0400050E RID: 1294
	private bool sliding;

	// Token: 0x0400050F RID: 1295
	private bool crouching;

	// Token: 0x04000511 RID: 1297
	private Vector3 normalVector;

	// Token: 0x04000512 RID: 1298
	public ParticleSystem ps;

	// Token: 0x04000513 RID: 1299
	private ParticleSystem.EmissionModule psEmission;

	// Token: 0x04000514 RID: 1300
	private Collider playerCollider;

	// Token: 0x04000515 RID: 1301
	private float fallSpeed;

	// Token: 0x04000516 RID: 1302
	public GameObject playerSmokeFx;

	// Token: 0x04000517 RID: 1303
	private PlayerStatus playerStatus;

	// Token: 0x04000519 RID: 1305
	private float distance;

	// Token: 0x0400051A RID: 1306
	private bool onRamp;

	// Token: 0x0400051B RID: 1307
	private int extraJumps;

	// Token: 0x0400051C RID: 1308
	private int resetJumpCounter;

	// Token: 0x0400051D RID: 1309
	private int jumpCounterResetTime = 10;

	// Token: 0x0400051E RID: 1310
	private float counterMovement = 0.14f;

	// Token: 0x0400051F RID: 1311
	private float threshold = 0.01f;

	// Token: 0x04000520 RID: 1312
	private int readyToCounterX;

	// Token: 0x04000521 RID: 1313
	private int readyToCounterY;

	// Token: 0x04000522 RID: 1314
	private bool cancelling;

	// Token: 0x04000523 RID: 1315
	private float maxSlopeAngle = 50f;

	// Token: 0x04000524 RID: 1316
	private bool airborne;

	// Token: 0x04000525 RID: 1317
	private bool onGround;

	// Token: 0x04000526 RID: 1318
	private bool surfing;

	// Token: 0x04000527 RID: 1319
	private bool cancellingGrounded;

	// Token: 0x04000528 RID: 1320
	private bool cancellingSurf;

	// Token: 0x04000529 RID: 1321
	private float delay = 5f;

	// Token: 0x0400052A RID: 1322
	private int groundCancel;

	// Token: 0x0400052B RID: 1323
	private int wallCancel;

	// Token: 0x0400052C RID: 1324
	private int surfCancel;

	// Token: 0x0400052D RID: 1325
	public LayerMask whatIsHittable;

	// Token: 0x0400052E RID: 1326
	private float vel;
}
