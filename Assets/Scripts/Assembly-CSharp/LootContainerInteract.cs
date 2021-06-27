using System;
using UnityEngine;

public class LootContainerInteract : MonoBehaviour, Interactable, SharedObject
{
	private void Start()
	{
		if (this.testPowerup)
		{
			this.TestSpawn();
		}
		this.ready = true;
		this.basePrice = this.price;
	}

	private void OnEnable()
	{
		if (this.opened)
		{
			this.OpenContainer();
		}
	}

	private void TestSpawn()
	{
		this.id = LootContainerInteract.totalId++;
		ResourceManager.Instance.AddObject(this.id, base.gameObject);
	}

	public void Interact()
	{
		if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Creative && InventoryUI.Instance.GetMoney() < this.price)
		{
			return;
		}
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		InventoryUI.Instance.UseMoney(this.price);
		ClientSend.PickupInteract(this.id);
	}

	private void GetReady()
	{
		this.ready = true;
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
		this.OpenContainer();
	}

	public void ServerExecute(int fromClient)
	{
		if (LocalClient.serverOwner)
		{
			Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(this.white, this.blue, this.gold);
			if (this.testPowerup && this.powerupToTest != null)
			{
				randomPowerup = this.powerupToTest;
			}
			int nextId = ItemManager.Instance.GetNextId();
			ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
			ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
		}
	}

	public void RemoveObject()
	{
	}

	public void OpenContainer()
	{
		this.opened = true;
		if (base.gameObject.activeInHierarchy)
		{
			this.animator.Play("OpenChest");
			Destroy(base.gameObject);
		}
	}

	public string GetName()
	{
		this.price = (int)((float)this.basePrice * GameManager.instance.ChestPriceMultiplier());
		if (this.price < 1 || GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative)
		{
			return "Open chest";
		}
		return string.Format("{0} Gold\n<size=75%>open chest", this.price);
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

	public LootDrop lootTable;

	public int price;

	private int basePrice;

	private int id;

	private static int totalId = 69420;

	private bool ready = true;

	private bool opened;

	public Animator animator;

	public float white;

	public float blue;

	public float gold;

	public bool testPowerup;

	public Powerup powerupToTest;
}
