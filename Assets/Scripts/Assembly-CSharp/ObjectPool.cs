using System.Collections.Generic;
using UnityEngine;

public class ObjectPool : MonoBehaviour
{
    public List<SharedObject>[] pools;

    private ResourceGenerator gen;

    private void Awake()
    {
        InitPools();
    }

    private void InitPools()
    {
        gen = GetComponent<ResourceGenerator>();
        pools = new List<SharedObject>[gen.resourcePrefabs.Length];
        for (int i = 0; i < gen.resourcePrefabs.Length; i++)
        {
            pools[i] = new List<SharedObject>();
        }
    }

    public int ActivateGameObject(PooledObject activatedObject)
    {
        return 0;
    }

    public void DeactivateGameObject(PooledObject deactivatedObject)
    {
    }
}
