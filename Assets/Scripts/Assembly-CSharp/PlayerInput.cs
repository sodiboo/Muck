using System;
using UnityEngine;

// Token: 0x020000EC RID: 236
public class PlayerInput : MonoBehaviour
{
	// Token: 0x17000047 RID: 71
	// (get) Token: 0x06000628 RID: 1576 RVA: 0x00005E68 File Offset: 0x00004068
	// (set) Token: 0x06000629 RID: 1577 RVA: 0x00005E6F File Offset: 0x0000406F
	public static PlayerInput Instance { get; set; }

	// Token: 0x0600062A RID: 1578 RVA: 0x00005E77 File Offset: 0x00004077
	private void Awake()
	{
		PlayerInput.Instance = this;
		this.playerMovement = (PlayerMovement)base.GetComponent("PlayerMovement");
		this.playerCam = this.playerMovement.playerCam;
		this.orientation = this.playerMovement.orientation;
	}

	// Token: 0x0600062B RID: 1579 RVA: 0x00005EB7 File Offset: 0x000040B7
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		this.MyInput();
		this.Look();
	}

	// Token: 0x0600062C RID: 1580 RVA: 0x00005ECE File Offset: 0x000040CE
	private void FixedUpdate()
	{
		if (!this.active)
		{
			return;
		}
		this.playerMovement.Movement(this.x, this.y);
	}

	// Token: 0x0600062D RID: 1581 RVA: 0x00005EF0 File Offset: 0x000040F0
	public void UpdateSensitivity(float s)
	{
		PlayerInput.sensMultiplier = s;
	}

	// Token: 0x0600062E RID: 1582 RVA: 0x000207C8 File Offset: 0x0001E9C8
	private void StopInput()
	{
		this.x = 0f;
		this.y = 0f;
		this.jumping = false;
		this.sprinting = false;
		this.mouseScroll = 0f;
		this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
	}

	// Token: 0x0600062F RID: 1583 RVA: 0x00020834 File Offset: 0x0001EA34
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

	// Token: 0x06000630 RID: 1584 RVA: 0x000209EC File Offset: 0x0001EBEC
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

	// Token: 0x06000631 RID: 1585 RVA: 0x00005EF8 File Offset: 0x000040F8
	public Vector2 GetAxisInput()
	{
		return new Vector2(this.x, this.y);
	}

	// Token: 0x06000632 RID: 1586 RVA: 0x00005F0B File Offset: 0x0000410B
	public float GetMouseX()
	{
		return Input.GetAxis("Mouse X") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;
	}

	// Token: 0x06000633 RID: 1587 RVA: 0x00005F2A File Offset: 0x0000412A
	public void SetMouseOffset(float o)
	{
		this.xRotation = o;
	}

	// Token: 0x06000634 RID: 1588 RVA: 0x00005F33 File Offset: 0x00004133
	public float GetMouseOffset()
	{
		return this.xRotation;
	}

	// Token: 0x040005DC RID: 1500
	private float xRotation;

	// Token: 0x040005DD RID: 1501
	private float sensitivity = 50f;

	// Token: 0x040005DE RID: 1502
	public static float sensMultiplier = 1f;

	// Token: 0x040005DF RID: 1503
	private float desiredX;

	// Token: 0x040005E0 RID: 1504
	private float x;

	// Token: 0x040005E1 RID: 1505
	private float y;

	// Token: 0x040005E2 RID: 1506
	private bool jumping;

	// Token: 0x040005E3 RID: 1507
	private bool crouching;

	// Token: 0x040005E4 RID: 1508
	private bool sprinting;

	// Token: 0x040005E5 RID: 1509
	private float mouseScroll;

	// Token: 0x040005E6 RID: 1510
	private Transform playerCam;

	// Token: 0x040005E7 RID: 1511
	private Transform orientation;

	// Token: 0x040005E8 RID: 1512
	private PlayerMovement playerMovement;

	// Token: 0x040005EA RID: 1514
	public bool active = true;

	// Token: 0x040005EB RID: 1515
	private float actualWallRotation;

	// Token: 0x040005EC RID: 1516
	private float wallRotationVel;

	// Token: 0x040005ED RID: 1517
	public Vector3 cameraRot;

	// Token: 0x040005EE RID: 1518
	private float wallRunRotation;

	// Token: 0x040005EF RID: 1519
	public float mouseOffsetY;
}
