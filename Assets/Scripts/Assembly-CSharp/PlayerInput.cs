using System;
using UnityEngine;

public class PlayerInput : MonoBehaviour
{
    public static PlayerInput Instance { get; set; }

    private void Awake()
    {
        PlayerInput.Instance = this;
        this.playerMovement = (PlayerMovement)base.GetComponent("PlayerMovement");
        this.playerCam = this.playerMovement.playerCam;
        this.orientation = this.playerMovement.orientation;
    }

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

    private void FixedUpdate()
    {
        if (!this.active)
        {
            return;
        }
        if (OtherInput.Instance.currentCar != null)
        {
            playerMovement.GetRb().position = OtherInput.Instance.currentCar.rb.position;
        }
        else
        {
            playerMovement.Movement(this.x, this.y);
        }
    }

    private void StopInput()
    {
        this.x = 0f;
        this.y = 0f;
        this.jumping = false;
        this.sprinting = false;
        this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
    }

    private void MyInput()
    {
        if (OtherInput.Instance.OtherUiActive() && !Map.Instance.active)
        {
            this.StopInput();
            return;
        }
        if (Input.GetKey(KeyCode.LeftShift) && Input.GetKey(KeyCode.U) && Input.GetKeyDown(KeyCode.I))
        {
            UiController.Instance.ToggleHud();
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
        if (OtherInput.Instance.currentCar)
        {
            OtherInput.Instance.currentCar.throttle = this.y;
            OtherInput.Instance.currentCar.steering = this.x;
            OtherInput.Instance.currentCar.breaking = Input.GetKey(InputManager.jump);
            return;
        }

        if (!this.playerMovement) return;
        this.jumping = Input.GetKey(InputManager.jump);
        this.sprinting = Input.GetKey(InputManager.sprint);
        this.crouching = Input.GetKey(InputManager.crouch);
        if (Input.GetKeyDown(InputManager.jump))
        {
            this.playerMovement.Jump();
        }
        if (!OtherInput.Instance.IsAnyMenuOpen())
        {
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
            if (Input.GetKeyDown(InputManager.rotate) && !Input.GetKey(InputManager.precisionRotate))
            {
                if (BuildManager.Instance.xRot != 0 || BuildManager.Instance.yRot % 45 != 0)
                {
                    BuildManager.Instance.xRot = 0;
                    BuildManager.Instance.yRot = 0;
                }
                else
                {
                    BuildManager.Instance.RotateBuild(1);
                }
            }
        }
        this.playerMovement.SetInput(new Vector2(this.x, this.y), this.crouching, this.jumping, this.sprinting);
    }

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
        float x = this.GetMouseX();
        float y = Input.GetAxis("Mouse Y") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;

        if (Input.GetKey(InputManager.precisionRotate) && Hotbar.Instance.currentItem && Hotbar.Instance.currentItem.buildable)
        {
            if (CurrentSettings.invertedRotate.x) x = -x;
            if (CurrentSettings.invertedRotate.y) y = -y;
            BuildManager.Instance.xRot -= y;
            BuildManager.Instance.yRot -= x;
            return;
        }

        if (CurrentSettings.invertedMouse.x) x = -x;
        if (CurrentSettings.invertedMouse.y) y = -y;
        Vector3 eulerAngles = this.playerCam.transform.localRotation.eulerAngles;
        this.desiredX = eulerAngles.y + x;
        this.xRotation -= y;
        this.xRotation = Mathf.Clamp(this.xRotation, -90f, 90f);
        this.actualWallRotation = Mathf.SmoothDamp(this.actualWallRotation, this.wallRunRotation, ref this.wallRotationVel, 0.2f);
        this.cameraRot = new Vector3(this.xRotation, this.desiredX, this.actualWallRotation);
        this.orientation.transform.localRotation = Quaternion.Euler(0f, this.desiredX, 0f);
    }

    public Vector2 GetAxisInput()
    {
        return new Vector2(this.x, this.y);
    }

    public float GetMouseX()
    {
        return Input.GetAxis("Mouse X") * this.sensitivity * 0.02f * PlayerInput.sensMultiplier;
    }

    public void SetMouseOffset(float o)
    {
        this.xRotation = o;
    }

    public float GetMouseOffset()
    {
        return this.xRotation;
    }

    private float xRotation;

    private float sensitivity = 50f;

    public static float sensMultiplier = 1f;

    private float desiredX;

    private float x;

    private float y;

    private bool jumping;

    private bool crouching;

    private bool sprinting;

    private Transform playerCam;

    private Transform orientation;

    private PlayerMovement playerMovement;

    public bool active = true;

    private float actualWallRotation;

    private float wallRotationVel;

    public Vector3 cameraRot;

    private float wallRunRotation;

    public float mouseOffsetY;
}
