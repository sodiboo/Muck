using System;
using UnityEngine;

// Token: 0x02000075 RID: 117
public class PingController : MonoBehaviour
{
	// Token: 0x060002A0 RID: 672 RVA: 0x0000EDC0 File Offset: 0x0000CFC0
	private void Awake()
	{
		PingController.Instance = this;
		this.readyToPing = true;
	}

	// Token: 0x060002A1 RID: 673 RVA: 0x0000EDCF File Offset: 0x0000CFCF
	private void Update()
	{
		if (Input.GetMouseButtonDown(2))
		{
			this.LocalPing();
		}
	}

	// Token: 0x060002A2 RID: 674 RVA: 0x0000EDE0 File Offset: 0x0000CFE0
	private void LocalPing()
	{
		if (!this.readyToPing)
		{
			return;
		}
		this.readyToPing = false;
		Invoke(nameof(PingCooldown), this.pingCooldown);
		Vector3 vector = this.FindPingPos();
		if (vector == Vector3.zero)
		{
			return;
		}
		this.MakePing(vector, GameManager.players[LocalClient.instance.myId].username, "");
		ClientSend.PlayerPing(vector);
	}

	// Token: 0x060002A3 RID: 675 RVA: 0x0000EE50 File Offset: 0x0000D050
	private Vector3 FindPingPos()
	{
		Transform playerCam = PlayerMovement.Instance.playerCam;
		RaycastHit raycastHit;
		if (Physics.Raycast(playerCam.position, playerCam.forward, out raycastHit, 1500f))
		{
			Vector3 b = Vector3.zero;
			if (raycastHit.collider.gameObject.layer == LayerMask.NameToLayer("Ground"))
			{
				b = Vector3.one;
			}
			return raycastHit.point + b;
		}
		return Vector3.zero;
	}

	// Token: 0x060002A4 RID: 676 RVA: 0x0000EEBE File Offset: 0x0000D0BE
	public void MakePing(Vector3 pos, string name, string pingedName)
	{
		Instantiate<GameObject>(this.pingPrefab, pos, Quaternion.identity).GetComponent<PlayerPing>().SetPing(name, pingedName);
	}

	// Token: 0x060002A5 RID: 677 RVA: 0x0000EEDD File Offset: 0x0000D0DD
	private void PingCooldown()
	{
		this.readyToPing = true;
	}

	// Token: 0x040002B9 RID: 697
	public LayerMask whatIsPingable;

	// Token: 0x040002BA RID: 698
	public GameObject pingPrefab;

	// Token: 0x040002BB RID: 699
	private float pingCooldown = 1f;

	// Token: 0x040002BC RID: 700
	private bool readyToPing;

	// Token: 0x040002BD RID: 701
	public static PingController Instance;
}
