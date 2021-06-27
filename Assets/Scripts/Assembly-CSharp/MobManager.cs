using System;
using System.Collections.Generic;
using UnityEngine;

public class MobManager : MonoBehaviour
{
	private void Awake()
	{
		MobManager.Instance = this;
		MobManager.mobId = 0;
		this.mobs = new Dictionary<int, Mob>();
	}

	public void AddMob(Mob c, int id)
	{
		c.SetId(id);
		this.mobs.Add(id, c);
		if (this.attatchDebug)
		{
			Instantiate<GameObject>(this.debug, c.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	public int GetActiveEnemies()
	{
		int num = 0;
		foreach (Mob mob in this.mobs.Values)
		{
			if (!mob.gameObject.CompareTag("DontCount") && mob.mobType.behaviour != MobType.MobBehaviour.Neutral)
			{
				num++;
			}
		}
		return num;
	}

	public int GetNextId()
	{
		return MobManager.mobId++;
	}

	public void RemoveMob(int mobId)
	{
		this.mobs.Remove(mobId);
	}

	public Dictionary<int, Mob> mobs;

	private static int mobId;

	public static MobManager Instance;

	public LayerMask whatIsRaycastable;

	public bool attatchDebug;

	public GameObject debug;
}
