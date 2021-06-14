using System;
using UnityEngine;

// Token: 0x020000ED RID: 237
public class PlayerMovement : MonoBehaviour
{
	// Token: 0x17000048 RID: 72
	// (get) Token: 0x06000637 RID: 1591 RVA: 0x00005F61 File Offset: 0x00004161
	// (set) Token: 0x06000638 RID: 1592 RVA: 0x00005F69 File Offset: 0x00004169
	public bool sprinting { get; private set; }

	// Token: 0x17000049 RID: 73
	// (get) Token: 0x06000639 RID: 1593 RVA: 0x00005F72 File Offset: 0x00004172
	// (set) Token: 0x0600063A RID: 1594 RVA: 0x00005F79 File Offset: 0x00004179
	public static PlayerMovement Instance { get; private set; }

	// Token: 0x0600063B RID: 1595 RVA: 0x00005F81 File Offset: 0x00004181
	private void Awake()
	{
		PlayerMovement.Instance = this;
		this.rb = base.GetComponent<Rigidbody>();
		this.playerStatus = base.GetComponent<PlayerStatus>();
	}

	// Token: 0x0600063C RID: 1596 RVA: 0x00005FA1 File Offset: 0x000041A1
	private void Start()
	{
		this.playerScale = base.transform.localScale;
		this.playerCollider = base.GetComponent<Collider>();
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x0600063D RID: 1597 RVA: 0x00005FCC File Offset: 0x000041CC
	private void Update()
	{
		if (this.dead)
		{
			return;
		}
		this.FootSteps();
		this.fallSpeed = this.rb.velocity.y;
	}

	// Token: 0x0600063E RID: 1598 RVA: 0x00005FF3 File Offset: 0x000041F3
	public void SetInput(Vector2 dir, bool crouching, bool jumping, bool sprinting)
	{
		this.x = dir.x;
		this.y = dir.y;
		this.crouching = crouching;
		this.jumping = jumping;
		this.sprinting = sprinting;
	}

	// Token: 0x0600063F RID: 1599 RVA: 0x00020AF0 File Offset: 0x0001ECF0
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

	// Token: 0x06000640 RID: 1600 RVA: 0x00020B58 File Offset: 0x0001ED58
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

	// Token: 0x06000641 RID: 1601 RVA: 0x00020C14 File Offset: 0x0001EE14
	public void StopCrouch()
	{
		this.sliding = false;
		base.transform.localScale = this.playerScale;
		base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 0.65f, base.transform.position.z);
	}

	// Token: 0x06000642 RID: 1602 RVA: 0x00020C80 File Offset: 0x0001EE80
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

	// Token: 0x06000643 RID: 1603 RVA: 0x00020D20 File Offset: 0x0001EF20
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

	// Token: 0x06000644 RID: 1604 RVA: 0x0002104C File Offset: 0x0001F24C
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

	// Token: 0x06000645 RID: 1605 RVA: 0x00006023 File Offset: 0x00004223
	private void ResetJump()
	{
		this.readyToJump = true;
		base.CancelInvoke(nameof(JumpCooldown));
	}

	// Token: 0x06000646 RID: 1606 RVA: 0x0002116C File Offset: 0x0001F36C
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
			base.CancelInvoke(nameof(JumpCooldown));
			base.Invoke(nameof(JumpCooldown), 0.25f);
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
			ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime =Instantiate<GameObject>(this.playerJumpSmokeFx, base.transform.position, Quaternion.LookRotation(Vector3.up)).GetComponent<ParticleSystem>().velocityOverLifetime;
			velocityOverLifetime.x = this.rb.velocity.x * 2f;
			velocityOverLifetime.z = this.rb.velocity.z * 2f;
			this.playerStatus.Jump();
		}
	}

	// Token: 0x06000647 RID: 1607 RVA: 0x00006037 File Offset: 0x00004237
	private void JumpCooldown()
	{
		this.readyToJump = true;
	}

	// Token: 0x06000648 RID: 1608 RVA: 0x00021370 File Offset: 0x0001F570
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

	// Token: 0x06000649 RID: 1609 RVA: 0x00006040 File Offset: 0x00004240
	private bool IsHoldingAgainstHorizontalVel(Vector2 vel)
	{
		return (vel.x < -this.threshold && this.x > 0f) || (vel.x > this.threshold && this.x < 0f);
	}

	// Token: 0x0600064A RID: 1610 RVA: 0x0000607D File Offset: 0x0000427D
	private bool IsHoldingAgainstVerticalVel(Vector2 vel)
	{
		return (vel.y < -this.threshold && this.y > 0f) || (vel.y > this.threshold && this.y < 0f);
	}

	// Token: 0x0600064B RID: 1611 RVA: 0x000216CC File Offset: 0x0001F8CC
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

	// Token: 0x0600064C RID: 1612 RVA: 0x000060BA File Offset: 0x000042BA
	private bool IsFloor(Vector3 v)
	{
		return Vector3.Angle(Vector3.up, v) < this.maxSlopeAngle;
	}

	// Token: 0x0600064D RID: 1613 RVA: 0x0002177C File Offset: 0x0001F97C
	private bool IsSurf(Vector3 v)
	{
		float num = Vector3.Angle(Vector3.up, v);
		return num < 89f && num > this.maxSlopeAngle;
	}

	// Token: 0x0600064E RID: 1614 RVA: 0x000060CF File Offset: 0x000042CF
	private bool IsWall(Vector3 v)
	{
		return Math.Abs(90f - Vector3.Angle(Vector3.up, v)) < 0.1f;
	}

	// Token: 0x0600064F RID: 1615 RVA: 0x000060EE File Offset: 0x000042EE
	private bool IsRoof(Vector3 v)
	{
		return v.y == -1f;
	}

	// Token: 0x06000650 RID: 1616 RVA: 0x000217A8 File Offset: 0x0001F9A8
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
			ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime =Instantiate<GameObject>(this.playerSmokeFx, point, Quaternion.LookRotation(base.transform.position - point)).GetComponent<ParticleSystem>().velocityOverLifetime;
			velocityOverLifetime.x = this.rb.velocity.x * 2f;
			velocityOverLifetime.z = this.rb.velocity.z * 2f;
		}
	}

	// Token: 0x06000651 RID: 1617 RVA: 0x000218B4 File Offset: 0x0001FAB4
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

	// Token: 0x06000652 RID: 1618 RVA: 0x0002198C File Offset: 0x0001FB8C
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

	// Token: 0x06000653 RID: 1619 RVA: 0x000060FD File Offset: 0x000042FD
	private void StopGrounded()
	{
		this.grounded = false;
	}

	// Token: 0x06000654 RID: 1620 RVA: 0x00006106 File Offset: 0x00004306
	private void StopSurf()
	{
		this.surfing = false;
	}

	// Token: 0x06000655 RID: 1621 RVA: 0x0000610F File Offset: 0x0000430F
	public Vector3 GetVelocity()
	{
		return this.rb.velocity;
	}

	// Token: 0x06000656 RID: 1622 RVA: 0x0000611C File Offset: 0x0000431C
	public float GetFallSpeed()
	{
		return this.rb.velocity.y;
	}

	// Token: 0x06000657 RID: 1623 RVA: 0x0000612E File Offset: 0x0000432E
	public Collider GetPlayerCollider()
	{
		return this.playerCollider;
	}

	// Token: 0x06000658 RID: 1624 RVA: 0x00006136 File Offset: 0x00004336
	public Transform GetPlayerCamTransform()
	{
		return this.playerCam.transform;
	}

	// Token: 0x06000659 RID: 1625 RVA: 0x00021A08 File Offset: 0x0001FC08
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

	// Token: 0x0600065A RID: 1626 RVA: 0x00006143 File Offset: 0x00004343
	public bool IsCrouching()
	{
		return this.crouching;
	}

	// Token: 0x0600065B RID: 1627 RVA: 0x0000614B File Offset: 0x0000434B
	public bool IsDead()
	{
		return this.dead;
	}

	// Token: 0x0600065C RID: 1628 RVA: 0x00006153 File Offset: 0x00004353
	public Rigidbody GetRb()
	{
		return this.rb;
	}

	// Token: 0x040005F0 RID: 1520
	public GameObject playerJumpSmokeFx;

	// Token: 0x040005F1 RID: 1521
	public GameObject footstepFx;

	// Token: 0x040005F2 RID: 1522
	public Transform playerCam;

	// Token: 0x040005F3 RID: 1523
	public Transform orientation;

	// Token: 0x040005F4 RID: 1524
	private Rigidbody rb;

	// Token: 0x040005F5 RID: 1525
	public bool dead;

	// Token: 0x040005F6 RID: 1526
	private float moveSpeed = 3500f;

	// Token: 0x040005F7 RID: 1527
	private float maxWalkSpeed = 6.5f;

	// Token: 0x040005F8 RID: 1528
	private float maxRunSpeed = 13f;

	// Token: 0x040005F9 RID: 1529
	private float maxSpeed = 6.5f;

	// Token: 0x040005FA RID: 1530
	public bool grounded;

	// Token: 0x040005FB RID: 1531
	public LayerMask whatIsGround;

	// Token: 0x040005FC RID: 1532
	public float extraGravity = 5f;

	// Token: 0x040005FD RID: 1533
	private Vector3 crouchScale = new Vector3(1f, 1.05f, 1f);

	// Token: 0x040005FE RID: 1534
	private Vector3 playerScale;

	// Token: 0x040005FF RID: 1535
	private float slideForce = 800f;

	// Token: 0x04000600 RID: 1536
	private float slideCounterMovement = 0.12f;

	// Token: 0x04000601 RID: 1537
	private bool readyToJump = true;

	// Token: 0x04000602 RID: 1538
	private float jumpCooldown = 0.25f;

	// Token: 0x04000603 RID: 1539
	private float jumpForce = 12f;

	// Token: 0x04000604 RID: 1540
	private int jumps = 1;

	// Token: 0x04000605 RID: 1541
	private float x;

	// Token: 0x04000606 RID: 1542
	private float y;

	// Token: 0x04000607 RID: 1543
	private float mouseDeltaX;

	// Token: 0x04000608 RID: 1544
	private float mouseDeltaY;

	// Token: 0x04000609 RID: 1545
	private bool jumping;

	// Token: 0x0400060A RID: 1546
	private bool sliding;

	// Token: 0x0400060B RID: 1547
	private bool crouching;

	// Token: 0x0400060D RID: 1549
	private Vector3 normalVector;

	// Token: 0x0400060E RID: 1550
	public ParticleSystem ps;

	// Token: 0x0400060F RID: 1551
	private ParticleSystem.EmissionModule psEmission;

	// Token: 0x04000610 RID: 1552
	private Collider playerCollider;

	// Token: 0x04000611 RID: 1553
	private float fallSpeed;

	// Token: 0x04000612 RID: 1554
	public GameObject playerSmokeFx;

	// Token: 0x04000613 RID: 1555
	private PlayerStatus playerStatus;

	// Token: 0x04000615 RID: 1557
	private float distance;

	// Token: 0x04000616 RID: 1558
	private bool onRamp;

	// Token: 0x04000617 RID: 1559
	private int extraJumps;

	// Token: 0x04000618 RID: 1560
	private int resetJumpCounter;

	// Token: 0x04000619 RID: 1561
	private int jumpCounterResetTime = 10;

	// Token: 0x0400061A RID: 1562
	private float counterMovement = 0.14f;

	// Token: 0x0400061B RID: 1563
	private float threshold = 0.01f;

	// Token: 0x0400061C RID: 1564
	private int readyToCounterX;

	// Token: 0x0400061D RID: 1565
	private int readyToCounterY;

	// Token: 0x0400061E RID: 1566
	private bool cancelling;

	// Token: 0x0400061F RID: 1567
	private float maxSlopeAngle = 50f;

	// Token: 0x04000620 RID: 1568
	private bool airborne;

	// Token: 0x04000621 RID: 1569
	private bool onGround;

	// Token: 0x04000622 RID: 1570
	private bool surfing;

	// Token: 0x04000623 RID: 1571
	private bool cancellingGrounded;

	// Token: 0x04000624 RID: 1572
	private bool cancellingSurf;

	// Token: 0x04000625 RID: 1573
	private float delay = 5f;

	// Token: 0x04000626 RID: 1574
	private int groundCancel;

	// Token: 0x04000627 RID: 1575
	private int wallCancel;

	// Token: 0x04000628 RID: 1576
	private int surfCancel;

	// Token: 0x04000629 RID: 1577
	public LayerMask whatIsHittable;

	// Token: 0x0400062A RID: 1578
	private float vel;
}
