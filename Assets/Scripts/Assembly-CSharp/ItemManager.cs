using System.Collections.Generic;
using UnityEngine;

public class ItemManager : MonoBehaviour
{
	private void Awake()
	{
		ItemManager.Instance = this;
		this.list = new Dictionary<int, GameObject>();
		this.allItems = new Dictionary<int, InventoryItem>();
		this.allPowerups = new Dictionary<int, Powerup>();
		this.stringToPowerupId = new Dictionary<string, int>();
		this.random = new ConsistentRandom();
		this.InitAllItems();
		this.InitAllPowerups();
		this.InitAllDropTables();
	}

	private void InitAllItems()
	{
		for (int i = 0; i < this.allScriptableItems.Length; i++)
		{
			this.allScriptableItems[i].id = i;
			this.allItems.Add(i, this.allScriptableItems[i]);
		}
	}

	private void InitAllDropTables()
	{
		for (int i = 0; i < this.allScriptableDropTables.Length; i++)
		{
			this.allScriptableDropTables[i].id = i;
			this.allDropTables.Add(i, this.allScriptableDropTables[i]);
		}
	}

	private void InitAllPowerups()
	{
		int id = 0;
		id = this.AddPowerupsToList(this.powerupsWhite, id);
		id = this.AddPowerupsToList(this.powerupsBlue, id);
		id = this.AddPowerupsToList(this.powerupsOrange, id);
	}

	private int AddPowerupsToList(Powerup[] powerups, int id)
	{
		foreach (Powerup powerup in powerups)
		{
			this.allPowerups.Add(id, powerup);
			this.stringToPowerupId.Add(powerup.name, id);
			powerup.id = id;
			id++;
		}
		return id;
	}

	public InventoryItem GetItemByName(string name)
	{
		foreach (InventoryItem inventoryItem in this.allItems.Values)
		{
			if (inventoryItem.name == name)
			{
				return inventoryItem;
			}
		}
		return null;
	}

	public int GetNextId()
	{
		return ItemManager.currentId++;
	}

	public void DropItem(int fromClient, int itemId, int amount, int objectID)
	{
		GameObject gameObject = Instantiate<GameObject>(this.dropItem);
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.allItems[itemId], amount);
		Item component = gameObject.GetComponent<Item>();
		component.item = inventoryItem;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		Vector3 position = GameManager.players[fromClient].transform.position;
		Transform transform = GameManager.players[fromClient].transform;
		if (fromClient == LocalClient.instance.myId)
		{
			transform = transform.transform.GetChild(0);
		}
		Vector3 normalized = (transform.forward + Vector3.up * 0.35f).normalized;
		gameObject.transform.position = position;
		gameObject.GetComponent<Rigidbody>().AddForce(normalized * InventoryUI.throwForce);
		if (this.attatchDebug)
		{
			GameObject gameObject2 = Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	public void DropItemAtPosition(int itemId, int amount, Vector3 pos, int objectID)
	{
		GameObject gameObject = Instantiate<GameObject>(this.dropItem);
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.allItems[itemId], amount);
		Item component = gameObject.GetComponent<Item>();
		component.item = inventoryItem;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 = Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	public void DropResource(int fromClient, int dropTableId, int droppedObjectID)
	{
		GameObject gameObject = Instantiate<GameObject>(this.dropItem);
		InventoryItem item = ScriptableObject.CreateInstance<InventoryItem>();
		Item component = gameObject.GetComponent<Item>();
		component.item = item;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		if (this.attatchDebug)
		{
			GameObject gameObject2 = Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(droppedObjectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = droppedObjectID;
		this.list.Add(droppedObjectID, gameObject);
	}

	public void DropPowerupAtPosition(int powerupId, Vector3 pos, int objectID)
	{
		GameObject gameObject = Instantiate<GameObject>(this.dropItem);
		Powerup powerup = Instantiate<Powerup>(this.allPowerups[powerupId]);
		Item component = gameObject.GetComponent<Item>();
		component.powerup = powerup;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 = Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	public Powerup GetRandomPowerup(float whiteWeight, float blueWeight, float orangeWeight)
	{
		float num = whiteWeight + blueWeight + orangeWeight;
		float num2 = (float)this.random.NextDouble();
		if (num2 < whiteWeight / num)
		{
			return this.powerupsWhite[Random.Range(0, this.powerupsWhite.Length)];
		}
		if (num2 < (whiteWeight + blueWeight) / num)
		{
			return this.powerupsBlue[Random.Range(0, this.powerupsBlue.Length)];
		}
		return this.powerupsOrange[Random.Range(0, this.powerupsOrange.Length)];
	}

	public bool PickupItem(int objectID)
	{
		Destroy(this.list[objectID]);
		this.list.Remove(objectID);
		return true;
	}

	public GameObject dropItem;

	public Dictionary<int, GameObject> list;

	public GameObject debug;

	public InventoryItem[] allScriptableItems;

	public LootDrop[] allScriptableDropTables;

	public Powerup[] powerupsWhite;

	public Powerup[] powerupsBlue;

	public Powerup[] powerupsOrange;

	public Dictionary<int, InventoryItem> allItems;

	public Dictionary<int, Powerup> allPowerups;

	public Dictionary<int, LootDrop> allDropTables;

	public Dictionary<string, int> stringToPowerupId;

	private ConsistentRandom random;

	public bool attatchDebug;

	public static ItemManager Instance;

	public static int currentId;
}
