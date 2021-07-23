using UnityEngine;

public class SinglePlayer : MonoBehaviour
{
    private Transform playerCam;

    public LayerMask whatIsGrabbable;

    private Rigidbody objectGrabbing;

    private Vector3 previousLookdir;

    private Vector3 grabPoint;

    private float dragForce = 700000f;

    private SpringJoint grabJoint;

    public LineRenderer grabLr;

    private Vector3 myGrabPoint;

    private Vector3 myHandPoint;

    public static SinglePlayer Instance;

    private float oldDrag;

    private void Start()
    {
        Instance = this;
        if ((bool)PlayerMovement.Instance)
        {
            playerCam = PlayerMovement.Instance.playerCam;
        }
    }

    private void Update()
    {
        DrawGrabbing();
    }

    private void DrawGrabbing()
    {
    }

    private void FindNewGrabLerp()
    {
        myGrabPoint = Vector3.Lerp(myGrabPoint, objectGrabbing.position, Time.deltaTime * 45f);
        myHandPoint = Vector3.Lerp(myHandPoint, grabJoint.connectedAnchor, Time.deltaTime * 45f);
        grabLr.SetPosition(0, myGrabPoint);
        grabLr.SetPosition(1, myHandPoint);
    }

    private void HoldGrab()
    {
        grabJoint.connectedAnchor = playerCam.transform.position + playerCam.transform.forward * 6.5f;
        grabLr.startWidth = 0.05f;
        grabLr.endWidth = 0.05f;
        previousLookdir = playerCam.transform.forward;
    }

    public void StopGrab()
    {
        grabLr.enabled = false;
        if ((bool)objectGrabbing)
        {
            Object.Destroy(grabJoint);
            objectGrabbing.angularDrag = 0.05f;
            objectGrabbing.drag = oldDrag;
            objectGrabbing = null;
        }
    }
}
