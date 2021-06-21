using System;
using UnityEngine;


public class MoveCamera : MonoBehaviour
{



    public static MoveCamera Instance { get; private set; }


    private void Start()
    {
        MoveCamera.Instance = this;
        this.cam = base.transform.GetChild(0).GetComponent<Camera>();
        this.rb = PlayerMovement.Instance.GetRb();
        this.UpdateFov((float)CurrentSettings.Instance.fov);
        Debug.LogError("updating fov: " + CurrentSettings.Instance.fov);
    }


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
		if (this.state == MoveCamera.CameraState.Car) {
			this.CarCamera();
		}
    }




    public MoveCamera.CameraState state { get; set; }


    public void PlayerRespawn(Vector3 pos)
    {
        base.transform.position = pos;
        this.state = MoveCamera.CameraState.Player;
        base.transform.parent = null;
        base.CancelInvoke(nameof(SpectateCamera));
    }


    public void PlayerDied(Transform ragdoll)
    {
        this.target = ragdoll;
        this.state = MoveCamera.CameraState.PlayerDeath;
        this.desiredDeathPos = base.transform.position + Vector3.up * 3f;
        if (GameManager.state != GameManager.GameState.GameOver)
        {
            base.Invoke(nameof(StartSpectating), 4f);
        }
    }


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

    private void CarCamera()
    {
        if (!this.target)
        {
            this.target = new GameObject("cameraOrbit").transform;
            base.transform.parent = this.target;
            base.transform.localRotation = Quaternion.identity;
            base.transform.localPosition = new Vector3(0f, 0f, -10f);
        }
        Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
        this.desiredSpectateRotation += new Vector3(-vector.y, vector.x, 0f) * 1.5f;
        this.desiredSpectateRotation.x = Mathf.Clamp(desiredSpectateRotation.x, -10f, 100f);
        this.target.position = OtherInput.Instance.currentCar.transform.position;
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


    private void PlayerDeathCamera()
    {
        if (this.target == null)
        {
            return;
        }
        base.transform.position = Vector3.Lerp(base.transform.position, this.desiredDeathPos, Time.deltaTime * 1f);
        base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.LookRotation(this.target.position - base.transform.position), Time.deltaTime);
    }


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


    public void UpdateFov(float f)
    {
        this.mainCam.fieldOfView = f;
        this.gunCamera.fieldOfView = f;
    }


    public void BobOnce(Vector3 bobDirection)
    {
        Vector3 a = this.ClampVector(bobDirection * 0.15f, -3f, 3f);
        this.desiredBob = a * this.bobMultiplier;
    }


    private void UpdateBob()
    {
        this.desiredBob = Vector3.Lerp(this.desiredBob, Vector3.zero, Time.deltaTime * this.bobSpeed * 0.5f);
        this.bobOffset = Vector3.Lerp(this.bobOffset, this.desiredBob, Time.deltaTime * this.bobSpeed);
    }


    private Vector3 ClampVector(Vector3 vec, float min, float max)
    {
        return new Vector3(Mathf.Clamp(vec.x, min, max), Mathf.Clamp(vec.y, min, max), Mathf.Clamp(vec.z, min, max));
    }


    public Transform player;


    public Vector3 offset;


    public Vector3 desyncOffset;


    public Vector3 vaultOffset;


    private Camera cam;


    private Rigidbody rb;


    public PlayerInput playerInput;


    public bool cinematic;


    private float desiredTilt;


    private float tilt;


    private Vector3 desiredDeathPos;


    private Transform target;


    private Vector3 desiredSpectateRotation;


    private Transform playerTarget;


    public LayerMask whatIsGround;


    private int spectatingId;


    private Vector3 desiredBob;


    private Vector3 bobOffset;


    private float bobSpeed = 15f;


    private float bobMultiplier = 1f;


    private readonly float bobConstant = 0.2f;


    public Camera mainCam;


    public Camera gunCamera;


    public enum CameraState
    {

        Player,

        PlayerDeath,

        Spectate,
		Car,
    }
}
