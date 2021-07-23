using UnityEngine;

public class FinishGameInteract : MonoBehaviour, Interactable, SharedObject
{
    private int id;

    private void Awake()
    {
        Collider[] components = GetComponents<Collider>();
        foreach (Collider collider in components)
        {
            if (collider.isTrigger)
            {
                collider.enabled = true;
            }
        }
        base.gameObject.layer = LayerMask.NameToLayer("Interact");
    }

    public void Interact()
    {
        int playersInLobby = GameManager.instance.GetPlayersInLobby();
        if (Boat.Instance.countPlayers.players.Count >= playersInLobby)
        {
            ClientSend.Interact(id);
        }
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
        Boat.Instance.LeaveIsland();
    }

    public void ServerExecute(int fromClient = -1)
    {
    }

    public void RemoveObject()
    {
    }

    public string GetName()
    {
        int playersInLobby = GameManager.instance.GetPlayersInLobby();
        int count = Boat.Instance.countPlayers.players.Count;
        if (count >= playersInLobby)
        {
            return $"Press {InputManager.interact} to leave Muck!" + $"\n({count}/{playersInLobby})";
        }
        return "Get all players on the ship!" + $"\n({count}/{playersInLobby})";
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
