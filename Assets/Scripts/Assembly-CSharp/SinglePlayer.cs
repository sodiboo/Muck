using System;
using UnityEngine;

// Token: 0x020000EE RID: 238
public class SinglePlayer : MonoBehaviour
{
	// Token: 0x0600065E RID: 1630 RVA: 0x0000615B File Offset: 0x0000435B
	private void Start()
	{
		SinglePlayer.Instance = this;
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x0600065F RID: 1631 RVA: 0x00006180 File Offset: 0x00004380
	private void Update()
	{
		this.DrawGrabbing();
	}

	// Token: 0x06000660 RID: 1632 RVA: 0x00002147 File Offset: 0x00000347
	private void DrawGrabbing()
	{
	}

	// Token: 0x06000661 RID: 1633 RVA: 0x00021BEC File Offset: 0x0001FDEC
	private void FindNewGrabLerp()
	{
		this.myGrabPoint = Vector3.Lerp(this.myGrabPoint, this.objectGrabbing.position, Time.deltaTime * 45f);
		this.myHandPoint = Vector3.Lerp(this.myHandPoint, this.grabJoint.connectedAnchor, Time.deltaTime * 45f);
		this.grabLr.SetPosition(0, this.myGrabPoint);
		this.grabLr.SetPosition(1, this.myHandPoint);
	}

	// Token: 0x06000662 RID: 1634 RVA: 0x00021C6C File Offset: 0x0001FE6C
	private void HoldGrab()
	{
		this.grabJoint.connectedAnchor = this.playerCam.transform.position + this.playerCam.transform.forward * 6.5f;
		this.grabLr.startWidth = 0.05f;
		this.grabLr.endWidth = 0.05f;
		this.previousLookdir = this.playerCam.transform.forward;
	}

	// Token: 0x06000663 RID: 1635 RVA: 0x00021CEC File Offset: 0x0001FEEC
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

	// Token: 0x0400062B RID: 1579
	private Transform playerCam;

	// Token: 0x0400062C RID: 1580
	public LayerMask whatIsGrabbable;

	// Token: 0x0400062D RID: 1581
	private Rigidbody objectGrabbing;

	// Token: 0x0400062E RID: 1582
	private Vector3 previousLookdir;

	// Token: 0x0400062F RID: 1583
	private Vector3 grabPoint;

	// Token: 0x04000630 RID: 1584
	private float dragForce = 700000f;

	// Token: 0x04000631 RID: 1585
	private SpringJoint grabJoint;

	// Token: 0x04000632 RID: 1586
	public LineRenderer grabLr;

	// Token: 0x04000633 RID: 1587
	private Vector3 myGrabPoint;

	// Token: 0x04000634 RID: 1588
	private Vector3 myHandPoint;

	// Token: 0x04000635 RID: 1589
	public static SinglePlayer Instance;

	// Token: 0x04000636 RID: 1590
	private float oldDrag;
}
