using UnityEngine;

public class ChestInteract : MonoBehaviour, Interactable
{
    public OtherInput.CraftingState state;

    private Chest chest;

    private float cooldownTime = 0.5f;

    private bool ready;

    private void Awake()
    {
        chest = GetComponent<Chest>();
        ready = true;
    }

    public void Interact()
    {
        if (ready)
        {
            ready = false;
            Invoke("GetReady", cooldownTime);
            ClientSend.RequestChest(chest.id, use: true);
        }
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
    }

    public void ServerExecute(int fromClient)
    {
        WhenOpened();
    }

    protected virtual void WhenOpened()
    {
    }

    public void RemoveObject()
    {
    }

    public string GetName()
    {
        if (chest.inUse)
        {
            return state.ToString() + "\n<size=50%>(Someone is already using it..)";
        }
        return $"{state.ToString()}\n<size=50%>(Press \"{InputManager.interact}\" to open";
    }

    public bool IsStarted()
    {
        return false;
    }

    private void GetReady()
    {
        ready = true;
    }
}
