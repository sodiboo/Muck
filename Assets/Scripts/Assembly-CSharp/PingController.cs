using System;
using UnityEngine;

public class PingController : MonoBehaviour
{
	private void Awake()
	{
		PingController.Instance = this;
		this.readyToPing = true;
	}

	private void Update()
	{
		if (Input.GetMouseButtonDown(2))
		{
			this.LocalPing();
		}
	}

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

	public void MakePing(Vector3 pos, string name, string pingedName)
	{
		Instantiate<GameObject>(this.pingPrefab, pos, Quaternion.identity).GetComponent<PlayerPing>().SetPing(name, pingedName);
	}

	private void PingCooldown()
	{
		this.readyToPing = true;
	}

	public LayerMask whatIsPingable;

	public GameObject pingPrefab;

	private float pingCooldown = 1f;

	private bool readyToPing;

	public static PingController Instance;
}
