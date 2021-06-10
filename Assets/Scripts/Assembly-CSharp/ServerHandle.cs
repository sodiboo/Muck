
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A1 RID: 161
public class ServerHandle
{
	// Token: 0x060004CE RID: 1230 RVA: 0x0001830C File Offset: 0x0001650C
	public static void WelcomeReceived(int fromClient, Packet packet)
	{
		int num = packet.ReadInt(true);
		string playerName = packet.ReadString(true);
		Color color = new Color(packet.ReadFloat(true), packet.ReadFloat(true), packet.ReadFloat(true));
		if (fromClient != num)
		{
			Debug.Log("Something went very wrong in ServerHandle");
		}
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			Debug.Log(string.Format("{0} connected successfully and is now player {1}.", Server.clients[fromClient].tcp.socket.Client.RemoteEndPoint, fromClient));
			Server.clients[fromClient].StartClient(playerName, color);
		}
		ServerSend.ConnectionSuccessful(fromClient);
		Server.clients[fromClient].SendIntoGame();
	}

	// Token: 0x060004CF RID: 1231 RVA: 0x000183BC File Offset: 0x000165BC
	public static void JoinRequest(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player.joined)
		{
			Debug.LogError("Player already joined: " + fromClient);
			return;
		}
		Debug.LogError("Player wants to join, id: " + fromClient);
		Server.clients[fromClient].player.joined = true;
		Server.clients[fromClient].player.username = packet.ReadString(true);
		ServerSend.Welcome(fromClient, "weclome");
	}

	// Token: 0x060004D0 RID: 1232 RVA: 0x00018448 File Offset: 0x00016648
	public static void PlayerFinishedLoading(int fromClient, Packet packet)
	{
		Debug.Log("Player finished loading: " + fromClient);
		Server.clients[fromClient].player.ready = true;
		ServerSend.PlayerFinishedLoading(fromClient);
		int num = 0;
		int num2 = 0;
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				num2++;
				if (client.player.ready)
				{
					num++;
				}
			}
		}
		if (num < num2)
		{
			return;
		}
		Debug.Log(string.Concat(new object[]
		{
			"ready players: ",
			num,
			" / ",
			num2
		}));
		List<Vector3> spawnPositions;
		if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
		{
			spawnPositions = GameManager.instance.FindSurvivalSpawnPositions(num2);
		}
		else
		{
			spawnPositions = GameManager.instance.FindVersusSpawnPositions(num2);
		}
		if (num >= num2)
		{
			GameManager.instance.SendPlayersIntoGame(spawnPositions);
		}
	}

	// Token: 0x060004D1 RID: 1233 RVA: 0x00018564 File Offset: 0x00016764
	public static void PlayerDisconnect(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		ServerHandle.DisconnectPlayer(fromClient);
	}

	// Token: 0x060004D2 RID: 1234 RVA: 0x00018580 File Offset: 0x00016780
	public static void DisconnectPlayer(int fromClient)
	{
		ServerSend.DisconnectPlayer(fromClient);
		try
		{
			string msg = Server.clients[fromClient].player.username + " disconnected";
			ServerSend.SendChatMessage(-1, "Server", msg);
		}
		catch
		{
			Debug.LogError("Failed to send disconnect message to clients");
		}
		Server.clients[fromClient] = null;
	}

	// Token: 0x060004D3 RID: 1235 RVA: 0x000185EC File Offset: 0x000167EC
	public static void SpawnPlayersRequest(int fromClient, Packet packet)
	{
		Debug.Log("received request to spawn players");
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Server.clients[fromClient].SendIntoGame();
	}

	// Token: 0x060004D4 RID: 1236 RVA: 0x0001861C File Offset: 0x0001681C
	public static void PlayerHp(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int num2 = packet.ReadInt(true);
		Server.clients[fromClient].player.currentHp = num;
		float hpRatio = (float)num / (float)num2;
		ServerSend.PlayerHp(fromClient, hpRatio);
	}

	// Token: 0x060004D5 RID: 1237 RVA: 0x00018670 File Offset: 0x00016870
	public static void PlayerDied(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		if (Server.clients[fromClient].player.dead)
		{
			return;
		}
		Server.clients[fromClient].player.Died();
		GameManager.players[fromClient].dead = true;
		Vector3 gravePosition = GameManager.instance.GetGravePosition(fromClient);
		ServerSend.SendChatMessage(-1, "", "<color=orange>" + Server.clients[fromClient].player.username + " has died.");
		ServerSend.PlayerDied(fromClient, Server.clients[fromClient].player.pos, gravePosition);
		if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
		{
			GameManager.instance.CheckIfGameOver();
		}
	}

	// Token: 0x060004D6 RID: 1238 RVA: 0x0001873C File Offset: 0x0001693C
	public static void RevivePlayer(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		bool flag = packet.ReadBool(true);
		if (!GameManager.players[num].dead)
		{
			Debug.LogError("not dead lol");
			return;
		}
		Server.clients[num].player.dead = false;
		GameManager.players[num].dead = false;
		GameManager.instance.RespawnPlayer(num, Vector3.zero);
		if (fromClient == LocalClient.instance.myId && !flag)
		{
			InventoryUI.Instance.UseMoney(RespawnTotemUI.Instance.GetRevivePrice());
			RespawnTotemUI.Instance.Refresh();
		}
		int num2 = packet.ReadInt(true);
		if (ResourceManager.Instance.list.ContainsKey(num2))
		{
			ResourceManager.Instance.list[num2].GetComponentInChildren<Interactable>().AllExecute();
		}
		ServerSend.SendChatMessage(-1, "", string.Concat(new string[]
		{
			"<color=orange>",
			Server.clients[fromClient].player.username,
			" has revived ",
			Server.clients[num].player.username,
			"."
		}));
		ServerSend.RevivePlayer(fromClient, num, flag, num2);
	}

	// Token: 0x060004D7 RID: 1239 RVA: 0x0001888C File Offset: 0x00016A8C
	public static void PlayerPosition(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Vector3 pos = packet.ReadVector3(true);
		Server.clients[fromClient].player.pos = pos;
		ServerSend.PlayerPosition(Server.clients[fromClient].player, 0);
	}

	// Token: 0x060004D8 RID: 1240 RVA: 0x000188E0 File Offset: 0x00016AE0
	public static void PlayerRotation(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		float yOrientation = packet.ReadFloat(true);
		float xOrientation = packet.ReadFloat(true);
		Server.clients[fromClient].player.yOrientation = yOrientation;
		Server.clients[fromClient].player.xOrientation = xOrientation;
		ServerSend.PlayerRotation(Server.clients[fromClient].player);
	}

	// Token: 0x060004D9 RID: 1241 RVA: 0x00018954 File Offset: 0x00016B54
	public static void ItemDropped(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropItem(fromClient, itemId, amount, nextId);
		ServerSend.DropItem(fromClient, itemId, amount, nextId);
	}

	// Token: 0x060004DA RID: 1242 RVA: 0x000189A8 File Offset: 0x00016BA8
	public static void ItemDroppedAtPosition(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropItemAtPosition(num, amount, pos, num);
		ServerSend.DropItemAtPosition(num, amount, nextId, pos);
	}

	// Token: 0x060004DB RID: 1243 RVA: 0x00018A04 File Offset: 0x00016C04
	public static void ItemPickedUp(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		Debug.Log(string.Concat(new object[]
		{
			"object: ",
			num,
			" picked up by player: ",
			fromClient
		}));
		Item component = ItemManager.Instance.list[num].GetComponent<Item>();
		if (component.powerup)
		{
			Server.clients[fromClient].player.powerups[component.powerup.id]++;
		}
		if (!ItemManager.Instance.list.ContainsKey(num))
		{
			return;
		}
		if (fromClient == LocalClient.instance.myId)
		{
			if (component.item)
			{
				InventoryUI.Instance.AddItemToInventory(component.item);
			}
			else if (component.powerup)
			{
				Server.clients[fromClient].player.powerups[component.powerup.id]++;
				PowerupInventory.Instance.AddPowerup(component.powerup.name, component.powerup.id, num);
			}
		}
		ItemManager.Instance.PickupItem(num);
		ServerSend.PickupItem(fromClient, num);
	}

	// Token: 0x060004DC RID: 1244 RVA: 0x00018B58 File Offset: 0x00016D58
	public static void ItemInteract(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		if (ResourceManager.Instance.list.ContainsKey(num))
		{
			Interactable componentInChildren = ResourceManager.Instance.list[num].GetComponentInChildren<Interactable>();
			if (fromClient == LocalClient.instance.myId)
			{
				componentInChildren.LocalExecute();
			}
			componentInChildren.AllExecute();
			componentInChildren.ServerExecute();
			ServerSend.PickupInteract(fromClient, num);
		}
	}

	// Token: 0x060004DD RID: 1245 RVA: 0x00018BD0 File Offset: 0x00016DD0
	public static void WeaponInHand(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int objectID = packet.ReadInt(true);
		ServerSend.WeaponInHand(fromClient, objectID);
	}

	// Token: 0x060004DE RID: 1246 RVA: 0x00018C00 File Offset: 0x00016E00
	public static void AnimationUpdate(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int animation = packet.ReadInt(true);
		bool b = packet.ReadBool(true);
		ServerSend.AnimationUpdate(fromClient, animation, b);
	}

	// Token: 0x060004DF RID: 1247 RVA: 0x00018C4C File Offset: 0x00016E4C
	public static void ShootArrow(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Vector3 pos = packet.ReadVector3(true);
		Vector3 rot = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int arrowId = packet.ReadInt(true);
		ServerSend.ShootArrow(pos, rot, force, arrowId, fromClient);
	}

	// Token: 0x060004E0 RID: 1248 RVA: 0x00018CA8 File Offset: 0x00016EA8
	public static void RequestChest(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		bool flag = packet.ReadBool(true);
		if (!ChestManager.Instance.chests.ContainsKey(num))
		{
			return;
		}
		if (flag)
		{
			if (!ChestManager.Instance.IsChestOpen(num))
			{
				ChestManager.Instance.UseChest(num, true);
				ServerSend.OpenChest(fromClient, num, true);
				return;
			}
		}
		else
		{
			ChestManager.Instance.UseChest(num, false);
			ServerSend.OpenChest(fromClient, num, false);
		}
	}

	// Token: 0x060004E1 RID: 1249 RVA: 0x00018D24 File Offset: 0x00016F24
	public static void UpdateChest(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int chestId = packet.ReadInt(true);
		int cellId = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		Debug.Log("received chest update");
		Debug.Log("now sending to other players");
		ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
		ServerSend.UpdateChest(fromClient, chestId, cellId, itemId, amount);
	}

	// Token: 0x060004E2 RID: 1250 RVA: 0x00018D90 File Offset: 0x00016F90
	public static void RequestBuild(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		Vector3 vector = packet.ReadVector3(true);
		int num2 = packet.ReadInt(true);
		int num3;
		if (ItemManager.Instance.allItems[num].type == InventoryItem.ItemType.Storage)
		{
			num3 = ResourceManager.Instance.GetNextId();
		}
		else
		{
			num3 = BuildManager.Instance.GetNextBuildId();
		}
		BuildManager.Instance.BuildItem(fromClient, num, num3, vector, num2);
		ServerSend.SendBuild(fromClient, num, num3, vector, num2);
	}

	// Token: 0x060004E3 RID: 1251 RVA: 0x00018E14 File Offset: 0x00017014
	public static void PlayerHitObject(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int num2 = packet.ReadInt(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		if (!ResourceManager.Instance.list.ContainsKey(num2))
		{
			return;
		}
		Hitable component = ResourceManager.Instance.list[num2].GetComponent<Hitable>();
		if (component.hp <= 0)
		{
			return;
		}
		int num3 = component.hp - num;
		component.hp = component.Damage(num3, fromClient, hitEffect, pos);
		Debug.Log("object hit from: " + fromClient);
		if (num3 <= 0)
		{
			num3 = 0;
			Debug.Log("dropping item");
			LootExtra.CheckDrop(fromClient, (HitableResource)component);
		}
		ServerSend.PlayerHitObject(fromClient, num2, num3, hitEffect, pos);
	}

	// Token: 0x060004E4 RID: 1252 RVA: 0x00018EE8 File Offset: 0x000170E8
	public static void SpawnEffect(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int effectId = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ServerSend.SpawnEffect(effectId, pos, fromClient);
	}

	// Token: 0x060004E5 RID: 1253 RVA: 0x00018F20 File Offset: 0x00017120
	public static void PlayerHit(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int num2 = packet.ReadInt(true);
		float sharpness = packet.ReadFloat(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		if (!GameManager.players[num2])
		{
			return;
		}
		if (fromClient == num2)
		{
			num = (int)((float)num * GameManager.instance.MobDamageMultiplier());
		}
		else if (GameManager.gameSettings.friendlyFire == GameSettings.FriendlyFire.Off && GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
		{
			return;
		}
		float hardness = 0.5f;
		float num3 = PowerupInventory.Instance.GetDefenseMultiplier(Server.clients[num2].player.powerups);
		num3 += (float)Server.clients[num2].player.totalArmor;
		int num4 = GameManager.instance.CalculateDamage((float)num, num3, sharpness, hardness);
		Debug.Log(string.Format("Player{0} took {1} damage from {2} and had armor {3}", new object[]
		{
			num2,
			num4,
			fromClient,
			num3
		}));
		Player player = Server.clients[num2].player;
		int num5 = player.Damage(num4);
		float num6 = (float)num5 / (float)PowerupInventory.Instance.GetMaxHpAndShield(player.powerups);
		if (num6 < 0f)
		{
			num6 = 0f;
		}
		Debug.Log(string.Concat(new object[]
		{
			"estimated hp left: ",
			num5,
			", ratio: ",
			num6,
			", maxhp: ",
			PowerupInventory.Instance.GetMaxHpAndShield(player.powerups)
		}));
		if (num2 == fromClient)
		{
			Debug.Log("Player took damage from mob btw lol");
		}
		ServerSend.HitPlayer(fromClient, num4, num6, num2, hitEffect, pos);
	}

	// Token: 0x060004E6 RID: 1254 RVA: 0x000190F2 File Offset: 0x000172F2
	public static void PlayerRequestedSpawns(int fromClient, Packet packet)
	{
		Debug.LogError("Player requested spawns, but method is not implemented");
	}

	// Token: 0x060004E7 RID: 1255 RVA: 0x00019100 File Offset: 0x00017300
	public static void Ready(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Debug.Log("Recevied ready from player: " + fromClient);
		bool ready = packet.ReadBool(true);
		ServerSend.PlayerReady(fromClient, ready);
		Server.clients[fromClient].player.ready = ready;
	}

	// Token: 0x060004E8 RID: 1256 RVA: 0x0001915C File Offset: 0x0001735C
	public static void PingReceived(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		string ms = packet.ReadString(true);
		Server.clients[fromClient].player.PingPlayer();
		ServerSend.PingPlayer(fromClient, ms);
	}

	// Token: 0x060004E9 RID: 1257 RVA: 0x000191A0 File Offset: 0x000173A0
	public static void ShrineCombatStartRequest(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int key = packet.ReadInt(true);
		if (ResourceManager.Instance.list.ContainsKey(key))
		{
			ShrineInteractable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<ShrineInteractable>();
			if (componentInChildren.started)
			{
				return;
			}
			if (fromClient == LocalClient.instance.myId)
			{
				componentInChildren.LocalExecute();
			}
			componentInChildren.ServerExecute();
		}
	}

	// Token: 0x060004EA RID: 1258 RVA: 0x00019214 File Offset: 0x00017414
	public static void PlayerDamageMob(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int num2 = packet.ReadInt(true);
		float sharpness = packet.ReadFloat(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		if (!MobManager.Instance.mobs.ContainsKey(num))
		{
			return;
		}
		Mob mob = MobManager.Instance.mobs[num];
		if (!mob)
		{
			return;
		}
		HitableMob component = mob.GetComponent<HitableMob>();
		if (component.hp <= 0)
		{
			return;
		}
		float sharpDefense = component.mob.mobType.sharpDefense;
		float defense = component.mob.mobType.defense;
		int num3 = GameManager.instance.CalculateDamage((float)num2, defense, sharpness, sharpDefense);
		Debug.Log(string.Format("Mob took {0} damage from {1}.", num3, fromClient));
		int num4 = component.hp - num3;
		if (num4 <= 0)
		{
			num4 = 0;
			LootDrop dropTable = component.dropTable;
			float buffMultiplier = 1f;
			Mob component2 = component.GetComponent<Mob>();
			if (component2 && component2.IsBuff())
			{
				buffMultiplier = 2f;
			}
			LootExtra.DropMobLoot(component.transform, dropTable, fromClient, buffMultiplier);
		}
		component.hp = component.Damage(num4, fromClient, hitEffect, pos);
		float knockbackMultiplier = PowerupInventory.Instance.GetKnockbackMultiplier(Server.clients[fromClient].player.powerups);
		if (((float)num3 / (float)mob.hitable.maxHp > mob.mobType.knockbackThreshold || knockbackMultiplier > 0f) && num4 > 0)
		{
			Vector3 vector = component.transform.position - GameManager.players[fromClient].transform.position;
			vector = VectorExtensions.XZVector(vector).normalized;
			ServerSend.KnockbackMob(num, vector);
		}
		if (num4 <= 0 && LocalClient.instance.myId == fromClient)
		{
			PlayerStatus.Instance.Dracula();
		}
		ServerSend.PlayerHitMob(fromClient, num, num4, hitEffect, pos);
	}

	// Token: 0x060004EB RID: 1259 RVA: 0x00019418 File Offset: 0x00017618
	public static void ReceiveChatMessage(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		string msg = packet.ReadString(true);
		string username = GameManager.players[fromClient].username;
		ServerSend.SendChatMessage(fromClient, username, msg);
	}

	// Token: 0x060004EC RID: 1260 RVA: 0x0001945C File Offset: 0x0001765C
	public static void ReceivePing(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Vector3 pos = packet.ReadVector3(true);
		string username = GameManager.players[fromClient].username;
		ServerSend.SendPing(fromClient, pos, username);
	}

	// Token: 0x060004ED RID: 1261 RVA: 0x000194A0 File Offset: 0x000176A0
	public static void ReceiveArmor(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int armorSlot = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		Server.clients[fromClient].player.UpdateArmor(armorSlot, itemId);
		ServerSend.SendArmor(fromClient, armorSlot, itemId);
	}
}
