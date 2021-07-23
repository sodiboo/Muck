using System.Collections.Generic;
using UnityEngine;

public class ResourceManager : MonoBehaviour
{
    public static int globalId;

    public static int generatorSeedOffset;

    public Dictionary<int, GameObject> list;

    public Dictionary<int, GameObject> builds;

    public GameObject debug;

    public bool attatchDebug;

    public static ResourceManager Instance;

    private void Awake()
    {
        Instance = this;
        list = new Dictionary<int, GameObject>();
        builds = new Dictionary<int, GameObject>();
        generatorSeedOffset = 0;
        globalId = 0;
    }

    public static int GetNextGenOffset()
    {
        int result = generatorSeedOffset;
        generatorSeedOffset++;
        return result;
    }

    public void AddResources(List<GameObject>[] trees)
    {
        for (int i = 0; i < trees.Length; i++)
        {
            for (int j = 0; j < trees[i].Count; j++)
            {
                GameObject gameObject2 = (trees[i][j] = trees[i][j]);
                GameObject gameObject3 = gameObject2;
                int id = gameObject3.GetComponentInChildren<SharedObject>().GetId();
                AddObject(id, gameObject3);
            }
        }
    }

    public void AddResources(List<GameObject> trees)
    {
        for (int i = 0; i < trees.Count; i++)
        {
            GameObject gameObject2 = (trees[i] = trees[i]);
            GameObject gameObject3 = gameObject2;
            int id = gameObject3.GetComponentInChildren<SharedObject>().GetId();
            AddObject(id, gameObject3);
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

    public void AddBuild(int key, GameObject o)
    {
        if (!builds.ContainsKey(key))
        {
            builds.Add(key, o);
            if (attatchDebug)
            {
                Object.Instantiate(debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
            }
        }
    }

    public void RemoveItem(int id)
    {
        GameObject obj = list[id];
        if (builds.ContainsKey(id))
        {
            builds.Remove(id);
        }
        list.Remove(id);
        Object.Destroy(obj);
    }

    public bool RemoveInteractItem(int id)
    {
        if (!list.ContainsKey(id))
        {
            return false;
        }
        Interactable componentInChildren = list[id].GetComponentInChildren<Interactable>();
        list.Remove(id);
        componentInChildren.RemoveObject();
        return true;
    }

    public int GetNextId()
    {
        return globalId++;
    }
}
