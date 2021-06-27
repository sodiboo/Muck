using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000C8 RID: 200
public class ServerHandle
{
	// Token: 0x060005CD RID: 1485 RVA: 0x0001DB9C File Offset: 0x0001BD9C
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

	// Token: 0x060005CE RID: 1486 RVA: 0x0001DC4C File Offset: 0x0001BE4C
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

	// Token: 0x060005CF RID: 1487 RVA: 0x0001DCD8 File Offset: 0x0001BED8
	public static void StartedLoading(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player.loading)
		{
			return;
		}
		Server.clients[fromClient].player.loading = true;
	}

	// Token: 0x060005D0 RID: 1488 RVA: 0x0001DD08 File Offset: 0x0001BF08
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

	// Token: 0x060005D1 RID: 1489 RVA: 0x0001DE24 File Offset: 0x0001C024
	public static void PlayerDisconnect(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		ServerHandle.DisconnectPlayer(fromClient);
	}

	// Token: 0x060005D2 RID: 1490 RVA: 0x0001DE40 File Offset: 0x0001C040
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

	// Token: 0x060005D3 RID: 1491 RVA: 0x0001DEAC File Offset: 0x0001C0AC
	public static void SpawnPlayersRequest(int fromClient, Packet packet)
	{
		Debug.Log("received request to spawn players");
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		Server.clients[fromClient].SendIntoGame();
	}

	// Token: 0x060005D4 RID: 1492 RVA: 0x0001DEDC File Offset: 0x0001C0DC
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

	// Token: 0x060005D5 RID: 1493 RVA: 0x0001DF30 File Offset: 0x0001C130
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

	// Token: 0x060005D6 RID: 1494 RVA: 0x0001DFFC File Offset: 0x0001C1FC
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

	// Token: 0x060005D7 RID: 1495 RVA: 0x0001E14C File Offset: 0x0001C34C
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

	// Token: 0x060005D8 RID: 1496 RVA: 0x0001E1A0 File Offset: 0x0001C3A0
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

	// Token: 0x060005D9 RID: 1497 RVA: 0x0001E214 File Offset: 0x0001C414
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

	// Token: 0x060005DA RID: 1498 RVA: 0x0001E268 File Offset: 0x0001C468
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

	// Token: 0x060005DB RID: 1499 RVA: 0x0001E2C4 File Offset: 0x0001C4C4
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

	// Token: 0x060005DC RID: 1500 RVA: 0x0001E418 File Offset: 0x0001C618
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

	// Token: 0x060005DD RID: 1501 RVA: 0x0001E490 File Offset: 0x0001C690
	public static void WeaponInHand(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int objectID = packet.ReadInt(true);
		ServerSend.WeaponInHand(fromClient, objectID);
	}

	// Token: 0x060005DE RID: 1502 RVA: 0x0001E4C0 File Offset: 0x0001C6C0
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

	// Token: 0x060005DF RID: 1503 RVA: 0x0001E50C File Offset: 0x0001C70C
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

	// Token: 0x060005E0 RID: 1504 RVA: 0x0001E568 File Offset: 0x0001C768
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

	// Token: 0x060005E1 RID: 1505 RVA: 0x0001E5E4 File Offset: 0x0001C7E4
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

	// Token: 0x060005E2 RID: 1506 RVA: 0x0001E650 File Offset: 0x0001C850
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

	// Token: 0x060005E3 RID: 1507 RVA: 0x0001E6D4 File Offset: 0x0001C8D4
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

	// Token: 0x060005E4 RID: 1508 RVA: 0x0001E7A8 File Offset: 0x0001C9A8
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

	// Token: 0x060005E5 RID: 1509 RVA: 0x0001E7E0 File Offset: 0x0001C9E0
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

	// Token: 0x060005E6 RID: 1510 RVA: 0x0001E9B2 File Offset: 0x0001CBB2
	public static void PlayerRequestedSpawns(int fromClient, Packet packet)
	{
		Debug.LogError("Player requested spawns, but method is not implemented");
	}

	// Token: 0x060005E7 RID: 1511 RVA: 0x0001E9C0 File Offset: 0x0001CBC0
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

	// Token: 0x060005E8 RID: 1512 RVA: 0x0001EA1C File Offset: 0x0001CC1C
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

	// Token: 0x060005E9 RID: 1513 RVA: 0x0001EA60 File Offset: 0x0001CC60
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

	// Token: 0x060005EA RID: 1514 RVA: 0x0001EAE0 File Offset: 0x0001CCE0
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

	// Token: 0x060005EB RID: 1515 RVA: 0x0001EB60 File Offset: 0x0001CD60
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

	// Token: 0x060005EC RID: 1516 RVA: 0x0001ED88 File Offset: 0x0001CF88
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

	// Token: 0x060005ED RID: 1517 RVA: 0x0001EDCC File Offset: 0x0001CFCC
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

	// Token: 0x060005EE RID: 1518 RVA: 0x0001EE10 File Offset: 0x0001D010
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

	// Token: 0x060005EF RID: 1519 RVA: 0x0001EE60 File Offset: 0x0001D060
	public static void ReceiveShipUpdate(int fromClient, Packet packet)
	{
		if (Server.clients[fromClient].player == null)
		{
			return;
		}
		int type = packet.ReadInt(true);
		int interactId = packet.ReadInt(true);
		ServerSend.SendShipUpdate(fromClient, type, interactId);
	}
}
