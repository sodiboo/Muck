using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000D7 RID: 215
public class Gun : MonoBehaviour
{
	// Token: 0x17000048 RID: 72
	// (get) Token: 0x06000682 RID: 1666 RVA: 0x0002178A File Offset: 0x0001F98A
	// (set) Token: 0x06000683 RID: 1667 RVA: 0x00021791 File Offset: 0x0001F991
	public static Gun Instance { get; set; }

	// Token: 0x06000684 RID: 1668 RVA: 0x0002179C File Offset: 0x0001F99C
	private void Start()
	{
		Gun.Instance = this;
		this.velHistory = new List<Vector3>();
		this.startPos = base.transform.localPosition;
		this.rb = PlayerMovement.Instance.GetRb();
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x06000685 RID: 1669 RVA: 0x000217EC File Offset: 0x0001F9EC
	private void Update()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.MovementBob();
		this.ReloadGun();
		this.RecoilGun();
		this.SpeedBob();
		float b = 0f;
		float b2 = 0f;
		if (!InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			b = -Input.GetAxis("Mouse X") * this.gunDrag * this.currentGunDragMultiplier;
			b2 = -Input.GetAxis("Mouse Y") * this.gunDrag * this.currentGunDragMultiplier;
		}
		this.desX = Mathf.Lerp(this.desX, b, Time.unscaledDeltaTime * 10f);
		this.desY = Mathf.Lerp(this.desY, b2, Time.unscaledDeltaTime * 10f);
		this.Rotation(new Vector2(this.desX, this.desY));
		Vector3 b3 = this.startPos + new Vector3(this.desX, this.desY, 0f) + this.desiredBob + this.recoilOffset + new Vector3(0f, -this.reloadPosOffset, 0f) + this.speedBob;
		base.transform.localPosition = Vector3.Lerp(base.transform.localPosition, b3, Time.unscaledDeltaTime * 15f);
	}

	// Token: 0x06000686 RID: 1670 RVA: 0x00021948 File Offset: 0x0001FB48
	private void Rotation(Vector2 offset)
	{
		float num = offset.magnitude * 0.03f;
		if (offset.x < 0f)
		{
			num = -num;
		}
		float y = offset.y;
		float num2 = -offset.x;
		Vector3 euler = new Vector3(y * 80f + this.reloadRotation, num2 * 40f, num * 50f) + this.recoilRotation;
		try
		{
			if (Time.deltaTime > 0f)
			{
				base.transform.localRotation = Quaternion.Lerp(base.transform.localRotation, Quaternion.Euler(euler), Time.deltaTime * 20f);
			}
		}
		catch (Exception)
		{
		}
	}

	// Token: 0x06000687 RID: 1671 RVA: 0x000219FC File Offset: 0x0001FBFC
	private void MovementBob()
	{
		if (!this.rb)
		{
			return;
		}
		if (Mathf.Abs(this.rb.velocity.magnitude) < 4f || !PlayerMovement.Instance.grounded || PlayerMovement.Instance.IsCrouching())
		{
			this.desiredBob = Vector3.zero;
			return;
		}
		float x = Mathf.PingPong(Time.time * this.bobSpeed, this.xBob) - this.xBob / 2f;
		float y = Mathf.PingPong(Time.time * this.bobSpeed, this.yBob) - this.yBob / 2f;
		float z = Mathf.PingPong(Time.time * this.bobSpeed, this.zBob) - this.zBob / 2f;
		this.desiredBob = new Vector3(x, y, z);
	}

	// Token: 0x06000688 RID: 1672 RVA: 0x00021AD8 File Offset: 0x0001FCD8
	private void SpeedBob()
	{
		Vector2 vector = PlayerMovement.Instance.FindVelRelativeToLook();
		Vector3 vector2 = new Vector3(vector.x, PlayerMovement.Instance.GetVelocity().y, vector.y);
		vector2 *= -0.01f;
		vector2 = Vector3.ClampMagnitude(vector2, 0.6f);
		this.speedBob = Vector3.Lerp(this.speedBob, vector2, Time.deltaTime * 10f);
	}

	// Token: 0x06000689 RID: 1673 RVA: 0x00021B48 File Offset: 0x0001FD48
	private void RecoilGun()
	{
		this.recoilOffset = Vector3.SmoothDamp(this.recoilOffset, Vector3.zero, ref this.recoilOffsetVel, 0.05f);
		this.recoilRotation = Vector3.SmoothDamp(this.recoilRotation, Vector3.zero, ref this.recoilRotVel, 0.07f);
	}

	// Token: 0x0600068A RID: 1674 RVA: 0x00021B97 File Offset: 0x0001FD97
	public void Build()
	{
		this.recoilOffset += Vector3.down;
	}

	// Token: 0x0600068B RID: 1675 RVA: 0x00021BB0 File Offset: 0x0001FDB0
	private void ReloadGun()
	{
		this.reloadProgress += Time.deltaTime;
		this.reloadRotation = Mathf.Lerp(0f, this.desiredReloadRotation, this.reloadProgress / this.reloadTime);
		this.reloadPosOffset = Mathf.SmoothDamp(this.reloadPosOffset, 0f, ref this.rPVel, this.reloadTime * 0.2f);
		if (this.reloadRotation / 360f > (float)this.spins)
		{
			this.spins++;
		}
	}

	// Token: 0x040005C5 RID: 1477
	private Rigidbody rb;

	// Token: 0x040005C6 RID: 1478
	private Transform playerCam;

	// Token: 0x040005C7 RID: 1479
	private Vector3 startPos;

	// Token: 0x040005C8 RID: 1480
	private List<Vector3> velHistory;

	// Token: 0x040005C9 RID: 1481
	private Vector3 desiredBob;

	// Token: 0x040005CA RID: 1482
	private float xBob = 0.12f;

	// Token: 0x040005CB RID: 1483
	private float yBob = 0.08f;

	// Token: 0x040005CC RID: 1484
	private float zBob = 0.1f;

	// Token: 0x040005CD RID: 1485
	private float bobSpeed = 0.45f;

	// Token: 0x040005CE RID: 1486
	private Vector3 recoilOffset;

	// Token: 0x040005CF RID: 1487
	private Vector3 recoilRotation;

	// Token: 0x040005D0 RID: 1488
	private Vector3 recoilOffsetVel;

	// Token: 0x040005D1 RID: 1489
	private Vector3 recoilRotVel;

	// Token: 0x040005D2 RID: 1490
	private float reloadRotation;

	// Token: 0x040005D3 RID: 1491
	private float desiredReloadRotation;

	// Token: 0x040005D4 RID: 1492
	private float reloadTime;

	// Token: 0x040005D5 RID: 1493
	private float rVel;

	// Token: 0x040005D6 RID: 1494
	private float reloadPosOffset;

	// Token: 0x040005D7 RID: 1495
	private float rPVel;

	// Token: 0x040005D8 RID: 1496
	private float gunDrag = 0.2f;

	// Token: 0x040005D9 RID: 1497
	public float currentGunDragMultiplier = 1f;

	// Token: 0x040005DB RID: 1499
	private float desX;

	// Token: 0x040005DC RID: 1500
	private float desY;

	// Token: 0x040005DD RID: 1501
	private Vector3 speedBob;

	// Token: 0x040005DE RID: 1502
	private float reloadProgress;

	// Token: 0x040005DF RID: 1503
	private int spins;
}
