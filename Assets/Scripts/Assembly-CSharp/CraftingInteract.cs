using System;
using UnityEngine;

public class CraftingInteract : MonoBehaviour, Interactable
{
    public OtherInput.CraftingState state;

    public void Interact()
    {
        OtherInput.Instance.ToggleInventory(state);
    }

    public void LocalExecute()
    {
        throw new NotImplementedException();
    }

    public void AllExecute()
    {
        throw new NotImplementedException();
    }

    public void ServerExecute(int fromClient)
    {
        throw new NotImplementedException();
    }

    public void RemoveObject()
    {
        throw new NotImplementedException();
    }

    public string GetName()
    {
        return $"{state.ToString()}\n<size=50%>(Press \"{InputManager.interact}\" to use)";
    }

    public bool IsStarted()
    {
        return false;
    }
}
