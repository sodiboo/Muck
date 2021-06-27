using System;
using UnityEngine;

public class CraftingInteract : MonoBehaviour, Interactable
{
	public void Interact()
	{
		OtherInput.Instance.ToggleInventory(this.state);
	}

	public void LocalExecute()
	{
		throw new NotImplementedException();
	}

	public void AllExecute()
	{
		throw new NotImplementedException();
	}

	public void ServerExecute(int fromClient)
	{
		throw new NotImplementedException();
	}

	public void RemoveObject()
	{
		throw new NotImplementedException();
	}

	public string GetName()
	{
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to use)", this.state.ToString(), InputManager.interact);
	}

	public bool IsStarted()
	{
		return false;
	}

	public OtherInput.CraftingState state;
}
