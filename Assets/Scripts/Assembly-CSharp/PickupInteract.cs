using UnityEngine;

public class PickupInteract : MonoBehaviour, Interactable, SharedObject
{
    public InventoryItem item;

    public int amount;

    public int id;

    private Vector3 defaultScale;

    private Vector3 desiredScale;

    private void Awake()
    {
        defaultScale = base.transform.localScale;
        desiredScale = defaultScale;
    }

    public void Interact()
    {
        ClientSend.PickupInteract(id);
    }

    public void LocalExecute()
    {
        InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
        inventoryItem.Copy(item, amount);
        InventoryUI.Instance.AddItemToInventory(inventoryItem);
    }

    public void AllExecute()
    {
        RemoveObject();
    }

    public void ServerExecute(int fromClient)
    {
    }

    public void RemoveObject()
    {
        Object.Destroy(base.gameObject);
        ResourceManager.Instance.RemoveInteractItem(id);
    }

    public string GetName()
    {
        return item.name + "\n<size=50%>(Press \"E\" to pickup";
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
        desiredScale = Vector3.Lerp(desiredScale, defaultScale, Time.deltaTime * 15f);
        desiredScale.y = defaultScale.y;
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, desiredScale, Time.deltaTime * 15f);
    }

    public int GetId()
    {
        return id;
    }
}
