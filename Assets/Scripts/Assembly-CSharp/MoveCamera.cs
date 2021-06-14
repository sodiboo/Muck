using System;
using UnityEngine;

// Token: 0x020000EA RID: 234
public class MoveCamera : MonoBehaviour
{
	// Token: 0x17000045 RID: 69
	// (get) Token: 0x06000615 RID: 1557 RVA: 0x00005D4C File Offset: 0x00003F4C
	// (set) Token: 0x06000616 RID: 1558 RVA: 0x00005D53 File Offset: 0x00003F53
	public static MoveCamera Instance { get; private set; }

	// Token: 0x06000617 RID: 1559 RVA: 0x00020130 File Offset: 0x0001E330
	private void Start()
	{
		MoveCamera.Instance = this;
		this.cam = base.transform.GetChild(0).GetComponent<Camera>();
		this.rb = PlayerMovement.Instance.GetRb();
		this.UpdateFov((float)CurrentSettings.Instance.fov);
		Debug.LogError("updating fov: " + CurrentSettings.Instance.fov);
	}

	// Token: 0x06000618 RID: 1560 RVA: 0x00005D5B File Offset: 0x00003F5B
	private void LateUpdate()
	{
		if (this.state == MoveCamera.CameraState.Player)
		{
			this.PlayerCamera();
			return;
		}
		if (this.state == MoveCamera.CameraState.PlayerDeath)
		{
			this.PlayerDeathCamera();
			return;
		}
		if (this.state == MoveCamera.CameraState.Spectate)
		{
			this.SpectateCamera();
		}
	}

	// Token: 0x17000046 RID: 70
	// (get) Token: 0x06000619 RID: 1561 RVA: 0x00005D8B File Offset: 0x00003F8B
	// (set) Token: 0x0600061A RID: 1562 RVA: 0x00005D93 File Offset: 0x00003F93
	public MoveCamera.CameraState state { get; set; }

	// Token: 0x0600061B RID: 1563 RVA: 0x00005D9C File Offset: 0x00003F9C
	public void PlayerRespawn(Vector3 pos)
	{
		base.transform.position = pos;
		this.state = MoveCamera.CameraState.Player;
		base.transform.parent = null;
		base.CancelInvoke("SpectateCamera");
	}

	// Token: 0x0600061C RID: 1564 RVA: 0x0002019C File Offset: 0x0001E39C
	public void PlayerDied(Transform ragdoll)
	{
		this.target = ragdoll;
		this.state = MoveCamera.CameraState.PlayerDeath;
		this.desiredDeathPos = base.transform.position + Vector3.up * 3f;
		if (GameManager.state != GameManager.GameState.GameOver)
		{
			base.Invoke("StartSpectating", 4f);
		}
	}

	// Token: 0x0600061D RID: 1565 RVA: 0x00005DC8 File Offset: 0x00003FC8
	private void StartSpectating()
	{
		if (GameManager.state == GameManager.GameState.GameOver || !PlayerStatus.Instance.IsPlayerDead())
		{
			return;
		}
		this.target = null;
		this.state = MoveCamera.CameraState.Spectate;
		PPController.Instance.Reset();
	}

	// Token: 0x0600061E RID: 1566 RVA: 0x000201F4 File Offset: 0x0001E3F4
	private void SpectateCamera()
	{
		if (!this.target)
		{
			foreach (PlayerManager playerManager in GameManager.players.Values)
			{
				if (!(playerManager == null) && !playerManager.dead)
				{
					this.target = new GameObject("cameraOrbit").transform;
					this.playerTarget = playerManager.transform;
					base.transform.parent = this.target;
					base.transform.localRotation = Quaternion.identity;
					base.transform.localPosition = new Vector3(0f, 0f, -10f);
					this.spectatingId = playerManager.id;
				}
			}
			if (!this.target)
			{
				return;
			}
		}
		Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
		this.desiredSpectateRotation += new Vector3(-vector.y, vector.x, 0f) * 1.5f;
		if (Input.GetKeyDown(InputManager.rightClick))
		{
			this.SpectateToggle(1);
		}
		else if (Input.GetKeyDown(InputManager.leftClick))
		{
			this.SpectateToggle(-1);
		}
		this.target.position = this.playerTarget.position;
		this.target.rotation = Quaternion.Lerp(this.target.rotation, Quaternion.Euler(this.desiredSpectateRotation), Time.deltaTime * 10f);
		Vector3 direction = base.transform.position - this.target.position;
		RaycastHit raycastHit;
		float num;
		if (Physics.Raycast(this.target.position, direction, out raycastHit, 10f, this.whatIsGround))
		{
			Debug.DrawLine(this.target.position, raycastHit.point);
			num = 10f - raycastHit.distance + 0.8f;
			num = Mathf.Clamp(num, 0f, 10f);
		}
		else
		{
			num = 0f;
		}
		base.transform.localPosition = new Vector3(0f, 0f, -10f + num);
	}

	// Token: 0x0600061F RID: 1567 RVA: 0x00020450 File Offset: 0x0001E650
	private void SpectateToggle(int dir)
	{
		int num = this.spectatingId;
		for (int i = 0; i < GameManager.players.Count; i++)
		{
			if (!(GameManager.players[i] == null))
			{
				PlayerManager playerManager = GameManager.players[i];
				if (!(playerManager == null) && !playerManager.dead)
				{
					if (dir > 0 && playerManager.id > num)
					{
						this.spectatingId = playerManager.id;
						this.playerTarget = playerManager.transform;
						return;
					}
					if (dir < 0 && playerManager.id < num)
					{
						this.spectatingId = playerManager.id;
						this.playerTarget = playerManager.transform;
						return;
					}
				}
			}
		}
	}

	// Token: 0x06000620 RID: 1568 RVA: 0x000204FC File Offset: 0x0001E6FC
	private void PlayerDeathCamera()
	{
		if (this.target == null)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredDeathPos, Time.deltaTime * 1f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.LookRotation(this.target.position - base.transform.position), Time.deltaTime);
	}

	// Token: 0x06000621 RID: 1569 RVA: 0x00020584 File Offset: 0x0001E784
	private void PlayerCamera()
	{
		this.UpdateBob();
		this.MoveGun();
		base.transform.position = this.player.transform.position + this.bobOffset + this.desyncOffset + this.vaultOffset + this.offset;
		if (this.cinematic)
		{
			return;
		}
		Vector3 cameraRot = this.playerInput.cameraRot;
		cameraRot.x = Mathf.Clamp(cameraRot.x, -90f, 90f);
		base.transform.rotation = Quaternion.Euler(cameraRot);
		this.desyncOffset = Vector3.Lerp(this.desyncOffset, Vector3.zero, Time.deltaTime * 15f);
		this.vaultOffset = Vector3.Slerp(this.vaultOffset, Vector3.zero, Time.deltaTime * 7f);
		if (PlayerMovement.Instance.IsCrouching())
		{
			this.desiredTilt = 6f;
		}
		else
		{
			this.desiredTilt = 0f;
		}
		this.tilt = Mathf.Lerp(this.tilt, this.desiredTilt, Time.deltaTime * 8f);
		Vector3 eulerAngles = base.transform.rotation.eulerAngles;
		eulerAngles.z = this.tilt;
		base.transform.rotation = Quaternion.Euler(eulerAngles);
	}

	// Token: 0x06000622 RID: 1570 RVA: 0x000206E0 File Offset: 0x0001E8E0
	private void MoveGun()
	{
		if (!this.rb)
		{
			return;
		}
		if (Mathf.Abs(this.rb.velocity.magnitude) >= 4f && PlayerMovement.Instance.grounded)
		{
			PlayerMovement.Instance.IsCrouching();
		}
	}

	// Token: 0x06000623 RID: 1571 RVA: 0x00005DF7 File Offset: 0x00003FF7
	public void UpdateFov(float f)
	{
		this.mainCam.fieldOfView = f;
		this.gunCamera.fieldOfView = f;
	}

	// Token: 0x06000624 RID: 1572 RVA: 0x00020734 File Offset: 0x0001E934
	public void BobOnce(Vector3 bobDirection)
	{
		Vector3 a = this.ClampVector(bobDirection * 0.15f, -3f, 3f);
		this.desiredBob = a * this.bobMultiplier;
	}

	// Token: 0x06000625 RID: 1573 RVA: 0x00020770 File Offset: 0x0001E970
	private void UpdateBob()
	{
		this.desiredBob = Vector3.Lerp(this.desiredBob, Vector3.zero, Time.deltaTime * this.bobSpeed * 0.5f);
		this.bobOffset = Vector3.Lerp(this.bobOffset, this.desiredBob, Time.deltaTime * this.bobSpeed);
	}

	// Token: 0x06000626 RID: 1574 RVA: 0x00005E11 File Offset: 0x00004011
	private Vector3 ClampVector(Vector3 vec, float min, float max)
	{
		return new Vector3(Mathf.Clamp(vec.x, min, max), Mathf.Clamp(vec.y, min, max), Mathf.Clamp(vec.z, min, max));
	}

	// Token: 0x040005BF RID: 1471
	public Transform player;

	// Token: 0x040005C0 RID: 1472
	public Vector3 offset;

	// Token: 0x040005C1 RID: 1473
	public Vector3 desyncOffset;

	// Token: 0x040005C2 RID: 1474
	public Vector3 vaultOffset;

	// Token: 0x040005C3 RID: 1475
	private Camera cam;

	// Token: 0x040005C4 RID: 1476
	private Rigidbody rb;

	// Token: 0x040005C5 RID: 1477
	public PlayerInput playerInput;

	// Token: 0x040005C7 RID: 1479
	public bool cinematic;

	// Token: 0x040005C8 RID: 1480
	private float desiredTilt;

	// Token: 0x040005C9 RID: 1481
	private float tilt;

	// Token: 0x040005CB RID: 1483
	private Vector3 desiredDeathPos;

	// Token: 0x040005CC RID: 1484
	private Transform target;

	// Token: 0x040005CD RID: 1485
	private Vector3 desiredSpectateRotation;

	// Token: 0x040005CE RID: 1486
	private Transform playerTarget;

	// Token: 0x040005CF RID: 1487
	public LayerMask whatIsGround;

	// Token: 0x040005D0 RID: 1488
	private int spectatingId;

	// Token: 0x040005D1 RID: 1489
	private Vector3 desiredBob;

	// Token: 0x040005D2 RID: 1490
	private Vector3 bobOffset;

	// Token: 0x040005D3 RID: 1491
	private float bobSpeed = 15f;

	// Token: 0x040005D4 RID: 1492
	private float bobMultiplier = 1f;

	// Token: 0x040005D5 RID: 1493
	private readonly float bobConstant = 0.2f;

	// Token: 0x040005D6 RID: 1494
	public Camera mainCam;

	// Token: 0x040005D7 RID: 1495
	public Camera gunCamera;

	// Token: 0x020000EB RID: 235
	public enum CameraState
	{
		// Token: 0x040005D9 RID: 1497
		Player,
		// Token: 0x040005DA RID: 1498
		PlayerDeath,
		// Token: 0x040005DB RID: 1499
		Spectate
	}
}
