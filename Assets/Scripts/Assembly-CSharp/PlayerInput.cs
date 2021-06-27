using System;
using UnityEngine;

// Token: 0x020000D9 RID: 217
public class PlayerInput : MonoBehaviour
{
	// Token: 0x1700004B RID: 75
	// (get) Token: 0x060006A0 RID: 1696 RVA: 0x00022453 File Offset: 0x00020653
	// (set) Token: 0x060006A1 RID: 1697 RVA: 0x0002245A File Offset: 0x0002065A
	public static PlayerInput Instance { get; set; }

	// Token: 0x060006A2 RID: 1698 RVA: 0x00022462 File Offset: 0x00020662
	private void Awake()
	{
		PlayerInput.Instance = this;
		this.playerMovement = (PlayerMovement)base.GetComponent("PlayerMovement");
		this.playerCam = this.playerMovement.playerCam;
		this.orientation = this.playerMovement.orientation;
	}

	// Token: 0x060006A3 RID: 1699 RVA: 0x000224A2 File Offset: 0x000206A2
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		if (GameManager.state == GameManager.GameState.GameOver)
		{
			this.StopInput();
			return;
		}
		this.MyInput();
		this.Look();
	}

	// Token: 0x060006A4 RID: 1700 RVA: 0x000224C8 File Offset: 0x000206C8
	private void FixedUpdate()
	{
		if (!this.active)
		{
			return;
		}
		this.playerMovement.Movement(this.x, this.y);
	}

	// Token: 0x060006A5 RID: 1701 RVA: 0x000224EC File Offset: 0x000206EC
	private void StopInput()
	{
		this.x = 0f;
		this.y = 0f;
		this.jumping = false;
		this.sprinting = false;
		this.mouseScroll = 0f;
		this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
	}

	// Token: 0x060006A6 RID: 1702 RVA: 0x00022558 File Offset: 0x00020758
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
		if (Input.GetKey(KeyCode.LeftShift) && Input.GetKey(KeyCode.U) && Input.GetKeyDown(KeyCode.I))
		{
			UiController.Instance.ToggleHud();
		}
		this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
	}

	// Token: 0x060006A7 RID: 1703 RVA: 0x00022738 File Offset: 0x00020938
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
		if (CurrentSettings.invertedHor)
		{
			num = -num;
		}
		if (CurrentSettings.invertedVer)
		{
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

	// Token: 0x060006A8 RID: 1704 RVA: 0x00022842 File Offset: 0x00020A42
	public Vector2 GetAxisInput()
	{
		return new Vector2(this.x, this.y);
	}

	// Token: 0x060006A9 RID: 1705 RVA: 0x00022855 File Offset: 0x00020A55
	public float GetMouseX()
	{
		return Input.GetAxis("Mouse X") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;
	}

	// Token: 0x060006AA RID: 1706 RVA: 0x00022874 File Offset: 0x00020A74
	public void SetMouseOffset(float o)
	{
		this.xRotation = o;
	}

	// Token: 0x060006AB RID: 1707 RVA: 0x0002287D File Offset: 0x00020A7D
	public float GetMouseOffset()
	{
		return this.xRotation;
	}

	// Token: 0x040005F9 RID: 1529
	private float xRotation;

	// Token: 0x040005FA RID: 1530
	private float sensitivity = 50f;

	// Token: 0x040005FB RID: 1531
	public static float sensMultiplier = 1f;

	// Token: 0x040005FC RID: 1532
	private float desiredX;

	// Token: 0x040005FD RID: 1533
	private float x;

	// Token: 0x040005FE RID: 1534
	private float y;

	// Token: 0x040005FF RID: 1535
	private bool jumping;

	// Token: 0x04000600 RID: 1536
	private bool crouching;

	// Token: 0x04000601 RID: 1537
	private bool sprinting;

	// Token: 0x04000602 RID: 1538
	private float mouseScroll;

	// Token: 0x04000603 RID: 1539
	private Transform playerCam;

	// Token: 0x04000604 RID: 1540
	private Transform orientation;

	// Token: 0x04000605 RID: 1541
	private PlayerMovement playerMovement;

	// Token: 0x04000607 RID: 1543
	public bool active = true;

	// Token: 0x04000608 RID: 1544
	private float actualWallRotation;

	// Token: 0x04000609 RID: 1545
	private float wallRotationVel;

	// Token: 0x0400060A RID: 1546
	public Vector3 cameraRot;

	// Token: 0x0400060B RID: 1547
	private float wallRunRotation;

	// Token: 0x0400060C RID: 1548
	public float mouseOffsetY;
}
