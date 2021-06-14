using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000048 RID: 72
public class ItemManager : MonoBehaviour
{
	// Token: 0x06000179 RID: 377 RVA: 0x0000DB88 File Offset: 0x0000BD88
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

	// Token: 0x0600017A RID: 378 RVA: 0x0000DBE4 File Offset: 0x0000BDE4
	private void InitAllItems()
	{
		for (int i = 0; i < this.allScriptableItems.Length; i++)
		{
			this.allScriptableItems[i].id = i;
			this.allItems.Add(i, this.allScriptableItems[i]);
		}
	}

	// Token: 0x0600017B RID: 379 RVA: 0x0000DC28 File Offset: 0x0000BE28
	private void InitAllDropTables()
	{
		for (int i = 0; i < this.allScriptableDropTables.Length; i++)
		{
			this.allScriptableDropTables[i].id = i;
			this.allDropTables.Add(i, this.allScriptableDropTables[i]);
		}
	}

	// Token: 0x0600017C RID: 380 RVA: 0x0000DC6C File Offset: 0x0000BE6C
	private void InitAllPowerups()
	{
		int id = 0;
		id = this.AddPowerupsToList(this.powerupsWhite, id);
		id = this.AddPowerupsToList(this.powerupsBlue, id);
		id = this.AddPowerupsToList(this.powerupsOrange, id);
	}

	// Token: 0x0600017D RID: 381 RVA: 0x0000DCA8 File Offset: 0x0000BEA8
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

	// Token: 0x0600017E RID: 382 RVA: 0x0000DCF8 File Offset: 0x0000BEF8
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

	// Token: 0x0600017F RID: 383 RVA: 0x0000323E File Offset: 0x0000143E
	public int GetNextId()
	{
		return ItemManager.currentId++;
	}

	// Token: 0x06000180 RID: 384 RVA: 0x0000DD60 File Offset: 0x0000BF60
	public void DropItem(int fromClient, int itemId, int amount, int objectID)
	{
		GameObject gameObject =Instantiate<GameObject>(this.dropItem);
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
			GameObject gameObject2 =Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x06000181 RID: 385 RVA: 0x0000DE9C File Offset: 0x0000C09C
	public void DropItemAtPosition(int itemId, int amount, Vector3 pos, int objectID)
	{
		GameObject gameObject =Instantiate<GameObject>(this.dropItem);
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.allItems[itemId], amount);
		Item component = gameObject.GetComponent<Item>();
		component.item = inventoryItem;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x06000182 RID: 386 RVA: 0x0000DF5C File Offset: 0x0000C15C
	public void DropResource(int fromClient, int dropTableId, int droppedObjectID)
	{
		GameObject gameObject =Instantiate<GameObject>(this.dropItem);
		InventoryItem item = ScriptableObject.CreateInstance<InventoryItem>();
		Item component = gameObject.GetComponent<Item>();
		component.item = item;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(droppedObjectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = droppedObjectID;
		this.list.Add(droppedObjectID, gameObject);
	}

	// Token: 0x06000183 RID: 387 RVA: 0x0000DFF8 File Offset: 0x0000C1F8
	public void DropPowerupAtPosition(int powerupId, Vector3 pos, int objectID)
	{
		GameObject gameObject =Instantiate<GameObject>(this.dropItem);
		Powerup powerup =Instantiate<Powerup>(this.allPowerups[powerupId]);
		Item component = gameObject.GetComponent<Item>();
		component.powerup = powerup;
		component.UpdateMesh();
		gameObject.AddComponent<BoxCollider>();
		gameObject.transform.position = pos;
		if (this.attatchDebug)
		{
			GameObject gameObject2 =Instantiate<GameObject>(this.debug, gameObject.transform);
			gameObject2.GetComponent<DebugObject>().text = string.Concat(objectID);
			gameObject2.transform.localPosition = Vector3.up * 1.25f;
		}
		gameObject.GetComponent<Item>().objectID = objectID;
		this.list.Add(objectID, gameObject);
	}

	// Token: 0x06000184 RID: 388 RVA: 0x0000E0AC File Offset: 0x0000C2AC
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

	// Token: 0x06000185 RID: 389 RVA: 0x0000324D File Offset: 0x0000144D
	public bool PickupItem(int objectID)
	{
	Destroy(this.list[objectID]);
		this.list.Remove(objectID);
		return true;
	}

	// Token: 0x04000187 RID: 391
	public GameObject dropItem;

	// Token: 0x04000188 RID: 392
	public Dictionary<int, GameObject> list;

	// Token: 0x04000189 RID: 393
	public GameObject debug;

	// Token: 0x0400018A RID: 394
	public InventoryItem[] allScriptableItems;

	// Token: 0x0400018B RID: 395
	public LootDrop[] allScriptableDropTables;

	// Token: 0x0400018C RID: 396
	public Powerup[] powerupsWhite;

	// Token: 0x0400018D RID: 397
	public Powerup[] powerupsBlue;

	// Token: 0x0400018E RID: 398
	public Powerup[] powerupsOrange;

	// Token: 0x0400018F RID: 399
	public Dictionary<int, InventoryItem> allItems;

	// Token: 0x04000190 RID: 400
	public Dictionary<int, Powerup> allPowerups;

	// Token: 0x04000191 RID: 401
	public Dictionary<int, LootDrop> allDropTables;

	// Token: 0x04000192 RID: 402
	public Dictionary<string, int> stringToPowerupId;

	// Token: 0x04000193 RID: 403
	private ConsistentRandom random;

	// Token: 0x04000194 RID: 404
	public bool attatchDebug;

	// Token: 0x04000195 RID: 405
	public static ItemManager Instance;

	// Token: 0x04000196 RID: 406
	public static int currentId;
}
