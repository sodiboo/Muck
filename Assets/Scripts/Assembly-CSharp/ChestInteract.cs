using System;
using UnityEngine;

public class ChestInteract : MonoBehaviour, Interactable
{
	private void Awake()
	{
		this.chest = base.GetComponent<Chest>();
		this.ready = true;
	}

	public void Interact()
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		Invoke(nameof(GetReady), this.cooldownTime);
		ClientSend.RequestChest(this.chest.id, true);
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
	}

	public void ServerExecute(int fromClient)
	{
	}

	public void RemoveObject()
	{
	}

	public string GetName()
	{
		if (this.chest.inUse)
		{
			return this.state.ToString() + "\n<size=50%>(Someone is already using it..)";
		}
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to open", this.state.ToString(), InputManager.interact);
	}

	public bool IsStarted()
	{
		return false;
	}

	private void GetReady()
	{
		this.ready = true;
	}

	public OtherInput.CraftingState state;

	private Chest chest;

	private float cooldownTime = 0.5f;

	private bool ready;
}
