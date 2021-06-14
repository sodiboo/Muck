using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000059 RID: 89
public class MobManager : MonoBehaviour
{
	// Token: 0x060001D3 RID: 467 RVA: 0x000035E4 File Offset: 0x000017E4
	private void Awake()
	{
		MobManager.Instance = this;
		MobManager.mobId = 0;
		this.mobs = new Dictionary<int, Mob>();
	}

	// Token: 0x060001D4 RID: 468 RVA: 0x0000EF34 File Offset: 0x0000D134
	public void AddMob(Mob c, int id)
	{
		c.SetId(id);
		this.mobs.Add(id, c);
		if (this.attatchDebug)
		{
		Instantiate<GameObject>(this.debug, c.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x060001D5 RID: 469 RVA: 0x0000EF88 File Offset: 0x0000D188
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

	// Token: 0x060001D6 RID: 470 RVA: 0x000035FD File Offset: 0x000017FD
	public int GetNextId()
	{
		return MobManager.mobId++;
	}

	// Token: 0x060001D7 RID: 471 RVA: 0x0000360C File Offset: 0x0000180C
	public void RemoveMob(int mobId)
	{
		this.mobs.Remove(mobId);
	}

	// Token: 0x040001EB RID: 491
	public Dictionary<int, Mob> mobs;

	// Token: 0x040001EC RID: 492
	private static int mobId;

	// Token: 0x040001ED RID: 493
	public static MobManager Instance;

	// Token: 0x040001EE RID: 494
	public LayerMask whatIsRaycastable;

	// Token: 0x040001EF RID: 495
	public bool attatchDebug;

	// Token: 0x040001F0 RID: 496
	public GameObject debug;
}
