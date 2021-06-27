using System;
using System.Collections.Generic;
using UnityEngine;

public class Gun : MonoBehaviour
{
	public static Gun Instance { get; set; }

	private void Start()
	{
		Gun.Instance = this;
		this.velHistory = new List<Vector3>();
		this.startPos = base.transform.localPosition;
		this.rb = PlayerMovement.Instance.GetRb();
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

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

	private void SpeedBob()
	{
		Vector2 vector = PlayerMovement.Instance.FindVelRelativeToLook();
		Vector3 vector2 = new Vector3(vector.x, PlayerMovement.Instance.GetVelocity().y, vector.y);
		vector2 *= -0.01f;
		vector2 = Vector3.ClampMagnitude(vector2, 0.6f);
		this.speedBob = Vector3.Lerp(this.speedBob, vector2, Time.deltaTime * 10f);
	}

	private void RecoilGun()
	{
		this.recoilOffset = Vector3.SmoothDamp(this.recoilOffset, Vector3.zero, ref this.recoilOffsetVel, 0.05f);
		this.recoilRotation = Vector3.SmoothDamp(this.recoilRotation, Vector3.zero, ref this.recoilRotVel, 0.07f);
	}

	public void Build()
	{
		this.recoilOffset += Vector3.down;
	}

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

	private Rigidbody rb;

	private Transform playerCam;

	private Vector3 startPos;

	private List<Vector3> velHistory;

	private Vector3 desiredBob;

	private float xBob = 0.12f;

	private float yBob = 0.08f;

	private float zBob = 0.1f;

	private float bobSpeed = 0.45f;

	private Vector3 recoilOffset;

	private Vector3 recoilRotation;

	private Vector3 recoilOffsetVel;

	private Vector3 recoilRotVel;

	private float reloadRotation;

	private float desiredReloadRotation;

	private float reloadTime;

	private float rVel;

	private float reloadPosOffset;

	private float rPVel;

	private float gunDrag = 0.2f;

	public float currentGunDragMultiplier = 1f;

	private float desX;

	private float desY;

	private Vector3 speedBob;

	private float reloadProgress;

	private int spins;
}
