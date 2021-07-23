using System.Collections.Generic;
using UnityEngine;

public class ResourceManagerPooled : MonoBehaviour
{
    public Dictionary<int, GameObject> list;

    public GameObject debug;

    public bool attatchDebug;

    public static ResourceManagerPooled Instance;

    private void Awake()
    {
        Instance = this;
        list = new Dictionary<int, GameObject>();
    }

    public void PopulateTrees(List<GameObject>[] trees)
    {
        for (int i = 0; i < trees.Length; i++)
        {
            for (int j = 0; j < trees[i].Count; j++)
            {
                GameObject gameObject2 = (trees[i][j] = trees[i][j]);
                GameObject gameObject3 = gameObject2;
                int id = gameObject3.GetComponent<SharedObject>().GetId();
                AddObject(id, gameObject3);
            }
        }
    }

    public void AddObject(int key, GameObject o)
    {
        if (list.ContainsKey(key))
        {
            Debug.Log("Tried to add same key twice to resource manager, returning...");
            return;
        }
        list.Add(key, o);
        if (attatchDebug)
        {
            Object.Instantiate(debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
        }
    }

    public void RemoveItem(int id)
    {
        GameObject gameObject = list[id];
        if (gameObject.activeInHierarchy)
        {
            gameObject.SetActive(value: false);
            return;
        }
        list.Remove(id);
        Object.Destroy(gameObject);
    }

    public bool RemoveInteractItem(int id)
    {
        if (!list.ContainsKey(id))
        {
            return false;
        }
        GameObject obj = list[id];
        list.Remove(id);
        Object.Destroy(obj);
        return true;
    }
}
