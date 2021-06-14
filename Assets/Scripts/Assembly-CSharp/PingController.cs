using System;
using UnityEngine;

// Token: 0x02000068 RID: 104
public class PingController : MonoBehaviour
{
	// Token: 0x06000219 RID: 537 RVA: 0x000039F2 File Offset: 0x00001BF2
	private void Awake()
	{
		PingController.Instance = this;
		this.readyToPing = true;
	}

	// Token: 0x0600021A RID: 538 RVA: 0x00003A01 File Offset: 0x00001C01
	private void Update()
	{
		if (Input.GetMouseButtonDown(2))
		{
			this.LocalPing();
		}
	}

	// Token: 0x0600021B RID: 539 RVA: 0x0000F938 File Offset: 0x0000DB38
	private void LocalPing()
	{
		if (!this.readyToPing)
		{
			return;
		}
		this.readyToPing = false;
		base.Invoke("PingCooldown", this.pingCooldown);
		Vector3 vector = this.FindPingPos();
		if (vector == Vector3.zero)
		{
			return;
		}
		this.MakePing(vector, GameManager.players[LocalClient.instance.myId].username, "");
		ClientSend.PlayerPing(vector);
	}

	// Token: 0x0600021C RID: 540 RVA: 0x0000F9A8 File Offset: 0x0000DBA8
	private Vector3 FindPingPos()
	{
		Transform playerCam = PlayerMovement.Instance.playerCam;
		RaycastHit raycastHit;
		if (Physics.Raycast(playerCam.position, playerCam.forward, out raycastHit, 1500f))
		{
			Vector3 b = Vector3.zero;
			Hitable hitable;
			if (raycastHit.collider.gameObject.layer == LayerMask.NameToLayer("Ground"))
			{
				b = Vector3.one;
			}
			else if (raycastHit.collider.TryGetComponent<Hitable>(out hitable))
			{
				hitable.Hit(9999, 0f, 0, raycastHit.point);
			}
			return raycastHit.point + b;
		}
		return Vector3.zero;
	}

	// Token: 0x0600021D RID: 541 RVA: 0x00003A11 File Offset: 0x00001C11
	public void MakePing(Vector3 pos, string name, string pingedName)
	{
	Instantiate<GameObject>(this.pingPrefab, pos, Quaternion.identity).GetComponent<PlayerPing>().SetPing(name, pingedName);
	}

	// Token: 0x0600021E RID: 542 RVA: 0x00003A30 File Offset: 0x00001C30
	private void PingCooldown()
	{
		this.readyToPing = true;
	}

	// Token: 0x0400023C RID: 572
	public LayerMask whatIsPingable;

	// Token: 0x0400023D RID: 573
	public GameObject pingPrefab;

	// Token: 0x0400023E RID: 574
	private float pingCooldown = 1f;

	// Token: 0x0400023F RID: 575
	private bool readyToPing;

	// Token: 0x04000240 RID: 576
	public static PingController Instance;
}
