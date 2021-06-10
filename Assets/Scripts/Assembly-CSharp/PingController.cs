
using UnityEngine;

// Token: 0x02000057 RID: 87
public class PingController : MonoBehaviour
{
	// Token: 0x060001EC RID: 492 RVA: 0x0000B35C File Offset: 0x0000955C
	private void Awake()
	{
		PingController.Instance = this;
		this.readyToPing = true;
	}

	// Token: 0x060001ED RID: 493 RVA: 0x0000B36B File Offset: 0x0000956B
	private void Update()
	{
		if (Input.GetMouseButtonDown(2))
		{
			this.LocalPing();
		}
	}

	// Token: 0x060001EE RID: 494 RVA: 0x0000B37C File Offset: 0x0000957C
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

	// Token: 0x060001EF RID: 495 RVA: 0x0000B3EC File Offset: 0x000095EC
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

	// Token: 0x060001F0 RID: 496 RVA: 0x0000B45A File Offset: 0x0000965A
	public void MakePing(Vector3 pos, string name, string pingedName)
	{
	Instantiate(this.pingPrefab, pos, Quaternion.identity).GetComponent<PlayerPing>().SetPing(name, pingedName);
	}

	// Token: 0x060001F1 RID: 497 RVA: 0x0000B479 File Offset: 0x00009679
	private void PingCooldown()
	{
		this.readyToPing = true;
	}

	// Token: 0x040001F0 RID: 496
	public LayerMask whatIsPingable;

	// Token: 0x040001F1 RID: 497
	public GameObject pingPrefab;

	// Token: 0x040001F2 RID: 498
	private float pingCooldown = 1f;

	// Token: 0x040001F3 RID: 499
	private bool readyToPing;

	// Token: 0x040001F4 RID: 500
	public static PingController Instance;
}
