
using UnityEngine;

// Token: 0x020000B1 RID: 177
public class PlayerInput : MonoBehaviour
{
	// Token: 0x1700003E RID: 62
	// (get) Token: 0x06000595 RID: 1429 RVA: 0x0001C84B File Offset: 0x0001AA4B
	// (set) Token: 0x06000596 RID: 1430 RVA: 0x0001C852 File Offset: 0x0001AA52
	public static PlayerInput Instance { get; set; }

	// Token: 0x06000597 RID: 1431 RVA: 0x0001C85A File Offset: 0x0001AA5A
	private void Awake()
	{
		PlayerInput.Instance = this;
		this.playerMovement = (PlayerMovement)base.GetComponent("PlayerMovement");
		this.playerCam = this.playerMovement.playerCam;
		this.orientation = this.playerMovement.orientation;
	}

	// Token: 0x06000598 RID: 1432 RVA: 0x0001C89A File Offset: 0x0001AA9A
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		this.MyInput();
		this.Look();
	}

	// Token: 0x06000599 RID: 1433 RVA: 0x0001C8B1 File Offset: 0x0001AAB1
	private void FixedUpdate()
	{
		if (!this.active)
		{
			return;
		}
		this.playerMovement.Movement(this.x, this.y);
	}

	// Token: 0x0600059A RID: 1434 RVA: 0x0001C8D3 File Offset: 0x0001AAD3
	public void UpdateSensitivity(float s)
	{
		PlayerInput.sensMultiplier = s;
	}

	// Token: 0x0600059B RID: 1435 RVA: 0x0001C8DC File Offset: 0x0001AADC
	private void StopInput()
	{
		this.x = 0f;
		this.y = 0f;
		this.jumping = false;
		this.sprinting = false;
		this.mouseScroll = 0f;
		this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
	}

	// Token: 0x0600059C RID: 1436 RVA: 0x0001C948 File Offset: 0x0001AB48
	private void MyInput()
	{
		if (OtherInput.Instance.OtherUiActive() && !Map.Instance.active)
		{
			this.StopInput();
			return;
		}
		if (!this.playerMovement)
		{
			return;
		}
		this.x = 0f;
		this.y = 0f;
		if (Input.GetKey(InputManager.forward))
		{
			this.y += 1f;
		}
		else if (Input.GetKey(InputManager.backwards))
		{
			this.y -= 1f;
		}
		if (Input.GetKey(InputManager.left))
		{
			this.x -= 1f;
		}
		if (Input.GetKey(InputManager.right))
		{
			this.x += 1f;
		}
		this.jumping = Input.GetKey(InputManager.jump);
		this.sprinting = Input.GetKey(InputManager.sprint);
		this.mouseScroll = Input.mouseScrollDelta.y;
		if (Input.GetKeyDown(InputManager.jump))
		{
			this.playerMovement.Jump();
		}
		if (Input.GetKey(InputManager.leftClick))
		{
			UseInventory.Instance.Use();
		}
		if (Input.GetKeyUp(InputManager.leftClick))
		{
			UseInventory.Instance.UseButtonUp();
		}
		if (Input.GetKeyDown(InputManager.rightClick))
		{
			BuildManager.Instance.RequestBuildItem();
		}
		if (this.mouseScroll != 0f)
		{
			BuildManager.Instance.RotateBuild((int)Mathf.Sign(this.mouseScroll));
		}
		if (Input.GetKeyDown(KeyCode.R))
		{
			BuildManager.Instance.RotateBuild(1);
		}
		this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
	}

	// Token: 0x0600059D RID: 1437 RVA: 0x0001CB00 File Offset: 0x0001AD00
	private void Look()
	{
		if (Cursor.lockState == CursorLockMode.None)
		{
			return;
		}
		if (OtherInput.lockCamera)
		{
			return;
		}
		float num = this.GetMouseX();
		float num2 = Input.GetAxis("Mouse Y") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;
		if (CurrentSettings.inverted)
		{
			num = -num;
			num2 = -num2;
		}
		Vector3 eulerAngles = this.playerCam.transform.localRotation.eulerAngles;
		this.desiredX = eulerAngles.y + num;
		this.xRotation -= num2;
		this.xRotation = Mathf.Clamp(this.xRotation, -90f, 90f);
		this.actualWallRotation = Mathf.SmoothDamp(this.actualWallRotation, this.wallRunRotation, ref this.wallRotationVel, 0.2f);
		this.cameraRot = new Vector3(this.xRotation, this.desiredX, this.actualWallRotation);
		this.orientation.transform.localRotation = Quaternion.Euler(0f, this.desiredX, 0f);
	}

	// Token: 0x0600059E RID: 1438 RVA: 0x0001CC03 File Offset: 0x0001AE03
	public Vector2 GetAxisInput()
	{
		return new Vector2(this.x, this.y);
	}

	// Token: 0x0600059F RID: 1439 RVA: 0x0001CC16 File Offset: 0x0001AE16
	public float GetMouseX()
	{
		return Input.GetAxis("Mouse X") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;
	}

	// Token: 0x060005A0 RID: 1440 RVA: 0x0001CC35 File Offset: 0x0001AE35
	public void SetMouseOffset(float o)
	{
		this.xRotation = o;
	}

	// Token: 0x060005A1 RID: 1441 RVA: 0x0001CC3E File Offset: 0x0001AE3E
	public float GetMouseOffset()
	{
		return this.xRotation;
	}

	// Token: 0x040004E0 RID: 1248
	private float xRotation;

	// Token: 0x040004E1 RID: 1249
	private float sensitivity = 50f;

	// Token: 0x040004E2 RID: 1250
	public static float sensMultiplier = 1f;

	// Token: 0x040004E3 RID: 1251
	private float desiredX;

	// Token: 0x040004E4 RID: 1252
	private float x;

	// Token: 0x040004E5 RID: 1253
	private float y;

	// Token: 0x040004E6 RID: 1254
	private bool jumping;

	// Token: 0x040004E7 RID: 1255
	private bool crouching;

	// Token: 0x040004E8 RID: 1256
	private bool sprinting;

	// Token: 0x040004E9 RID: 1257
	private float mouseScroll;

	// Token: 0x040004EA RID: 1258
	private Transform playerCam;

	// Token: 0x040004EB RID: 1259
	private Transform orientation;

	// Token: 0x040004EC RID: 1260
	private PlayerMovement playerMovement;

	// Token: 0x040004EE RID: 1262
	public bool active = true;

	// Token: 0x040004EF RID: 1263
	private float actualWallRotation;

	// Token: 0x040004F0 RID: 1264
	private float wallRotationVel;

	// Token: 0x040004F1 RID: 1265
	public Vector3 cameraRot;

	// Token: 0x040004F2 RID: 1266
	private float wallRunRotation;

	// Token: 0x040004F3 RID: 1267
	public float mouseOffsetY;
}
