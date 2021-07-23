using UnityEngine;

public class BillyInteract : MonoBehaviour, SharedObject, Interactable
{
    public int id;

    public void SetId(int id)
    {
        this.id = id;
    }

    public int GetId()
    {
        return id;
    }

    public void Interact()
    {
        Application.OpenURL("https://store.steampowered.com/app/1228610/KARLSON/");
        AchievementManager.Instance.Karlson();
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
    }

    public void ServerExecute(int fromClient = -1)
    {
    }

    public void RemoveObject()
    {
    }

    public string GetName()
    {
        return $"<size=40%>Press {InputManager.interact} to wishlist KARLSON now gamer!";
    }

    public bool IsStarted()
    {
        return false;
    }
}
