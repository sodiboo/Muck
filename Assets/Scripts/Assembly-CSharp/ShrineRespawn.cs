using UnityEngine;

public class ShrineRespawn : MonoBehaviour, SharedObject, Interactable
{
    private int id;

    private void Start()
    {
    }

    public void Interact()
    {
        RespawnTotemUI.Instance.Show();
    }

    public void LocalExecute()
    {
    }

    public void AllExecute()
    {
    }

    public void ServerExecute(int fromClient)
    {
    }

    public void RemoveObject()
    {
        Object.Destroy(base.gameObject);
    }

    public string GetName()
    {
        return "Revive the homies";
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
