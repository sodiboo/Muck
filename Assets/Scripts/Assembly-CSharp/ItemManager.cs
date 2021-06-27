using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000055 RID: 85
public class ItemManager : MonoBehaviour
{
	// Token: 0x060001E4 RID: 484 RVA: 0x0000BBC4 File Offset: 0x00009DC4
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

	// Token: 0x060001E5 RID: 485 RVA: 0x0000BC20 File Offset: 0x00009E20
	private void InitAllItems()
	{
		for (int i = 0; i < this.allScriptableItems.Length; i++)
		{
			this.allScriptableItems[i].id = i;
			this.allItems.Add(i, this.allScriptableItems[i]);
		}
	}

	// Token: 0x060001E6 RID: 486 RVA: 0x0000BC64 File Offset: 0x00009E64
	private void InitAllDropTables()
	{
		for (int i = 0; i < this.allScriptableDropTables.Length; i++)
		{
			this.allScriptableDropTables[i].id = i;
			this.allDropTables.Add(i, this.allScriptableDropTables[i]);
		}
	}

	// Token: 0x060001E7 RID: 487 RVA: 0x0000BCA8 File Offset: 0x00009EA8
	private void InitAllPowerups()
	{
		int id = 0;
		id = this.AddPowerupsToList(this.powerupsWhite, id);
		id = this.AddPowerupsToList(this.powerupsBlue, id);
		id = this.AddPowerupsToList(this.powerupsOrange, id);
	}

	// Token: 0x060001E8 RID: 488 RVA: 0x0000BCE4 File Offset: 0x00009EE4
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

	// Token: 0x060001E9 RID: 489 RVA: 0x0000BD34 File Offset: 0x00009F34
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

	// Token: 0x060001EA RID: 490 RVA: 0x0000BD9C File Offset: 0x00009F9C
	public int GetNextId()
	{
		return ItemManager.currentId++;
	}

	// Token: 0x060001EB RID: 491 RVA: 0x0000BDAC File Offset: 0x00009FAC
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

	// Token: 0x060001EC RID: 492 RVA: 0x0000BEE8 File Offset: 0x0000A0E8
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

	// Token: 0x060001ED RID: 493 RVA: 0x0000BFA8 File Offset: 0x0000A1A8
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

	// Token: 0x060001EE RID: 494 RVA: 0x0000C044 File Offset: 0x0000A244
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

	// Token: 0x060001EF RID: 495 RVA: 0x0000C0F8 File Offset: 0x0000A2F8
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

	// Token: 0x060001F0 RID: 496 RVA: 0x0000C167 File Offset: 0x0000A367
	public bool PickupItem(int objectID)
	{
		Destroy(this.list[objectID]);
		this.list.Remove(objectID);
		return true;
	}

	// Token: 0x040001F9 RID: 505
	public GameObject dropItem;

	// Token: 0x040001FA RID: 506
	public Dictionary<int, GameObject> list;

	// Token: 0x040001FB RID: 507
	public GameObject debug;

	// Token: 0x040001FC RID: 508
	public InventoryItem[] allScriptableItems;

	// Token: 0x040001FD RID: 509
	public LootDrop[] allScriptableDropTables;

	// Token: 0x040001FE RID: 510
	public Powerup[] powerupsWhite;

	// Token: 0x040001FF RID: 511
	public Powerup[] powerupsBlue;

	// Token: 0x04000200 RID: 512
	public Powerup[] powerupsOrange;

	// Token: 0x04000201 RID: 513
	public Dictionary<int, InventoryItem> allItems;

	// Token: 0x04000202 RID: 514
	public Dictionary<int, Powerup> allPowerups;

	// Token: 0x04000203 RID: 515
	public Dictionary<int, LootDrop> allDropTables;

	// Token: 0x04000204 RID: 516
	public Dictionary<string, int> stringToPowerupId;

	// Token: 0x04000205 RID: 517
	private ConsistentRandom random;

	// Token: 0x04000206 RID: 518
	public bool attatchDebug;

	// Token: 0x04000207 RID: 519
	public static ItemManager Instance;

	// Token: 0x04000208 RID: 520
	public static int currentId;
}
