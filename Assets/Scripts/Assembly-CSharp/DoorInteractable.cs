using System;
using UnityEngine;

public class DoorInteractable : MonoBehaviour, Interactable, SharedObject
{
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
		this.opened = !this.opened;
		if (this.opened)
		{
			this.desiredYRotation = 90f;
			return;
		}
		this.desiredYRotation = 0f;
	}

	private void Update()
	{
		this.pivot.rotation = Quaternion.Lerp(this.pivot.rotation, Quaternion.Euler(0f, this.desiredYRotation, 0f), Time.deltaTime * 5f);
	}

	public void ServerExecute(int fromClient)
	{
	}

	public void RemoveObject()
	{
	}

	private void OnDestroy()
	{
		MonoBehaviour.print("door destroyed");
		ResourceManager.Instance.RemoveItem(this.id);
	}

	public string GetName()
	{
		if (this.opened)
		{
			return "Close Door";
		}
		return "Open Door";
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

	private bool opened;

	private float desiredYRotation;

	public Transform pivot;
}
