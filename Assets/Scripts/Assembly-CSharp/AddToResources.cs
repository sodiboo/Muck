using UnityEngine;

public class AddToResources : MonoBehaviour
{
    public bool chest;

    private void Start()
    {
        int nextId = ResourceManager.Instance.GetNextId();
        GetComponent<Hitable>().SetId(nextId);
        ResourceManager.Instance.AddObject(nextId, base.gameObject);
        Object.Destroy(this);
        if (chest)
        {
            Chest componentInChildren = GetComponentInChildren<Chest>();
            ChestManager.Instance.AddChest(componentInChildren, nextId);
        }
        base.transform.SetParent(null);
    }
}
