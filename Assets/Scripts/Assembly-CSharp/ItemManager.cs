using System.Collections.Generic;
using UnityEngine;

public class ItemManager : MonoBehaviour
{
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

    private void Awake()
    {
        Instance = this;
        list = new Dictionary<int, GameObject>();
        allItems = new Dictionary<int, InventoryItem>();
        allPowerups = new Dictionary<int, Powerup>();
        stringToPowerupId = new Dictionary<string, int>();
        random = new ConsistentRandom();
        InitAllItems();
        InitAllPowerups();
        InitAllDropTables();
    }

    private void InitAllItems()
    {
        for (int i = 0; i < allScriptableItems.Length; i++)
        {
            allScriptableItems[i].id = i;
            allItems.Add(i, allScriptableItems[i]);
        }
    }

    private void InitAllDropTables()
    {
        for (int i = 0; i < allScriptableDropTables.Length; i++)
        {
            allScriptableDropTables[i].id = i;
            allDropTables.Add(i, allScriptableDropTables[i]);
        }
    }

    private void InitAllPowerups()
    {
        int id = 0;
        id = AddPowerupsToList(powerupsWhite, id);
        id = AddPowerupsToList(powerupsBlue, id);
        id = AddPowerupsToList(powerupsOrange, id);
    }

    private int AddPowerupsToList(Powerup[] powerups, int id)
    {
        foreach (Powerup powerup in powerups)
        {
            allPowerups.Add(id, powerup);
            stringToPowerupId.Add(powerup.name, id);
            powerup.id = id;
            id++;
        }
        return id;
    }

    public InventoryItem GetItemByName(string name)
    {
        foreach (InventoryItem value in allItems.Values)
        {
            if (value.name == name)
            {
                return value;
            }
        }
        return null;
    }

    public int GetNextId()
    {
        return currentId++;
    }

    public void DropItem(int fromClient, int itemId, int amount, int objectID)
    {
        GameObject gameObject = Object.Instantiate(dropItem);
        InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
        inventoryItem.Copy(allItems[itemId], amount);
        Item component = gameObject.GetComponent<Item>();
        component.item = inventoryItem;
        component.UpdateMesh();
        gameObject.AddComponent<BoxCollider>();
        Vector3 position = GameManager.players[fromClient].transform.position;
        Transform child = GameManager.players[fromClient].transform;
        if (fromClient == LocalClient.instance.myId)
        {
            child = child.transform.GetChild(0);
        }
        Vector3 normalized = (child.forward + Vector3.up * 0.35f).normalized;
        gameObject.transform.position = position;
        gameObject.GetComponent<Rigidbody>().AddForce(normalized * InventoryUI.throwForce);
        if (attatchDebug)
        {
            GameObject obj = Object.Instantiate(debug, gameObject.transform);
            obj.GetComponent<DebugObject>().text = string.Concat(objectID);
            obj.transform.localPosition = Vector3.up * 1.25f;
        }
        gameObject.GetComponent<Item>().objectID = objectID;
        list.Add(objectID, gameObject);
    }

    public void DropItemAtPosition(int itemId, int amount, Vector3 pos, int objectID)
    {
        GameObject gameObject = Object.Instantiate(dropItem);
        InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
        inventoryItem.Copy(allItems[itemId], amount);
        Item component = gameObject.GetComponent<Item>();
        component.item = inventoryItem;
        component.UpdateMesh();
        gameObject.AddComponent<BoxCollider>();
        gameObject.transform.position = pos;
        if (attatchDebug)
        {
            GameObject obj = Object.Instantiate(debug, gameObject.transform);
            obj.GetComponent<DebugObject>().text = string.Concat(objectID);
            obj.transform.localPosition = Vector3.up * 1.25f;
        }
        gameObject.GetComponent<Item>().objectID = objectID;
        list.Add(objectID, gameObject);
    }

    public void DropResource(int fromClient, int dropTableId, int droppedObjectID)
    {
        GameObject gameObject = Object.Instantiate(dropItem);
        InventoryItem item = ScriptableObject.CreateInstance<InventoryItem>();
        Item component = gameObject.GetComponent<Item>();
        component.item = item;
        component.UpdateMesh();
        gameObject.AddComponent<BoxCollider>();
        if (attatchDebug)
        {
            GameObject obj = Object.Instantiate(debug, gameObject.transform);
            obj.GetComponent<DebugObject>().text = string.Concat(droppedObjectID);
            obj.transform.localPosition = Vector3.up * 1.25f;
        }
        gameObject.GetComponent<Item>().objectID = droppedObjectID;
        list.Add(droppedObjectID, gameObject);
    }

    public void DropPowerupAtPosition(int powerupId, Vector3 pos, int objectID)
    {
        GameObject gameObject = Object.Instantiate(dropItem);
        Powerup powerup = Object.Instantiate(allPowerups[powerupId]);
        Item component = gameObject.GetComponent<Item>();
        component.powerup = powerup;
        component.UpdateMesh();
        gameObject.AddComponent<BoxCollider>();
        gameObject.transform.position = pos;
        if (attatchDebug)
        {
            GameObject obj = Object.Instantiate(debug, gameObject.transform);
            obj.GetComponent<DebugObject>().text = string.Concat(objectID);
            obj.transform.localPosition = Vector3.up * 1.25f;
        }
        gameObject.GetComponent<Item>().objectID = objectID;
        list.Add(objectID, gameObject);
    }

    public Powerup GetRandomPowerup(float whiteWeight, float blueWeight, float orangeWeight)
    {
        float num = whiteWeight + blueWeight + orangeWeight;
        float num2 = (float)random.NextDouble();
        if (num2 < whiteWeight / num)
        {
            return powerupsWhite[Random.Range(0, powerupsWhite.Length)];
        }
        if (num2 < (whiteWeight + blueWeight) / num)
        {
            return powerupsBlue[Random.Range(0, powerupsBlue.Length)];
        }
        return powerupsOrange[Random.Range(0, powerupsOrange.Length)];
    }

    public bool PickupItem(int objectID)
    {
        Object.Destroy(list[objectID]);
        list.Remove(objectID);
        return true;
    }
}
