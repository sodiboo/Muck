using System;
using UnityEngine;

// Token: 0x020000D8 RID: 216
public class MoveCamera : MonoBehaviour
{
	// Token: 0x17000049 RID: 73
	// (get) Token: 0x0600068D RID: 1677 RVA: 0x00021C95 File Offset: 0x0001FE95
	// (set) Token: 0x0600068E RID: 1678 RVA: 0x00021C9C File Offset: 0x0001FE9C
	public static MoveCamera Instance { get; private set; }

	// Token: 0x0600068F RID: 1679 RVA: 0x00021CA4 File Offset: 0x0001FEA4
	private void Start()
	{
		MoveCamera.Instance = this;
		this.cam = base.transform.GetChild(0).GetComponent<Camera>();
		this.rb = PlayerMovement.Instance.GetRb();
		this.UpdateFov((float)CurrentSettings.Instance.fov);
		Debug.LogError("updating fov: " + CurrentSettings.Instance.fov);
	}

	// Token: 0x06000690 RID: 1680 RVA: 0x00021D0D File Offset: 0x0001FF0D
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

	// Token: 0x1700004A RID: 74
	// (get) Token: 0x06000691 RID: 1681 RVA: 0x00021D3D File Offset: 0x0001FF3D
	// (set) Token: 0x06000692 RID: 1682 RVA: 0x00021D45 File Offset: 0x0001FF45
	public MoveCamera.CameraState state { get; set; }

	// Token: 0x06000693 RID: 1683 RVA: 0x00021D4E File Offset: 0x0001FF4E
	public void PlayerRespawn(Vector3 pos)
	{
		base.transform.position = pos;
		this.state = MoveCamera.CameraState.Player;
		base.transform.parent = null;
		base.CancelInvoke("SpectateCamera");
	}

	// Token: 0x06000694 RID: 1684 RVA: 0x00021D7C File Offset: 0x0001FF7C
	public void PlayerDied(Transform ragdoll)
	{
		this.target = ragdoll;
		this.state = MoveCamera.CameraState.PlayerDeath;
		this.desiredDeathPos = base.transform.position + Vector3.up * 3f;
		if (GameManager.state != GameManager.GameState.GameOver)
		{
			Invoke(nameof(StartSpectating), 4f);
		}
	}

	// Token: 0x06000695 RID: 1685 RVA: 0x00021DD4 File Offset: 0x0001FFD4
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

	// Token: 0x06000696 RID: 1686 RVA: 0x00021E04 File Offset: 0x00020004
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

	// Token: 0x06000697 RID: 1687 RVA: 0x00022060 File Offset: 0x00020260
	private void SpectateToggle(int dir)
	{
		int num = this.spectatingId;
		for (int i = 0; i < GameManager.players.Count; i++)
		{
			if (GameManager.players.ContainsKey(i) && !(GameManager.players[i] == null))
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

	// Token: 0x06000698 RID: 1688 RVA: 0x00022118 File Offset: 0x00020318
	private void PlayerDeathCamera()
	{
		if (this.target == null)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredDeathPos, Time.deltaTime * 1f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.LookRotation(this.target.position - base.transform.position), Time.deltaTime);
	}

	// Token: 0x06000699 RID: 1689 RVA: 0x000221A0 File Offset: 0x000203A0
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

	// Token: 0x0600069A RID: 1690 RVA: 0x000222FC File Offset: 0x000204FC
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

	// Token: 0x0600069B RID: 1691 RVA: 0x0002234D File Offset: 0x0002054D
	public void UpdateFov(float f)
	{
		this.mainCam.fieldOfView = f;
		this.gunCamera.fieldOfView = f;
	}

	// Token: 0x0600069C RID: 1692 RVA: 0x00022368 File Offset: 0x00020568
	public void BobOnce(Vector3 bobDirection)
	{
		Vector3 a = this.ClampVector(bobDirection * 0.15f, -3f, 3f);
		this.desiredBob = a * this.bobMultiplier;
	}

	// Token: 0x0600069D RID: 1693 RVA: 0x000223A4 File Offset: 0x000205A4
	private void UpdateBob()
	{
		this.desiredBob = Vector3.Lerp(this.desiredBob, Vector3.zero, Time.deltaTime * this.bobSpeed * 0.5f);
		this.bobOffset = Vector3.Lerp(this.bobOffset, this.desiredBob, Time.deltaTime * this.bobSpeed);
	}

	// Token: 0x0600069E RID: 1694 RVA: 0x000223FC File Offset: 0x000205FC
	private Vector3 ClampVector(Vector3 vec, float min, float max)
	{
		return new Vector3(Mathf.Clamp(vec.x, min, max), Mathf.Clamp(vec.y, min, max), Mathf.Clamp(vec.z, min, max));
	}

	// Token: 0x040005E0 RID: 1504
	public Transform player;

	// Token: 0x040005E1 RID: 1505
	public Vector3 offset;

	// Token: 0x040005E2 RID: 1506
	public Vector3 desyncOffset;

	// Token: 0x040005E3 RID: 1507
	public Vector3 vaultOffset;

	// Token: 0x040005E4 RID: 1508
	private Camera cam;

	// Token: 0x040005E5 RID: 1509
	private Rigidbody rb;

	// Token: 0x040005E6 RID: 1510
	public PlayerInput playerInput;

	// Token: 0x040005E8 RID: 1512
	public bool cinematic;

	// Token: 0x040005E9 RID: 1513
	private float desiredTilt;

	// Token: 0x040005EA RID: 1514
	private float tilt;

	// Token: 0x040005EC RID: 1516
	private Vector3 desiredDeathPos;

	// Token: 0x040005ED RID: 1517
	private Transform target;

	// Token: 0x040005EE RID: 1518
	private Vector3 desiredSpectateRotation;

	// Token: 0x040005EF RID: 1519
	private Transform playerTarget;

	// Token: 0x040005F0 RID: 1520
	public LayerMask whatIsGround;

	// Token: 0x040005F1 RID: 1521
	private int spectatingId;

	// Token: 0x040005F2 RID: 1522
	private Vector3 desiredBob;

	// Token: 0x040005F3 RID: 1523
	private Vector3 bobOffset;

	// Token: 0x040005F4 RID: 1524
	private float bobSpeed = 15f;

	// Token: 0x040005F5 RID: 1525
	private float bobMultiplier = 1f;

	// Token: 0x040005F6 RID: 1526
	private readonly float bobConstant = 0.2f;

	// Token: 0x040005F7 RID: 1527
	public Camera mainCam;

	// Token: 0x040005F8 RID: 1528
	public Camera gunCamera;

	// Token: 0x0200016C RID: 364
	public enum CameraState
	{
		// Token: 0x04000935 RID: 2357
		Player,
		// Token: 0x04000936 RID: 2358
		PlayerDeath,
		// Token: 0x04000937 RID: 2359
		Spectate
	}
}
