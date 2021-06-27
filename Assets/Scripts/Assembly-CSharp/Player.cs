using System;
using Steamworks;
using UnityEngine;

// Token: 0x020000C6 RID: 198
public class Player
{
	// Token: 0x060005B9 RID: 1465 RVA: 0x0001D3D0 File Offset: 0x0001B5D0
	public Player(int id, string username, Color color)
	{
		this.id = id;
		this.username = username;
		this.currentHp = 100;
		this.dead = false;
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
		this.armor = new int[4];
		for (int i = 0; i < this.armor.Length; i++)
		{
			this.armor[i] = -1;
		}
	}

	// Token: 0x060005BA RID: 1466 RVA: 0x0001D444 File Offset: 0x0001B644
	public Player(int id, string username, Color color, SteamId steamId)
	{
		this.id = id;
		this.username = username;
		this.steamId = steamId;
		this.currentHp = 100;
		this.dead = false;
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
		this.armor = new int[4];
		for (int i = 0; i < this.armor.Length; i++)
		{
			this.armor[i] = -1;
		}
	}

	// Token: 0x060005BB RID: 1467 RVA: 0x0001D4BE File Offset: 0x0001B6BE
	public void PingPlayer()
	{
		this.lastPingTime = Time.time;
	}

	// Token: 0x060005BC RID: 1468 RVA: 0x0001D4CC File Offset: 0x0001B6CC
	public void UpdateArmor(int armorSlot, int itemId)
	{
		Debug.Log(string.Concat(new object[]
		{
			"slot: ",
			armorSlot,
			", itemid: ",
			itemId
		}));
		this.armor[armorSlot] = itemId;
		this.totalArmor = 0;
		foreach (int num in this.armor)
		{
			if (num != -1)
			{
				this.totalArmor += ItemManager.Instance.allItems[num].armor;
			}
		}
	}

	// Token: 0x060005BD RID: 1469 RVA: 0x0001D55A File Offset: 0x0001B75A
	public void Died()
	{
		this.currentHp = 0;
		this.dead = true;
	}

	// Token: 0x060005BE RID: 1470 RVA: 0x0001D56A File Offset: 0x0001B76A
	public int Damage(int damageDone)
	{
		this.currentHp -= damageDone;
		if (this.currentHp < 0)
		{
			this.currentHp = 0;
		}
		return this.currentHp;
	}

	// Token: 0x0400051B RID: 1307
	public int id;

	// Token: 0x0400051C RID: 1308
	public string username;

	// Token: 0x0400051D RID: 1309
	public bool ready;

	// Token: 0x0400051E RID: 1310
	public bool joined;

	// Token: 0x0400051F RID: 1311
	public bool loading;

	// Token: 0x04000520 RID: 1312
	public Color color;

	// Token: 0x04000521 RID: 1313
	public Vector3 pos;

	// Token: 0x04000522 RID: 1314
	public float yOrientation;

	// Token: 0x04000523 RID: 1315
	public float xOrientation;

	// Token: 0x04000524 RID: 1316
	public bool running;

	// Token: 0x04000525 RID: 1317
	public bool dead;

	// Token: 0x04000526 RID: 1318
	public int ping;

	// Token: 0x04000527 RID: 1319
	public ulong damageDone;

	// Token: 0x04000528 RID: 1320
	public ulong mobsKilled;

	// Token: 0x04000529 RID: 1321
	public ulong damageTaken;

	// Token: 0x0400052A RID: 1322
	public float lastPingTime;

	// Token: 0x0400052B RID: 1323
	public int[] powerups;

	// Token: 0x0400052C RID: 1324
	public int[] armor;

	// Token: 0x0400052D RID: 1325
	public int totalArmor;

	// Token: 0x0400052E RID: 1326
	public SteamId steamId;

	// Token: 0x0400052F RID: 1327
	public int currentHp;
}
