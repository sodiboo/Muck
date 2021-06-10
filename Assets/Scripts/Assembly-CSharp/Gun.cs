using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000AF RID: 175
public class Gun : MonoBehaviour
{
	// Token: 0x1700003B RID: 59
	// (get) Token: 0x06000578 RID: 1400 RVA: 0x0001BBFA File Offset: 0x00019DFA
	// (set) Token: 0x06000579 RID: 1401 RVA: 0x0001BC01 File Offset: 0x00019E01
	public static Gun Instance { get; set; }

	// Token: 0x0600057A RID: 1402 RVA: 0x0001BC0C File Offset: 0x00019E0C
	private void Start()
	{
		Gun.Instance = this;
		this.velHistory = new List<Vector3>();
		this.startPos = base.transform.localPosition;
		this.rb = PlayerMovement.Instance.GetRb();
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x0600057B RID: 1403 RVA: 0x0001BC5C File Offset: 0x00019E5C
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

	// Token: 0x0600057C RID: 1404 RVA: 0x0001BDB8 File Offset: 0x00019FB8
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

	// Token: 0x0600057D RID: 1405 RVA: 0x0001BE6C File Offset: 0x0001A06C
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

	// Token: 0x0600057E RID: 1406 RVA: 0x0001BF48 File Offset: 0x0001A148
	private void SpeedBob()
	{
		Vector2 vector = PlayerMovement.Instance.FindVelRelativeToLook();
		Vector3 vector2 = new Vector3(vector.x, PlayerMovement.Instance.GetVelocity().y, vector.y);
		vector2 *= -0.01f;
		vector2 = Vector3.ClampMagnitude(vector2, 0.6f);
		this.speedBob = Vector3.Lerp(this.speedBob, vector2, Time.deltaTime * 10f);
	}

	// Token: 0x0600057F RID: 1407 RVA: 0x0001BFB8 File Offset: 0x0001A1B8
	private void RecoilGun()
	{
		this.recoilOffset = Vector3.SmoothDamp(this.recoilOffset, Vector3.zero, ref this.recoilOffsetVel, 0.05f);
		this.recoilRotation = Vector3.SmoothDamp(this.recoilRotation, Vector3.zero, ref this.recoilRotVel, 0.07f);
	}

	// Token: 0x06000580 RID: 1408 RVA: 0x0001C008 File Offset: 0x0001A208
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

	// Token: 0x040004AD RID: 1197
	private Rigidbody rb;

	// Token: 0x040004AE RID: 1198
	private Transform playerCam;

	// Token: 0x040004AF RID: 1199
	private Vector3 startPos;

	// Token: 0x040004B0 RID: 1200
	private List<Vector3> velHistory;

	// Token: 0x040004B1 RID: 1201
	private Vector3 desiredBob;

	// Token: 0x040004B2 RID: 1202
	private float xBob = 0.12f;

	// Token: 0x040004B3 RID: 1203
	private float yBob = 0.08f;

	// Token: 0x040004B4 RID: 1204
	private float zBob = 0.1f;

	// Token: 0x040004B5 RID: 1205
	private float bobSpeed = 0.45f;

	// Token: 0x040004B6 RID: 1206
	private Vector3 recoilOffset;

	// Token: 0x040004B7 RID: 1207
	private Vector3 recoilRotation;

	// Token: 0x040004B8 RID: 1208
	private Vector3 recoilOffsetVel;

	// Token: 0x040004B9 RID: 1209
	private Vector3 recoilRotVel;

	// Token: 0x040004BA RID: 1210
	private float reloadRotation;

	// Token: 0x040004BB RID: 1211
	private float desiredReloadRotation;

	// Token: 0x040004BC RID: 1212
	private float reloadTime;

	// Token: 0x040004BD RID: 1213
	private float rVel;

	// Token: 0x040004BE RID: 1214
	private float reloadPosOffset;

	// Token: 0x040004BF RID: 1215
	private float rPVel;

	// Token: 0x040004C0 RID: 1216
	private float gunDrag = 0.2f;

	// Token: 0x040004C1 RID: 1217
	public float currentGunDragMultiplier = 1f;

	// Token: 0x040004C3 RID: 1219
	private float desX;

	// Token: 0x040004C4 RID: 1220
	private float desY;

	// Token: 0x040004C5 RID: 1221
	private Vector3 speedBob;

	// Token: 0x040004C6 RID: 1222
	private float reloadProgress;

	// Token: 0x040004C7 RID: 1223
	private int spins;
}
