using System.Collections.Generic;
using UnityEngine;

public class MobManager : MonoBehaviour
{
    public Dictionary<int, Mob> mobs;

    private static int mobId;

    public static MobManager Instance;

    public LayerMask whatIsRaycastable;

    public bool attatchDebug;

    public GameObject debug;

    private void Awake()
    {
        Instance = this;
        mobId = 0;
        mobs = new Dictionary<int, Mob>();
    }

    public void AddMob(Mob c, int id)
    {
        c.SetId(id);
        mobs.Add(id, c);
        if (attatchDebug)
        {
            Object.Instantiate(debug, c.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
        }
    }

    public int GetActiveEnemies()
    {
        int num = 0;
        foreach (Mob value in mobs.Values)
        {
            if (!value.gameObject.CompareTag("DontCount") && value.mobType.behaviour != 0 && !(value.mobType.name == "Woodman"))
            {
                Debug.LogError("Counting enemy: " + value.gameObject.name);
                num++;
            }
        }
        return num;
    }

    public int GetNextId()
    {
        return mobId++;
    }

    public void RemoveMob(int mobId)
    {
        mobs.Remove(mobId);
    }
}
