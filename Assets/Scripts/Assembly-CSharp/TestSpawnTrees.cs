using System.Collections.Generic;
using UnityEngine;

public class TestSpawnTrees : MonoBehaviour
{
    public GameObject resourcePrefab;

    public List<GameObject> resources;

    private void Start()
    {
        GameObject item = SpawnTree(base.transform.position);
        resources.Add(item);
        if ((bool)ResourceManager.Instance)
        {
            ResourceManager.Instance.AddResources(resources);
        }
    }

    private GameObject SpawnTree(Vector3 pos)
    {
        GameObject obj = Object.Instantiate(resourcePrefab, pos, Quaternion.identity);
        obj.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
        obj.SetActive(value: true);
        return obj;
    }
}
