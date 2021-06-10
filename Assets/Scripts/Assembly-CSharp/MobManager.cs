
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004B RID: 75
public class MobManager : MonoBehaviour
{
	// Token: 0x060001AA RID: 426 RVA: 0x0000A5E6 File Offset: 0x000087E6
	private void Awake()
	{
		MobManager.Instance = this;
		MobManager.mobId = 0;
		this.mobs = new Dictionary<int, Mob>();
	}

	// Token: 0x060001AB RID: 427 RVA: 0x0000A600 File Offset: 0x00008800
	public void AddMob(Mob c, int id)
	{
		c.SetId(id);
		this.mobs.Add(id, c);
		if (this.attatchDebug)
		{
		Instantiate(this.debug, c.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x060001AC RID: 428 RVA: 0x0000A654 File Offset: 0x00008854
	public int GetActiveEnemies()
	{
		int num = 0;
		using (Dictionary<int, Mob>.ValueCollection.Enumerator enumerator = this.mobs.Values.GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				if (enumerator.Current.mobType.behaviour != MobType.MobBehaviour.Neutral)
				{
					num++;
				}
			}
		}
		return num;
	}

	// Token: 0x060001AD RID: 429 RVA: 0x0000A6B8 File Offset: 0x000088B8
	public int GetNextId()
	{
		return MobManager.mobId++;
	}

	// Token: 0x060001AE RID: 430 RVA: 0x0000A6C7 File Offset: 0x000088C7
	public void RemoveMob(int mobId)
	{
		this.mobs.Remove(mobId);
	}

	// Token: 0x040001AF RID: 431
	public Dictionary<int, Mob> mobs;

	// Token: 0x040001B0 RID: 432
	private static int mobId;

	// Token: 0x040001B1 RID: 433
	public static MobManager Instance;

	// Token: 0x040001B2 RID: 434
	public LayerMask whatIsRaycastable;

	// Token: 0x040001B3 RID: 435
	public bool attatchDebug;

	// Token: 0x040001B4 RID: 436
	public GameObject debug;
}
