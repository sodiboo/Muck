using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000067 RID: 103
public class MobManager : MonoBehaviour
{
	// Token: 0x06000248 RID: 584 RVA: 0x0000D73E File Offset: 0x0000B93E
	private void Awake()
	{
		MobManager.Instance = this;
		MobManager.mobId = 0;
		this.mobs = new Dictionary<int, Mob>();
	}

	// Token: 0x06000249 RID: 585 RVA: 0x0000D758 File Offset: 0x0000B958
	public void AddMob(Mob c, int id)
	{
		c.SetId(id);
		this.mobs.Add(id, c);
		if (this.attatchDebug)
		{
			Instantiate<GameObject>(this.debug, c.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x0600024A RID: 586 RVA: 0x0000D7AC File Offset: 0x0000B9AC
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

	// Token: 0x0600024B RID: 587 RVA: 0x0000D824 File Offset: 0x0000BA24
	public int GetNextId()
	{
		return MobManager.mobId++;
	}

	// Token: 0x0600024C RID: 588 RVA: 0x0000D833 File Offset: 0x0000BA33
	public void RemoveMob(int mobId)
	{
		this.mobs.Remove(mobId);
	}

	// Token: 0x04000268 RID: 616
	public Dictionary<int, Mob> mobs;

	// Token: 0x04000269 RID: 617
	private static int mobId;

	// Token: 0x0400026A RID: 618
	public static MobManager Instance;

	// Token: 0x0400026B RID: 619
	public LayerMask whatIsRaycastable;

	// Token: 0x0400026C RID: 620
	public bool attatchDebug;

	// Token: 0x0400026D RID: 621
	public GameObject debug;
}
