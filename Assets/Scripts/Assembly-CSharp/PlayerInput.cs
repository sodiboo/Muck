using UnityEngine;

public class PlayerInput : MonoBehaviour
{
    private float xRotation;

    public static float sensMultiplier = 1f;

    private float desiredX;

    private float mouseScroll;

    private Transform playerCam;

    private Transform orientation;

    private PlayerMovement playerMovement;

    public bool active = true;

    private float actualWallRotation;

    private float wallRotationVel;

    public Vector3 cameraRot;

    private float wallRunRotation;

    public float mouseOffsetY;

    public float sensitivity { get; set; } = 50f;


    public float x { get; private set; }

    public float y { get; private set; }

    public bool jumping { get; private set; }

    public bool crouching { get; private set; }

    public bool sprinting { get; private set; }

    public static PlayerInput Instance { get; set; }

    private void Awake()
    {
        Instance = this;
        playerMovement = (PlayerMovement)GetComponent("PlayerMovement");
        playerCam = playerMovement.playerCam;
        orientation = playerMovement.orientation;
    }

    private void Update()
    {
        if (active)
        {
            if (GameManager.state == GameManager.GameState.GameOver)
            {
                StopInput();
                return;
            }
            MyInput();
            Look();
        }
    }

    private void FixedUpdate()
    {
        if (active)
        {
            playerMovement.Movement(x, y);
        }
    }

    private void StopInput()
    {
        x = 0f;
        y = 0f;
        jumping = false;
        sprinting = false;
        mouseScroll = 0f;
        playerMovement.SetInput(new Vector2(x, y), crouching, jumping, sprinting);
    }

    private void MyInput()
    {
        if (OtherInput.Instance.OtherUiActive() && !Map.Instance.active)
        {
            StopInput();
        }
        else if ((bool)playerMovement)
        {
            x = 0f;
            y = 0f;
            if (Input.GetKey(InputManager.forward))
            {
                y++;
            }
            else if (Input.GetKey(InputManager.backwards))
            {
                y--;
            }
            if (Input.GetKey(InputManager.left))
            {
                x--;
            }
            if (Input.GetKey(InputManager.right))
            {
                x++;
            }
            jumping = Input.GetKey(InputManager.jump);
            sprinting = Input.GetKey(InputManager.sprint);
            mouseScroll = Input.mouseScrollDelta.y;
            if (Input.GetKeyDown(InputManager.jump))
            {
                playerMovement.Jump();
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
            if (mouseScroll != 0f)
            {
                BuildManager.Instance.RotateBuild((int)Mathf.Sign(mouseScroll));
            }
            if (Input.GetKeyDown(KeyCode.R))
            {
                BuildManager.Instance.RotateBuild(1);
            }
            if (Input.GetKey(KeyCode.LeftShift) && Input.GetKey(KeyCode.U) && Input.GetKeyDown(KeyCode.I))
            {
                UiController.Instance.ToggleHud();
            }
            playerMovement.SetInput(new Vector2(x, y), crouching, jumping, sprinting);
        }
    }

    private void Look()
    {
        if (Cursor.lockState != 0 && !OtherInput.lockCamera)
        {
            float num = GetMouseX();
            float num2 = Input.GetAxis("Mouse Y") * sensitivity * 0.02f * sensMultiplier;
            if (CurrentSettings.invertedHor)
            {
                num = 0f - num;
            }
            if (CurrentSettings.invertedVer)
            {
                num2 = 0f - num2;
            }
            desiredX = playerCam.transform.localRotation.eulerAngles.y + num;
            xRotation -= num2;
            xRotation = Mathf.Clamp(xRotation, -90f, 90f);
            actualWallRotation = Mathf.SmoothDamp(actualWallRotation, wallRunRotation, ref wallRotationVel, 0.2f);
            cameraRot = new Vector3(xRotation, desiredX, actualWallRotation);
            orientation.transform.localRotation = Quaternion.Euler(0f, desiredX, 0f);
        }
    }

    public Vector2 GetAxisInput()
    {
        return new Vector2(x, y);
    }

    public float GetMouseX()
    {
        return Input.GetAxis("Mouse X") * sensitivity * 0.02f * sensMultiplier;
    }

    public void SetMouseOffset(float o)
    {
        xRotation = o;
    }

    public float GetMouseOffset()
    {
        return xRotation;
    }
}
