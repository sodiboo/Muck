using System;
using UnityEngine;

// Token: 0x020000DB RID: 219
public class SinglePlayer : MonoBehaviour
{
	// Token: 0x060006E0 RID: 1760 RVA: 0x00023DA9 File Offset: 0x00021FA9
	private void Start()
	{
		SinglePlayer.Instance = this;
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerCam = PlayerMovement.Instance.playerCam;
	}

	// Token: 0x060006E1 RID: 1761 RVA: 0x00023DCE File Offset: 0x00021FCE
	private void Update()
	{
		this.DrawGrabbing();
	}

	// Token: 0x060006E2 RID: 1762 RVA: 0x000030D7 File Offset: 0x000012D7
	private void DrawGrabbing()
	{
	}

	// Token: 0x060006E3 RID: 1763 RVA: 0x00023DD8 File Offset: 0x00021FD8
	private void FindNewGrabLerp()
	{
		this.myGrabPoint = Vector3.Lerp(this.myGrabPoint, this.objectGrabbing.position, Time.deltaTime * 45f);
		this.myHandPoint = Vector3.Lerp(this.myHandPoint, this.grabJoint.connectedAnchor, Time.deltaTime * 45f);
		this.grabLr.SetPosition(0, this.myGrabPoint);
		this.grabLr.SetPosition(1, this.myHandPoint);
	}

	// Token: 0x060006E4 RID: 1764 RVA: 0x00023E58 File Offset: 0x00022058
	private void HoldGrab()
	{
		this.grabJoint.connectedAnchor = this.playerCam.transform.position + this.playerCam.transform.forward * 6.5f;
		this.grabLr.startWidth = 0.05f;
		this.grabLr.endWidth = 0.05f;
		this.previousLookdir = this.playerCam.transform.forward;
	}

	// Token: 0x060006E5 RID: 1765 RVA: 0x00023ED8 File Offset: 0x000220D8
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

	// Token: 0x0400064A RID: 1610
	private Transform playerCam;

	// Token: 0x0400064B RID: 1611
	public LayerMask whatIsGrabbable;

	// Token: 0x0400064C RID: 1612
	private Rigidbody objectGrabbing;

	// Token: 0x0400064D RID: 1613
	private Vector3 previousLookdir;

	// Token: 0x0400064E RID: 1614
	private Vector3 grabPoint;

	// Token: 0x0400064F RID: 1615
	private float dragForce = 700000f;

	// Token: 0x04000650 RID: 1616
	private SpringJoint grabJoint;

	// Token: 0x04000651 RID: 1617
	public LineRenderer grabLr;

	// Token: 0x04000652 RID: 1618
	private Vector3 myGrabPoint;

	// Token: 0x04000653 RID: 1619
	private Vector3 myHandPoint;

	// Token: 0x04000654 RID: 1620
	public static SinglePlayer Instance;

	// Token: 0x04000655 RID: 1621
	private float oldDrag;
}
