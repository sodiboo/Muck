
using UnityEngine;

// Token: 0x020000B3 RID: 179
public class SinglePlayer : MonoBehaviour
{
	// Token: 0x060005CB RID: 1483 RVA: 0x0001DF62 File Offset: 0x0001C162
	private void Start()
	{
		SinglePlayer.Instance = this;
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x060005CC RID: 1484 RVA: 0x0001DF87 File Offset: 0x0001C187
	private void Update()
	{
		this.DrawGrabbing();
	}

	// Token: 0x060005CD RID: 1485 RVA: 0x0000276E File Offset: 0x0000096E
	private void DrawGrabbing()
	{
	}

	// Token: 0x060005CE RID: 1486 RVA: 0x0001DF90 File Offset: 0x0001C190
	private void FindNewGrabLerp()
	{
		this.myGrabPoint = Vector3.Lerp(this.myGrabPoint, this.objectGrabbing.position, Time.deltaTime * 45f);
		this.myHandPoint = Vector3.Lerp(this.myHandPoint, this.grabJoint.connectedAnchor, Time.deltaTime * 45f);
		this.grabLr.SetPosition(0, this.myGrabPoint);
		this.grabLr.SetPosition(1, this.myHandPoint);
	}

	// Token: 0x060005CF RID: 1487 RVA: 0x0001E010 File Offset: 0x0001C210
	private void HoldGrab()
	{
		this.grabJoint.connectedAnchor = this.playerCam.transform.position + this.playerCam.transform.forward * 6.5f;
		this.grabLr.startWidth = 0.05f;
		this.grabLr.endWidth = 0.05f;
		this.previousLookdir = this.playerCam.transform.forward;
	}

	// Token: 0x060005D0 RID: 1488 RVA: 0x0001E090 File Offset: 0x0001C290
	public void StopGrab()
	{
		this.grabLr.enabled = false;
		if (!this.objectGrabbing)
		{
			return;
		}
	Destroy(this.grabJoint);
		this.objectGrabbing.angularDrag = 0.05f;
		this.objectGrabbing.drag = this.oldDrag;
		this.objectGrabbing = null;
	}

	// Token: 0x0400052F RID: 1327
	private Transform playerCam;

	// Token: 0x04000530 RID: 1328
	public LayerMask whatIsGrabbable;

	// Token: 0x04000531 RID: 1329
	private Rigidbody objectGrabbing;

	// Token: 0x04000532 RID: 1330
	private Vector3 previousLookdir;

	// Token: 0x04000533 RID: 1331
	private Vector3 grabPoint;

	// Token: 0x04000534 RID: 1332
	private float dragForce = 700000f;

	// Token: 0x04000535 RID: 1333
	private SpringJoint grabJoint;

	// Token: 0x04000536 RID: 1334
	public LineRenderer grabLr;

	// Token: 0x04000537 RID: 1335
	private Vector3 myGrabPoint;

	// Token: 0x04000538 RID: 1336
	private Vector3 myHandPoint;

	// Token: 0x04000539 RID: 1337
	public static SinglePlayer Instance;

	// Token: 0x0400053A RID: 1338
	private float oldDrag;
}
