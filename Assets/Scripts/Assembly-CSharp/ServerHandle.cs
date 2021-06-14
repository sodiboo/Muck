using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000D5 RID: 213
public class ServerHandle
{
	// Token: 0x0600055A RID: 1370 RVA: 0x0001C6B8 File Offset: 0x0001A8B8
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

	// Token: 0x0600055B RID: 1371 RVA: 0x0001C768 File Offset: 0x0001A968
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

	// Token: 0x0600055C RID: 1372 RVA: 0x00005802 File Offset: 0x00003A02
	public static void StartedLoading(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player.loading)
		{
			return;
		}
		Server.clients[fromClient].player.loading = true;
	}

	// Token: 0x0600055D RID: 1373 RVA: 0x0001C7F4 File Offset: 0x0001A9F4
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

	// Token: 0x0600055E RID: 1374 RVA: 0x00005832 File Offset: 0x00003A32
	public static void PlayerDisconnect(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		ServerHandle.DisconnectPlayer(fromClient);
	}

	// Token: 0x0600055F RID: 1375 RVA: 0x0001C910 File Offset: 0x0001AB10
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

	// Token: 0x06000560 RID: 1376 RVA: 0x0000584D File Offset: 0x00003A4D
	public static void SpawnPlayersRequest(int fromClient, Packet packet)
	{
		Debug.Log("received request to spawn players");
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Server.clients[fromClient].SendIntoGame();
	}

	// Token: 0x06000561 RID: 1377 RVA: 0x0001C97C File Offset: 0x0001AB7C
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

	// Token: 0x06000562 RID: 1378 RVA: 0x0001C9D0 File Offset: 0x0001ABD0
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

	// Token: 0x06000563 RID: 1379 RVA: 0x0001CA9C File Offset: 0x0001AC9C
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

	// Token: 0x06000564 RID: 1380 RVA: 0x0001CBEC File Offset: 0x0001ADEC
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

	// Token: 0x06000565 RID: 1381 RVA: 0x0001CC40 File Offset: 0x0001AE40
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

	// Token: 0x06000566 RID: 1382 RVA: 0x0001CCB4 File Offset: 0x0001AEB4
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

	// Token: 0x06000567 RID: 1383 RVA: 0x0001CD08 File Offset: 0x0001AF08
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

	// Token: 0x06000568 RID: 1384 RVA: 0x0001CD64 File Offset: 0x0001AF64
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

	// Token: 0x06000569 RID: 1385 RVA: 0x0001CEB8 File Offset: 0x0001B0B8
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
			componentInChildren.ServerExecute(fromClient);
			ServerSend.PickupInteract(fromClient, num);
		}
	}

	// Token: 0x0600056A RID: 1386 RVA: 0x0001CF30 File Offset: 0x0001B130
	public static void WeaponInHand(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int objectID = packet.ReadInt(true);
		ServerSend.WeaponInHand(fromClient, objectID);
	}

	// Token: 0x0600056B RID: 1387 RVA: 0x0001CF60 File Offset: 0x0001B160
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

	// Token: 0x0600056C RID: 1388 RVA: 0x0001CFAC File Offset: 0x0001B1AC
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

	// Token: 0x0600056D RID: 1389 RVA: 0x0001D008 File Offset: 0x0001B208
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

	// Token: 0x0600056E RID: 1390 RVA: 0x0001D084 File Offset: 0x0001B284
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

	// Token: 0x0600056F RID: 1391 RVA: 0x0001D0F0 File Offset: 0x0001B2F0
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

	// Token: 0x06000570 RID: 1392 RVA: 0x0001D174 File Offset: 0x0001B374
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

	// Token: 0x06000571 RID: 1393 RVA: 0x0001D248 File Offset: 0x0001B448
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

	// Token: 0x06000572 RID: 1394 RVA: 0x0001D280 File Offset: 0x0001B480
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

	// Token: 0x06000573 RID: 1395 RVA: 0x0000587C File Offset: 0x00003A7C
	public static void PlayerRequestedSpawns(int fromClient, Packet packet)
	{
		Debug.LogError("Player requested spawns, but method is not implemented");
	}

	// Token: 0x06000574 RID: 1396 RVA: 0x0001D454 File Offset: 0x0001B654
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

	// Token: 0x06000575 RID: 1397 RVA: 0x0001D4B0 File Offset: 0x0001B6B0
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

	// Token: 0x06000576 RID: 1398 RVA: 0x0001D4F4 File Offset: 0x0001B6F4
	public static void ShrineCombatStartRequest(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int key = packet.ReadInt(true);
		if (ResourceManager.Instance.list.ContainsKey(key))
		{
			Debug.LogError("contains shrine");
			Interactable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>();
			if (componentInChildren.IsStarted())
			{
				return;
			}
			if (fromClient == LocalClient.instance.myId)
			{
				componentInChildren.LocalExecute();
			}
			componentInChildren.ServerExecute(fromClient);
		}
	}

	// Token: 0x06000577 RID: 1399 RVA: 0x0001D574 File Offset: 0x0001B774
	public static void Interact(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		if (ResourceManager.Instance.list.ContainsKey(num))
		{
			Interactable componentInChildren = ResourceManager.Instance.list[num].GetComponentInChildren<Interactable>();
			if (componentInChildren.IsStarted())
			{
				return;
			}
			if (fromClient == LocalClient.instance.myId)
			{
				componentInChildren.LocalExecute();
			}
			componentInChildren.ServerExecute(fromClient);
			componentInChildren.AllExecute();
			ServerSend.Interact(num, fromClient);
		}
	}

	// Token: 0x06000578 RID: 1400 RVA: 0x0001D5F4 File Offset: 0x0001B7F4
	public static void PlayerDamageMob(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int num = packet.ReadInt(true);
		int num2 = packet.ReadInt(true);
		float sharpness = packet.ReadFloat(true);
		int num3 = packet.ReadInt(true);
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
		int num4 = GameManager.instance.CalculateDamage((float)num2, defense, sharpness, sharpDefense);
		Debug.Log(string.Format("Mob took {0} damage from {1}.", num4, fromClient));
		int num5 = component.hp - num4;
		if (num5 <= 0)
		{
			num5 = 0;
			LootDrop dropTable = component.dropTable;
			float buffMultiplier = 1f;
			Mob component2 = component.GetComponent<Mob>();
			if (component2 && component2.IsBuff())
			{
				buffMultiplier = 1.25f;
			}
			LootExtra.DropMobLoot(component.transform, dropTable, fromClient, buffMultiplier);
			if (component2.bossType != Mob.BossType.None)
			{
				LootExtra.BossLoot(component.transform, mob.bossType);
			}
		}
		component.hp = component.Damage(num5, fromClient, num3, pos);
		float knockbackMultiplier = PowerupInventory.Instance.GetKnockbackMultiplier(Server.clients[fromClient].player.powerups);
		if (((float)num4 / (float)mob.hitable.maxHp > mob.mobType.knockbackThreshold || knockbackMultiplier > 0f) && num5 > 0)
		{
			Vector3 vector = component.transform.position - GameManager.players[fromClient].transform.position;
			vector = VectorExtensions.XZVector(vector).normalized;
			ServerSend.KnockbackMob(num, vector);
			if (num3 == 0)
			{
				num3 = 4;
			}
		}
		if (num5 <= 0 && LocalClient.instance.myId == fromClient)
		{
			PlayerStatus.Instance.Dracula();
		}
		ServerSend.PlayerHitMob(fromClient, num, num5, num3, pos);
	}

	// Token: 0x06000579 RID: 1401 RVA: 0x0001D81C File Offset: 0x0001BA1C
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

	// Token: 0x0600057A RID: 1402 RVA: 0x0001D860 File Offset: 0x0001BA60
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

	// Token: 0x0600057B RID: 1403 RVA: 0x0001D8A4 File Offset: 0x0001BAA4
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
