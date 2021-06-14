using System;
using Steamworks;
using UnityEngine;

// Token: 0x020000D2 RID: 210
public class Player
{
	// Token: 0x06000542 RID: 1346 RVA: 0x0001BFA0 File Offset: 0x0001A1A0
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

	// Token: 0x06000543 RID: 1347 RVA: 0x0001C014 File Offset: 0x0001A214
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

	// Token: 0x06000544 RID: 1348 RVA: 0x00005762 File Offset: 0x00003962
	public void PingPlayer()
	{
		this.lastPingTime = Time.time;
	}

	// Token: 0x06000545 RID: 1349 RVA: 0x0001C090 File Offset: 0x0001A290
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

	// Token: 0x06000546 RID: 1350 RVA: 0x0000576F File Offset: 0x0000396F
	public void Died()
	{
		this.currentHp = 0;
		this.dead = true;
	}

	// Token: 0x06000547 RID: 1351 RVA: 0x0000577F File Offset: 0x0000397F
	public int Damage(int damageDone)
	{
		this.currentHp -= damageDone;
		if (this.currentHp < 0)
		{
			this.currentHp = 0;
		}
		return this.currentHp;
	}

	// Token: 0x040004E8 RID: 1256
	public int id;

	// Token: 0x040004E9 RID: 1257
	public string username;

	// Token: 0x040004EA RID: 1258
	public bool ready;

	// Token: 0x040004EB RID: 1259
	public bool joined;

	// Token: 0x040004EC RID: 1260
	public bool loading;

	// Token: 0x040004ED RID: 1261
	public Color color;

	// Token: 0x040004EE RID: 1262
	public Vector3 pos;

	// Token: 0x040004EF RID: 1263
	public float yOrientation;

	// Token: 0x040004F0 RID: 1264
	public float xOrientation;

	// Token: 0x040004F1 RID: 1265
	public bool running;

	// Token: 0x040004F2 RID: 1266
	public bool dead;

	// Token: 0x040004F3 RID: 1267
	public int ping;

	// Token: 0x040004F4 RID: 1268
	public ulong damageDone;

	// Token: 0x040004F5 RID: 1269
	public ulong mobsKilled;

	// Token: 0x040004F6 RID: 1270
	public ulong damageTaken;

	// Token: 0x040004F7 RID: 1271
	public float lastPingTime;

	// Token: 0x040004F8 RID: 1272
	public int[] powerups;

	// Token: 0x040004F9 RID: 1273
	public int[] armor;

	// Token: 0x040004FA RID: 1274
	public int totalArmor;

	// Token: 0x040004FB RID: 1275
	public SteamId steamId;

	// Token: 0x040004FC RID: 1276
	public int currentHp;
}
