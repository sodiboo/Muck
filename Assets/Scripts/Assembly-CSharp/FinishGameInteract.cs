using System;
using UnityEngine;

public class FinishGameInteract : MonoBehaviour, Interactable, SharedObject
{
	private void Awake()
	{
		foreach (Collider collider in base.GetComponents<Collider>())
		{
			if (collider.isTrigger)
			{
				collider.enabled = true;
			}
		}
		base.gameObject.layer = LayerMask.NameToLayer("Interact");
	}

	public void Interact()
	{
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		if (Boat.Instance.countPlayers.players.Count >= playersInLobby)
		{
			ClientSend.Interact(this.id);
		}
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
		Boat.Instance.LeaveIsland();
	}

	public void ServerExecute(int fromClient = -1)
	{
	}

	public void RemoveObject()
	{
	}

	public string GetName()
	{
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		int count = Boat.Instance.countPlayers.players.Count;
		if (count >= playersInLobby)
		{
			return string.Format("Press {0} to leave Muck!", InputManager.interact) + string.Format("\n({0}/{1})", count, playersInLobby);
		}
		return "Get all players on the ship!" + string.Format("\n({0}/{1})", count, playersInLobby);
	}

	public bool IsStarted()
	{
		return false;
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	private int id;
}
