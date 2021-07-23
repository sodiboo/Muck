using System;
using UnityEngine;

public class BuildDoor : MonoBehaviour
{
    [Serializable]
    public class Door
    {
        public Hitable hitable;

        public DoorInteractable doorInteractable;

        public void SetId(int id)
        {
            hitable.SetId(id);
            doorInteractable.SetId(id);
            ResourceManager.Instance.AddObject(id, hitable.gameObject);
        }
    }

    public Door[] doors;
}
