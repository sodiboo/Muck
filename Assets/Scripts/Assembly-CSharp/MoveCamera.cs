using UnityEngine;

public class MoveCamera : MonoBehaviour
{
	public Transform player;
	public Vector3 offset;
	public Vector3 desyncOffset;
	public Vector3 vaultOffset;
	public PlayerInput playerInput;
	public bool cinematic;
	public LayerMask whatIsGround;
	public Vector3 cameraRot;
	public Camera mainCam;
	public Camera gunCamera;
}
