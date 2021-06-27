using System;
using UnityEngine;

// Token: 0x020000DA RID: 218
public class PlayerMovement : MonoBehaviour
{
	// Token: 0x1700004C RID: 76
	// (get) Token: 0x060006AE RID: 1710 RVA: 0x000228AB File Offset: 0x00020AAB
	// (set) Token: 0x060006AF RID: 1711 RVA: 0x000228B3 File Offset: 0x00020AB3
	public bool jumping { get; set; }

	// Token: 0x1700004D RID: 77
	// (get) Token: 0x060006B0 RID: 1712 RVA: 0x000228BC File Offset: 0x00020ABC
	// (set) Token: 0x060006B1 RID: 1713 RVA: 0x000228C4 File Offset: 0x00020AC4
	public bool sliding { get; set; }

	// Token: 0x1700004E RID: 78
	// (get) Token: 0x060006B2 RID: 1714 RVA: 0x000228CD File Offset: 0x00020ACD
	// (set) Token: 0x060006B3 RID: 1715 RVA: 0x000228D5 File Offset: 0x00020AD5
	public bool crouching { get; set; }

	// Token: 0x1700004F RID: 79
	// (get) Token: 0x060006B4 RID: 1716 RVA: 0x000228DE File Offset: 0x00020ADE
	// (set) Token: 0x060006B5 RID: 1717 RVA: 0x000228E6 File Offset: 0x00020AE6
	public bool sprinting { get; private set; }

	// Token: 0x17000050 RID: 80
	// (get) Token: 0x060006B6 RID: 1718 RVA: 0x000228EF File Offset: 0x00020AEF
	// (set) Token: 0x060006B7 RID: 1719 RVA: 0x000228F6 File Offset: 0x00020AF6
	public static PlayerMovement Instance { get; private set; }

	// Token: 0x060006B8 RID: 1720 RVA: 0x000228FE File Offset: 0x00020AFE
	private void Awake()
	{
		PlayerMovement.Instance = this;
		this.rb = base.GetComponent<Rigidbody>();
		this.playerStatus = base.GetComponent<PlayerStatus>();
	}

	// Token: 0x060006B9 RID: 1721 RVA: 0x0002291E File Offset: 0x00020B1E
	private void Start()
	{
		this.playerScale = base.transform.localScale;
		this.playerCollider = base.GetComponent<Collider>();
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x060006BA RID: 1722 RVA: 0x00022949 File Offset: 0x00020B49
	private void Update()
	{
		if (this.dead)
		{
			return;
		}
		this.FootSteps();
		this.fallSpeed = this.rb.velocity.y;
	}

	// Token: 0x060006BB RID: 1723 RVA: 0x00022970 File Offset: 0x00020B70
	public Vector2 GetInput()
	{
		return new Vector2(this.x, this.y);
	}

	// Token: 0x060006BC RID: 1724 RVA: 0x00022983 File Offset: 0x00020B83
	public void SetInput(Vector2 dir, bool crouching, bool jumping, bool sprinting)
	{
		this.x = dir.x;
		this.y = dir.y;
		this.crouching = crouching;
		this.jumping = jumping;
		this.sprinting = sprinting;
	}

	// Token: 0x060006BD RID: 1725 RVA: 0x000229B4 File Offset: 0x00020BB4
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

	// Token: 0x060006BE RID: 1726 RVA: 0x00022A1C File Offset: 0x00020C1C
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

	// Token: 0x060006BF RID: 1727 RVA: 0x00022AD8 File Offset: 0x00020CD8
	public void StopCrouch()
	{
		this.sliding = false;
		base.transform.localScale = this.playerScale;
		base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y + 0.65f, base.transform.position.z);
	}

	// Token: 0x060006C0 RID: 1728 RVA: 0x00022B44 File Offset: 0x00020D44
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

	// Token: 0x060006C1 RID: 1729 RVA: 0x00022BE4 File Offset: 0x00020DE4
	private void WaterMovement()
	{
		float num = 1f;
		if (this.jumping)
		{
			num *= 2f;
		}
		this.rb.AddForce(Vector3.up * this.rb.mass * -Physics.gravity.y * num);
		float d = 1f;
		if (PlayerStatus.Instance.stamina <= 0f)
		{
			d = 0.5f;
		}
		this.rb.AddForce(this.playerCam.transform.forward * this.y * this.swimSpeed * d);
		this.rb.AddForce(this.orientation.transform.right * this.x * this.swimSpeed * d);
	}

	// Token: 0x060006C2 RID: 1730 RVA: 0x00022CC8 File Offset: 0x00020EC8
	public bool IsUnderWater()
	{
		float num = World.Instance.water.position.y;
		return base.transform.position.y < num;
	}

	// Token: 0x060006C3 RID: 1731 RVA: 0x00022D00 File Offset: 0x00020F00
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
		if (WorldUtility.WorldHeightToBiome(base.transform.position.y + 3.2f) == TextureData.TerrainType.Water)
		{
			this.maxSpeed *= 0.4f;
		}
		if (this.IsUnderWater())
		{
			if (this.rb.drag <= 0f)
			{
				this.rb.drag = 1f;
			}
			this.WaterMovement();
			return;
		}
		if (this.rb.drag > 0f)
		{
			this.rb.drag = 0f;
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

	// Token: 0x060006C4 RID: 1732 RVA: 0x0002307C File Offset: 0x0002127C
	public void PushPlayer()
	{
		this.pushed = true;
		Invoke(nameof(ResetPush), 0.3f);
	}

	// Token: 0x060006C5 RID: 1733 RVA: 0x00023095 File Offset: 0x00021295
	private void ResetPush()
	{
		this.pushed = false;
	}

	// Token: 0x060006C6 RID: 1734 RVA: 0x000230A0 File Offset: 0x000212A0
	private void RampMovement(Vector2 mag)
	{
		if (this.grounded && this.onRamp && !this.surfing && !this.crouching && !this.jumping && this.resetJumpCounter >= this.jumpCounterResetTime && Math.Abs(this.x) < 0.05f && Math.Abs(this.y) < 0.05f && !this.pushed)
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

	// Token: 0x060006C7 RID: 1735 RVA: 0x000231CA File Offset: 0x000213CA
	private void ResetJump()
	{
		this.readyToJump = true;
		base.CancelInvoke("JumpCooldown");
	}

	// Token: 0x060006C8 RID: 1736 RVA: 0x000231E0 File Offset: 0x000213E0
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
			Invoke(nameof(JumpCooldown), 0.25f);
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

	// Token: 0x060006C9 RID: 1737 RVA: 0x000233E1 File Offset: 0x000215E1
	private void JumpCooldown()
	{
		this.readyToJump = true;
	}

	// Token: 0x060006CA RID: 1738 RVA: 0x000233EC File Offset: 0x000215EC
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

	// Token: 0x060006CB RID: 1739 RVA: 0x00023746 File Offset: 0x00021946
	private bool IsHoldingAgainstHorizontalVel(Vector2 vel)
	{
		return (vel.x < -this.threshold && this.x > 0f) || (vel.x > this.threshold && this.x < 0f);
	}

	// Token: 0x060006CC RID: 1740 RVA: 0x00023783 File Offset: 0x00021983
	private bool IsHoldingAgainstVerticalVel(Vector2 vel)
	{
		return (vel.y < -this.threshold && this.y > 0f) || (vel.y > this.threshold && this.y < 0f);
	}

	// Token: 0x060006CD RID: 1741 RVA: 0x000237C0 File Offset: 0x000219C0
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

	// Token: 0x060006CE RID: 1742 RVA: 0x0002386D File Offset: 0x00021A6D
	private bool IsFloor(Vector3 v)
	{
		return Vector3.Angle(Vector3.up, v) < this.maxSlopeAngle;
	}

	// Token: 0x060006CF RID: 1743 RVA: 0x00023884 File Offset: 0x00021A84
	private bool IsSurf(Vector3 v)
	{
		float num = Vector3.Angle(Vector3.up, v);
		return num < 89f && num > this.maxSlopeAngle;
	}

	// Token: 0x060006D0 RID: 1744 RVA: 0x000238B0 File Offset: 0x00021AB0
	private bool IsWall(Vector3 v)
	{
		return Math.Abs(90f - Vector3.Angle(Vector3.up, v)) < 0.1f;
	}

	// Token: 0x060006D1 RID: 1745 RVA: 0x000238CF File Offset: 0x00021ACF
	private bool IsRoof(Vector3 v)
	{
		return v.y == -1f;
	}

	// Token: 0x060006D2 RID: 1746 RVA: 0x000238E0 File Offset: 0x00021AE0
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

	// Token: 0x060006D3 RID: 1747 RVA: 0x000239EC File Offset: 0x00021BEC
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
			normal = new Vector3(normal.x, Mathf.Abs(normal.y), normal.z);
			if (this.IsFloor(normal))
			{
				if (!this.grounded)
				{
					bool crouching = this.crouching;
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

	// Token: 0x060006D4 RID: 1748 RVA: 0x00023AE0 File Offset: 0x00021CE0
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

	// Token: 0x060006D5 RID: 1749 RVA: 0x00023B5B File Offset: 0x00021D5B
	private void StopGrounded()
	{
		this.grounded = false;
	}

	// Token: 0x060006D6 RID: 1750 RVA: 0x00023B64 File Offset: 0x00021D64
	private void StopSurf()
	{
		this.surfing = false;
	}

	// Token: 0x060006D7 RID: 1751 RVA: 0x00023B6D File Offset: 0x00021D6D
	public Vector3 GetVelocity()
	{
		return this.rb.velocity;
	}

	// Token: 0x060006D8 RID: 1752 RVA: 0x00023B7A File Offset: 0x00021D7A
	public float GetFallSpeed()
	{
		return this.rb.velocity.y;
	}

	// Token: 0x060006D9 RID: 1753 RVA: 0x00023B8C File Offset: 0x00021D8C
	public Collider GetPlayerCollider()
	{
		return this.playerCollider;
	}

	// Token: 0x060006DA RID: 1754 RVA: 0x00023B94 File Offset: 0x00021D94
	public Transform GetPlayerCamTransform()
	{
		return this.playerCam.transform;
	}

	// Token: 0x060006DB RID: 1755 RVA: 0x00023BA4 File Offset: 0x00021DA4
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

	// Token: 0x060006DC RID: 1756 RVA: 0x00023CB3 File Offset: 0x00021EB3
	public bool IsCrouching()
	{
		return this.crouching;
	}

	// Token: 0x060006DD RID: 1757 RVA: 0x00023CBB File Offset: 0x00021EBB
	public bool IsDead()
	{
		return this.dead;
	}

	// Token: 0x060006DE RID: 1758 RVA: 0x00023CC3 File Offset: 0x00021EC3
	public Rigidbody GetRb()
	{
		return this.rb;
	}

	// Token: 0x0400060D RID: 1549
	public GameObject playerJumpSmokeFx;

	// Token: 0x0400060E RID: 1550
	public GameObject footstepFx;

	// Token: 0x0400060F RID: 1551
	public Transform playerCam;

	// Token: 0x04000610 RID: 1552
	public Transform orientation;

	// Token: 0x04000611 RID: 1553
	private Rigidbody rb;

	// Token: 0x04000612 RID: 1554
	public bool dead;

	// Token: 0x04000613 RID: 1555
	private float moveSpeed = 3500f;

	// Token: 0x04000614 RID: 1556
	private float maxWalkSpeed = 6.5f;

	// Token: 0x04000615 RID: 1557
	private float maxRunSpeed = 13f;

	// Token: 0x04000616 RID: 1558
	private float maxSpeed = 6.5f;

	// Token: 0x04000617 RID: 1559
	public bool grounded;

	// Token: 0x04000618 RID: 1560
	public LayerMask whatIsGround;

	// Token: 0x04000619 RID: 1561
	public float extraGravity = 5f;

	// Token: 0x0400061A RID: 1562
	private Vector3 crouchScale = new Vector3(1f, 1.05f, 1f);

	// Token: 0x0400061B RID: 1563
	private Vector3 playerScale;

	// Token: 0x0400061C RID: 1564
	private float slideForce = 800f;

	// Token: 0x0400061D RID: 1565
	private float slideCounterMovement = 0.12f;

	// Token: 0x0400061E RID: 1566
	private bool readyToJump = true;

	// Token: 0x0400061F RID: 1567
	private float jumpCooldown = 0.25f;

	// Token: 0x04000620 RID: 1568
	private float jumpForce = 12f;

	// Token: 0x04000621 RID: 1569
	private int jumps = 1;

	// Token: 0x04000622 RID: 1570
	private float x;

	// Token: 0x04000623 RID: 1571
	private float y;

	// Token: 0x04000624 RID: 1572
	private float mouseDeltaX;

	// Token: 0x04000625 RID: 1573
	private float mouseDeltaY;

	// Token: 0x0400062A RID: 1578
	private Vector3 normalVector;

	// Token: 0x0400062B RID: 1579
	public ParticleSystem ps;

	// Token: 0x0400062C RID: 1580
	private ParticleSystem.EmissionModule psEmission;

	// Token: 0x0400062D RID: 1581
	private Collider playerCollider;

	// Token: 0x0400062E RID: 1582
	private float fallSpeed;

	// Token: 0x0400062F RID: 1583
	public GameObject playerSmokeFx;

	// Token: 0x04000630 RID: 1584
	private PlayerStatus playerStatus;

	// Token: 0x04000632 RID: 1586
	private float distance;

	// Token: 0x04000633 RID: 1587
	private float swimSpeed = 50f;

	// Token: 0x04000634 RID: 1588
	private bool pushed;

	// Token: 0x04000635 RID: 1589
	private bool onRamp;

	// Token: 0x04000636 RID: 1590
	private int extraJumps;

	// Token: 0x04000637 RID: 1591
	private int resetJumpCounter;

	// Token: 0x04000638 RID: 1592
	private int jumpCounterResetTime = 10;

	// Token: 0x04000639 RID: 1593
	private float counterMovement = 0.14f;

	// Token: 0x0400063A RID: 1594
	private float threshold = 0.01f;

	// Token: 0x0400063B RID: 1595
	private int readyToCounterX;

	// Token: 0x0400063C RID: 1596
	private int readyToCounterY;

	// Token: 0x0400063D RID: 1597
	private bool cancelling;

	// Token: 0x0400063E RID: 1598
	private float maxSlopeAngle = 50f;

	// Token: 0x0400063F RID: 1599
	private bool airborne;

	// Token: 0x04000640 RID: 1600
	private bool onGround;

	// Token: 0x04000641 RID: 1601
	private bool surfing;

	// Token: 0x04000642 RID: 1602
	private bool cancellingGrounded;

	// Token: 0x04000643 RID: 1603
	private bool cancellingSurf;

	// Token: 0x04000644 RID: 1604
	private float delay = 5f;

	// Token: 0x04000645 RID: 1605
	private int groundCancel;

	// Token: 0x04000646 RID: 1606
	private int wallCancel;

	// Token: 0x04000647 RID: 1607
	private int surfCancel;

	// Token: 0x04000648 RID: 1608
	public LayerMask whatIsHittable;

	// Token: 0x04000649 RID: 1609
	private float vel;
}
