
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003B RID: 59
public class ItemManager : MonoBehaviour
{
	// Token: 0x06000152 RID: 338 RVA: 0x00008FD8 File Offset: 0x000071D8
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

	// Token: 0x06000153 RID: 339 RVA: 0x00009034 File Offset: 0x00007234
	private void InitAllItems()
	{
		for (int i = 0; i < this.allScriptableItems.Length; i++)
		{
			this.allScriptableItems[i].id = i;
			this.allItems.Add(i, this.allScriptableItems[i]);
		}
	}

	// Token: 0x06000154 RID: 340 RVA: 0x00009078 File Offset: 0x00007278
	private void InitAllDropTables()
	{
		for (int i = 0; i < this.allScriptableDropTables.Length; i++)
		{
			this.allScriptableDropTables[i].id = i;
			this.allDropTables.Add(i, this.allScriptableDropTables[i]);
		}
	}

	// Token: 0x06000155 RID: 341 RVA: 0x000090BC File Offset: 0x000072BC
	private void InitAllPowerups()
	{
		int id = 0;
		id = this.AddPowerupsToList(this.powerupsWhite, id);
		id = this.AddPowerupsToList(this.powerupsBlue, id);
		id = this.AddPowerupsToList(this.powerupsOrange, id);
	}

	// Token: 0x06000156 RID: 342 RVA: 0x000090F8 File Offset: 0x000072F8
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

	// Token: 0x06000157 RID: 343 RVA: 0x00009148 File Offset: 0x00007348
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

	// Token: 0x06000158 RID: 344 RVA: 0x000091B0 File Offset: 0x000073B0
	public int GetNextId()
	{
		return ItemManager.currentId++;
	}

	// Token: 0x06000159 RID: 345 RVA: 0x000091C0 File Offset: 0x000073C0
	public void DropItem(int fromClient, int itemId, int amount, int objectID)
	{
		GameObject gameObject =Instantiate(this.dropItem);
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
			GameObject gameObject2 =Instantiate(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x0600015A RID: 346 RVA: 0x000092FC File Offset: 0x000074FC
	public void DropItemAtPosition(int itemId, int amount, Vector3 pos, int objectID)
	{
		GameObject gameObject =Instantiate(this.dropItem);
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.allItems[itemId], amount);
		Item component = gameObject.GetComponent<Item>();
		component.item = inventoryItem;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x0600015B RID: 347 RVA: 0x000093BC File Offset: 0x000075BC
	public void DropResource(int fromClient, int dropTableId, int droppedObjectID)
	{
		GameObject gameObject =Instantiate(this.dropItem);
		InventoryItem item = ScriptableObject.CreateInstance<InventoryItem>();
		Item component = gameObject.GetComponent<Item>();
		component.item = item;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(droppedObjectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = droppedObjectID;
		this.list.Add(droppedObjectID, gameObject);
	}

	// Token: 0x0600015C RID: 348 RVA: 0x00009458 File Offset: 0x00007658
	public void DropPowerupAtPosition(int powerupId, Vector3 pos, int objectID)
	{
		GameObject gameObject =Instantiate(this.dropItem);
		Powerup powerup =Instantiate<Powerup>(this.allPowerups[powerupId]);
		Item component = gameObject.GetComponent<Item>();
		component.powerup = powerup;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x0600015D RID: 349 RVA: 0x0000950C File Offset: 0x0000770C
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

	// Token: 0x0600015E RID: 350 RVA: 0x0000957B File Offset: 0x0000777B
	public bool PickupItem(int objectID)
	{
	Destroy(this.list[objectID]);
		this.list.Remove(objectID);
		return true;
	}

	// Token: 0x04000152 RID: 338
	public GameObject dropItem;

	// Token: 0x04000153 RID: 339
	public Dictionary<int, GameObject> list;

	// Token: 0x04000154 RID: 340
	public GameObject debug;

	// Token: 0x04000155 RID: 341
	public InventoryItem[] allScriptableItems;

	// Token: 0x04000156 RID: 342
	public LootDrop[] allScriptableDropTables;

	// Token: 0x04000157 RID: 343
	public Powerup[] powerupsWhite;

	// Token: 0x04000158 RID: 344
	public Powerup[] powerupsBlue;

	// Token: 0x04000159 RID: 345
	public Powerup[] powerupsOrange;

	// Token: 0x0400015A RID: 346
	public Dictionary<int, InventoryItem> allItems;

	// Token: 0x0400015B RID: 347
	public Dictionary<int, Powerup> allPowerups;

	// Token: 0x0400015C RID: 348
	public Dictionary<int, LootDrop> allDropTables;

	// Token: 0x0400015D RID: 349
	public Dictionary<string, int> stringToPowerupId;

	// Token: 0x0400015E RID: 350
	private ConsistentRandom random;

	// Token: 0x0400015F RID: 351
	public bool attatchDebug;

	// Token: 0x04000160 RID: 352
	public static ItemManager Instance;

	// Token: 0x04000161 RID: 353
	public static int currentId;
}
