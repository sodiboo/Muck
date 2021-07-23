using UnityEngine;

public class DoorInteractable : MonoBehaviour, Interactable, SharedObject
{
    private int id;

    private bool opened;

    private float desiredYRotation;

    public Transform pivot;

    public void Interact()
    {
        ClientSend.PickupInteract(id);
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
        opened = !opened;
        if (opened)
        {
            desiredYRotation = 90f;
        }
        else
        {
            desiredYRotation = 0f;
        }
    }

    private void Update()
    {
        pivot.rotation = Quaternion.Lerp(pivot.rotation, Quaternion.Euler(0f, desiredYRotation, 0f), Time.deltaTime * 5f);
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
        ResourceManager.Instance.RemoveItem(id);
    }

    public string GetName()
    {
        if (opened)
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
        return id;
    }
}
