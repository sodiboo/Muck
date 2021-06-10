
using UnityEngine;

// Token: 0x020000B0 RID: 176
public class MoveCamera : MonoBehaviour
{
	// Token: 0x1700003C RID: 60
	// (get) Token: 0x06000582 RID: 1410 RVA: 0x0001C0ED File Offset: 0x0001A2ED
	// (set) Token: 0x06000583 RID: 1411 RVA: 0x0001C0F4 File Offset: 0x0001A2F4
	public static MoveCamera Instance { get; private set; }

	// Token: 0x06000584 RID: 1412 RVA: 0x0001C0FC File Offset: 0x0001A2FC
	private void Start()
	{
		MoveCamera.Instance = this;
		this.cam = base.transform.GetChild(0).GetComponent<Camera>();
		this.rb = PlayerMovement.Instance.GetRb();
	}

	// Token: 0x06000585 RID: 1413 RVA: 0x0001C12B File Offset: 0x0001A32B
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

	// Token: 0x1700003D RID: 61
	// (get) Token: 0x06000586 RID: 1414 RVA: 0x0001C15B File Offset: 0x0001A35B
	// (set) Token: 0x06000587 RID: 1415 RVA: 0x0001C163 File Offset: 0x0001A363
	public MoveCamera.CameraState state { get; set; }

	// Token: 0x06000588 RID: 1416 RVA: 0x0001C16C File Offset: 0x0001A36C
	public void PlayerRespawn(Vector3 pos)
	{
		base.transform.position = pos;
		this.state = MoveCamera.CameraState.Player;
		base.transform.parent = null;
		base.CancelInvoke("SpectateCamera");
	}

	// Token: 0x06000589 RID: 1417 RVA: 0x0001C198 File Offset: 0x0001A398
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

	// Token: 0x0600058A RID: 1418 RVA: 0x0001C1F0 File Offset: 0x0001A3F0
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

	// Token: 0x0600058B RID: 1419 RVA: 0x0001C220 File Offset: 0x0001A420
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

	// Token: 0x0600058C RID: 1420 RVA: 0x0001C47C File Offset: 0x0001A67C
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

	// Token: 0x0600058D RID: 1421 RVA: 0x0001C528 File Offset: 0x0001A728
	private void PlayerDeathCamera()
	{
		base.transform.position = Vector3.Lerp(base.transform.position, this.desiredDeathPos, Time.deltaTime * 1f);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.LookRotation(this.target.position - base.transform.position), Time.deltaTime);
	}

	// Token: 0x0600058E RID: 1422 RVA: 0x0001C5A4 File Offset: 0x0001A7A4
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

	// Token: 0x0600058F RID: 1423 RVA: 0x0001C700 File Offset: 0x0001A900
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

	// Token: 0x06000590 RID: 1424 RVA: 0x0001C751 File Offset: 0x0001A951
	public void UpdateFov(float f)
	{
		this.mainCam.fieldOfView = f;
	}

	// Token: 0x06000591 RID: 1425 RVA: 0x0001C760 File Offset: 0x0001A960
	public void BobOnce(Vector3 bobDirection)
	{
		Vector3 a = this.ClampVector(bobDirection * 0.15f, -3f, 3f);
		this.desiredBob = a * this.bobMultiplier;
	}

	// Token: 0x06000592 RID: 1426 RVA: 0x0001C79C File Offset: 0x0001A99C
	private void UpdateBob()
	{
		this.desiredBob = Vector3.Lerp(this.desiredBob, Vector3.zero, Time.deltaTime * this.bobSpeed * 0.5f);
		this.bobOffset = Vector3.Lerp(this.bobOffset, this.desiredBob, Time.deltaTime * this.bobSpeed);
	}

	// Token: 0x06000593 RID: 1427 RVA: 0x0001C7F4 File Offset: 0x0001A9F4
	private Vector3 ClampVector(Vector3 vec, float min, float max)
	{
		return new Vector3(Mathf.Clamp(vec.x, min, max), Mathf.Clamp(vec.y, min, max), Mathf.Clamp(vec.z, min, max));
	}

	// Token: 0x040004C8 RID: 1224
	public Transform player;

	// Token: 0x040004C9 RID: 1225
	public Vector3 offset;

	// Token: 0x040004CA RID: 1226
	public Vector3 desyncOffset;

	// Token: 0x040004CB RID: 1227
	public Vector3 vaultOffset;

	// Token: 0x040004CC RID: 1228
	private Camera cam;

	// Token: 0x040004CD RID: 1229
	private Rigidbody rb;

	// Token: 0x040004CE RID: 1230
	public PlayerInput playerInput;

	// Token: 0x040004D0 RID: 1232
	public bool cinematic;

	// Token: 0x040004D1 RID: 1233
	private float desiredTilt;

	// Token: 0x040004D2 RID: 1234
	private float tilt;

	// Token: 0x040004D4 RID: 1236
	private Vector3 desiredDeathPos;

	// Token: 0x040004D5 RID: 1237
	private Transform target;

	// Token: 0x040004D6 RID: 1238
	private Vector3 desiredSpectateRotation;

	// Token: 0x040004D7 RID: 1239
	private Transform playerTarget;

	// Token: 0x040004D8 RID: 1240
	public LayerMask whatIsGround;

	// Token: 0x040004D9 RID: 1241
	private int spectatingId;

	// Token: 0x040004DA RID: 1242
	private Vector3 desiredBob;

	// Token: 0x040004DB RID: 1243
	private Vector3 bobOffset;

	// Token: 0x040004DC RID: 1244
	private float bobSpeed = 15f;

	// Token: 0x040004DD RID: 1245
	private float bobMultiplier = 1f;

	// Token: 0x040004DE RID: 1246
	private readonly float bobConstant = 0.2f;

	// Token: 0x040004DF RID: 1247
	public Camera mainCam;

	// Token: 0x0200012E RID: 302
	public enum CameraState
	{
		// Token: 0x040007B9 RID: 1977
		Player,
		// Token: 0x040007BA RID: 1978
		PlayerDeath,
		// Token: 0x040007BB RID: 1979
		Spectate
	}
}
