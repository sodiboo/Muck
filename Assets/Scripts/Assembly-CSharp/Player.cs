
using Steamworks;
using UnityEngine;

// Token: 0x0200009F RID: 159
public class Player
{
	// Token: 0x060004BA RID: 1210 RVA: 0x00017B7C File Offset: 0x00015D7C
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

	// Token: 0x060004BB RID: 1211 RVA: 0x00017BF0 File Offset: 0x00015DF0
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

	// Token: 0x060004BC RID: 1212 RVA: 0x00017C6A File Offset: 0x00015E6A
	public void PingPlayer()
	{
		this.lastPingTime = Time.time;
	}

	// Token: 0x060004BD RID: 1213 RVA: 0x00017C78 File Offset: 0x00015E78
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

	// Token: 0x060004BE RID: 1214 RVA: 0x00017D06 File Offset: 0x00015F06
	public void Died()
	{
		this.currentHp = 0;
		this.dead = true;
	}

	// Token: 0x060004BF RID: 1215 RVA: 0x00017D16 File Offset: 0x00015F16
	public int Damage(int damageDone)
	{
		this.currentHp -= damageDone;
		if (this.currentHp < 0)
		{
			this.currentHp = 0;
		}
		return this.currentHp;
	}

	// Token: 0x0400040C RID: 1036
	public int id;

	// Token: 0x0400040D RID: 1037
	public string username;

	// Token: 0x0400040E RID: 1038
	public bool ready;

	// Token: 0x0400040F RID: 1039
	public bool joined;

	// Token: 0x04000410 RID: 1040
	public Color color;

	// Token: 0x04000411 RID: 1041
	public Vector3 pos;

	// Token: 0x04000412 RID: 1042
	public float yOrientation;

	// Token: 0x04000413 RID: 1043
	public float xOrientation;

	// Token: 0x04000414 RID: 1044
	public bool running;

	// Token: 0x04000415 RID: 1045
	public bool dead;

	// Token: 0x04000416 RID: 1046
	public int ping;

	// Token: 0x04000417 RID: 1047
	public ulong damageDone;

	// Token: 0x04000418 RID: 1048
	public ulong mobsKilled;

	// Token: 0x04000419 RID: 1049
	public ulong damageTaken;

	// Token: 0x0400041A RID: 1050
	public float lastPingTime;

	// Token: 0x0400041B RID: 1051
	public int[] powerups;

	// Token: 0x0400041C RID: 1052
	public int[] armor;

	// Token: 0x0400041D RID: 1053
	public int totalArmor;

	// Token: 0x0400041E RID: 1054
	public SteamId steamId;

	// Token: 0x0400041F RID: 1055
	public int currentHp;
}
