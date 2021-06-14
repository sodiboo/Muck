using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000E9 RID: 233
public class Gun : MonoBehaviour
{
	// Token: 0x17000044 RID: 68
	// (get) Token: 0x0600060A RID: 1546 RVA: 0x00005D25 File Offset: 0x00003F25
	// (set) Token: 0x0600060B RID: 1547 RVA: 0x00005D2C File Offset: 0x00003F2C
	public static Gun Instance { get; set; }

	// Token: 0x0600060C RID: 1548 RVA: 0x0001FC4C File Offset: 0x0001DE4C
	private void Start()
	{
		Gun.Instance = this;
		this.velHistory = new List<Vector3>();
		this.startPos = base.transform.localPosition;
		this.rb = PlayerMovement.Instance.GetRb();
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x0600060D RID: 1549 RVA: 0x0001FC9C File Offset: 0x0001DE9C
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

	// Token: 0x0600060E RID: 1550 RVA: 0x0001FDF8 File Offset: 0x0001DFF8
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

	// Token: 0x0600060F RID: 1551 RVA: 0x0001FEAC File Offset: 0x0001E0AC
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

	// Token: 0x06000610 RID: 1552 RVA: 0x0001FF88 File Offset: 0x0001E188
	private void SpeedBob()
	{
		Vector2 vector = PlayerMovement.Instance.FindVelRelativeToLook();
		Vector3 vector2 = new Vector3(vector.x, PlayerMovement.Instance.GetVelocity().y, vector.y);
		vector2 *= -0.01f;
		vector2 = Vector3.ClampMagnitude(vector2, 0.6f);
		this.speedBob = Vector3.Lerp(this.speedBob, vector2, Time.deltaTime * 10f);
	}

	// Token: 0x06000611 RID: 1553 RVA: 0x0001FFF8 File Offset: 0x0001E1F8
	private void RecoilGun()
	{
		this.recoilOffset = Vector3.SmoothDamp(this.recoilOffset, Vector3.zero, ref this.recoilOffsetVel, 0.05f);
		this.recoilRotation = Vector3.SmoothDamp(this.recoilRotation, Vector3.zero, ref this.recoilRotVel, 0.07f);
	}

	// Token: 0x06000612 RID: 1554 RVA: 0x00005D34 File Offset: 0x00003F34
	public void Build()
	{
		this.recoilOffset += Vector3.down;
	}

	// Token: 0x06000613 RID: 1555 RVA: 0x00020048 File Offset: 0x0001E248
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

	// Token: 0x040005A4 RID: 1444
	private Rigidbody rb;

	// Token: 0x040005A5 RID: 1445
	private Transform playerCam;

	// Token: 0x040005A6 RID: 1446
	private Vector3 startPos;

	// Token: 0x040005A7 RID: 1447
	private List<Vector3> velHistory;

	// Token: 0x040005A8 RID: 1448
	private Vector3 desiredBob;

	// Token: 0x040005A9 RID: 1449
	private float xBob = 0.12f;

	// Token: 0x040005AA RID: 1450
	private float yBob = 0.08f;

	// Token: 0x040005AB RID: 1451
	private float zBob = 0.1f;

	// Token: 0x040005AC RID: 1452
	private float bobSpeed = 0.45f;

	// Token: 0x040005AD RID: 1453
	private Vector3 recoilOffset;

	// Token: 0x040005AE RID: 1454
	private Vector3 recoilRotation;

	// Token: 0x040005AF RID: 1455
	private Vector3 recoilOffsetVel;

	// Token: 0x040005B0 RID: 1456
	private Vector3 recoilRotVel;

	// Token: 0x040005B1 RID: 1457
	private float reloadRotation;

	// Token: 0x040005B2 RID: 1458
	private float desiredReloadRotation;

	// Token: 0x040005B3 RID: 1459
	private float reloadTime;

	// Token: 0x040005B4 RID: 1460
	private float rVel;

	// Token: 0x040005B5 RID: 1461
	private float reloadPosOffset;

	// Token: 0x040005B6 RID: 1462
	private float rPVel;

	// Token: 0x040005B7 RID: 1463
	private float gunDrag = 0.2f;

	// Token: 0x040005B8 RID: 1464
	public float currentGunDragMultiplier = 1f;

	// Token: 0x040005BA RID: 1466
	private float desX;

	// Token: 0x040005BB RID: 1467
	private float desY;

	// Token: 0x040005BC RID: 1468
	private Vector3 speedBob;

	// Token: 0x040005BD RID: 1469
	private float reloadProgress;

	// Token: 0x040005BE RID: 1470
	private int spins;
}
