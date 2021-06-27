using System;
using UnityEngine;

public class PickupInteract : MonoBehaviour, Interactable, SharedObject
{
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
		this.desiredScale = this.defaultScale;
	}

	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	public void LocalExecute()
	{
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.item, this.amount);
		InventoryUI.Instance.AddItemToInventory(inventoryItem);
	}

	public void AllExecute()
	{
		this.RemoveObject();
	}

	public void ServerExecute(int fromClient)
	{
	}

	public void RemoveObject()
	{
		Destroy(base.gameObject);
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	public string GetName()
	{
		return $"{this.item.name}\n<size=50%>(Press \"{InputManager.interact}\" to pickup)";
	}

	public bool IsStarted()
	{
		return false;
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	private void Update()
	{
		this.desiredScale = Vector3.Lerp(this.desiredScale, this.defaultScale, Time.deltaTime * 15f);
		this.desiredScale.y = this.defaultScale.y;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 15f);
	}

	public int GetId()
	{
		return this.id;
	}

	public InventoryItem item;

	public int amount;

	public int id;

	private Vector3 defaultScale;

	private Vector3 desiredScale;
}
