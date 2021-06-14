using System;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;

// Token: 0x020000D6 RID: 214
public class ServerSend
{
	// Token: 0x0600057D RID: 1405 RVA: 0x0001D8F4 File Offset: 0x0001BAF4
	private static void SendTCPData(int toClient, Packet packet)
	{
		Packet packet2 = new Packet();
		packet2.SetBytes(packet.CloneBytes());
		packet2.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			Server.clients[toClient].tcp.SendData(packet2);
			return;
		}
		SteamPacketManager.SendPacket(Server.clients[toClient].player.steamId.Value, packet2, ServerSend.TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
	}

	// Token: 0x0600057E RID: 1406 RVA: 0x0001D968 File Offset: 0x0001BB68
	private static void SendUDPData(int toClient, Packet packet)
	{
		Packet packet2 = new Packet();
		packet2.SetBytes(packet.CloneBytes());
		packet2.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			Server.clients[toClient].udp.SendData(packet2);
			return;
		}
		SteamPacketManager.SendPacket(Server.clients[toClient].player.steamId.Value, packet2, ServerSend.UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
	}

	// Token: 0x0600057F RID: 1407 RVA: 0x0001D9DC File Offset: 0x0001BBDC
	private static void SendTCPDataToAll(Packet packet)
	{
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			for (int i = 1; i < Server.MaxPlayers; i++)
			{
				Server.clients[i].tcp.SendData(packet);
			}
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
			}
		}
	}

	// Token: 0x06000580 RID: 1408 RVA: 0x0001DA98 File Offset: 0x0001BC98
	private static void SendTCPDataToAll(int exceptClient, Packet packet)
	{
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			for (int i = 1; i < Server.MaxPlayers; i++)
			{
				if (i != exceptClient)
				{
					Server.clients[i].tcp.SendData(packet);
				}
			}
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null && SteamLobby.steamIdToClientId[client.player.steamId.Value] != exceptClient)
			{
				SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
			}
		}
	}

	// Token: 0x06000581 RID: 1409 RVA: 0x0001DB74 File Offset: 0x0001BD74
	private static void SendTCPDataToAll(int[] exceptClients, Packet packet)
	{
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			for (int i = 1; i < Server.MaxPlayers; i++)
			{
				bool flag = false;
				foreach (int num in exceptClients)
				{
					if (i == num)
					{
						flag = true;
					}
				}
				if (!flag)
				{
					Server.clients[i].tcp.SendData(packet);
				}
			}
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				bool flag2 = false;
				foreach (int num2 in exceptClients)
				{
					if (SteamLobby.steamIdToClientId[client.player.steamId.Value] == num2)
					{
						flag2 = true;
					}
				}
				if (!flag2)
				{
					SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
				}
			}
		}
	}

	// Token: 0x06000582 RID: 1410 RVA: 0x0001DC94 File Offset: 0x0001BE94
	private static void SendUDPDataToAll(Packet packet)
	{
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			for (int i = 1; i < Server.MaxPlayers; i++)
			{
				Server.clients[i].udp.SendData(packet);
			}
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
			}
		}
	}

	// Token: 0x06000583 RID: 1411 RVA: 0x0001DD50 File Offset: 0x0001BF50
	private static void SendUDPDataToAll(int exceptClient, Packet packet)
	{
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			for (int i = 1; i < Server.MaxPlayers; i++)
			{
				if (i != exceptClient)
				{
					Server.clients[i].udp.SendData(packet);
				}
			}
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null && SteamLobby.steamIdToClientId[client.player.steamId.Value] != exceptClient)
			{
				SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
			}
		}
	}

	// Token: 0x06000584 RID: 1412 RVA: 0x0001DE2C File Offset: 0x0001C02C
	public static void Welcome(int toClient, string msg)
	{
		using (Packet packet = new Packet(1))
		{
			packet.Write(msg);
			packet.Write(NetworkManager.Clock);
			packet.Write(toClient);
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x06000585 RID: 1413 RVA: 0x0001DE7C File Offset: 0x0001C07C
	public static void StartGame(int playerLobbyId, GameSettings settings)
	{
		using (Packet packet = new Packet(12))
		{
			packet.Write(playerLobbyId);
			packet.Write(settings.Seed);
			packet.Write((int)settings.gameMode);
			packet.Write((int)settings.friendlyFire);
			packet.Write((int)settings.difficulty);
			packet.Write((int)settings.gameLength);
			packet.Write((int)settings.multiplayer);
			List<Player> list = new List<Player>();
			for (int i = 0; i < Server.clients.Values.Count; i++)
			{
				if (Server.clients[i] != null && Server.clients[i].player != null)
				{
					list.Add(Server.clients[i].player);
				}
			}
			packet.Write(list.Count);
			foreach (Player player in list)
			{
				packet.Write(player.id);
				packet.Write(player.username);
			}
			Debug.Log("Sending start game packet");
			ServerSend.SendTCPData(playerLobbyId, packet);
		}
	}

	// Token: 0x06000586 RID: 1414 RVA: 0x0001DFD8 File Offset: 0x0001C1D8
	public static void ConnectionSuccessful(int toClient)
	{
		using (Packet packet = new Packet(8))
		{
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x06000587 RID: 1415 RVA: 0x0001E010 File Offset: 0x0001C210
	public static void PlayerDied(int deadPlayerId, Vector3 deathPos, Vector3 gravePos)
	{
		using (Packet packet = new Packet(6))
		{
			Debug.Log("Player" + deadPlayerId + " has been killed, sending to players");
			packet.Write(deadPlayerId);
			packet.Write(gravePos);
			ServerSend.SendTCPDataToAll(deadPlayerId, packet);
		}
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			return;
		}
		using (Packet packet2 = new Packet(52))
		{
			int nextId = ResourceManager.Instance.GetNextId();
			packet2.Write(deadPlayerId);
			packet2.Write(nextId);
			packet2.Write(gravePos);
			ServerSend.SendTCPDataToAll(packet2);
		}
	}

	// Token: 0x06000588 RID: 1416 RVA: 0x0001E0C4 File Offset: 0x0001C2C4
	public static void RespawnPlayer(int respawnId)
	{
		using (Packet packet = new Packet(43))
		{
			packet.Write(respawnId);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000589 RID: 1417 RVA: 0x0001E104 File Offset: 0x0001C304
	public static void RevivePlayer(int fromClient, int revivedId, bool shrine, int objectID)
	{
		using (Packet packet = new Packet(51))
		{
			packet.Write(fromClient);
			packet.Write(revivedId);
			packet.Write(shrine);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x0600058A RID: 1418 RVA: 0x0001E164 File Offset: 0x0001C364
	public static void PlayerReady(int fromClient, bool ready)
	{
		using (Packet packet = new Packet(15))
		{
			packet.Write(fromClient);
			packet.Write(ready);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x0600058B RID: 1419 RVA: 0x0001E1AC File Offset: 0x0001C3AC
	public static void PlayerReady(int fromClient, bool ready, int toClient)
	{
		using (Packet packet = new Packet(15))
		{
			packet.Write(fromClient);
			packet.Write(ready);
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x0600058C RID: 1420 RVA: 0x0001E1F4 File Offset: 0x0001C3F4
	public static void DropItem(int fromClient, int itemId, int amount, int objectID)
	{
		using (Packet packet = new Packet(17))
		{
			packet.Write(fromClient);
			packet.Write(itemId);
			packet.Write(amount);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x0600058D RID: 1421 RVA: 0x0001E254 File Offset: 0x0001C454
	public static void DropItemAtPosition(int itemId, int amount, int objectID, Vector3 pos)
	{
		using (Packet packet = new Packet(27))
		{
			packet.Write(itemId);
			packet.Write(amount);
			packet.Write(objectID);
			packet.Write(pos);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x0600058E RID: 1422 RVA: 0x0001E2B4 File Offset: 0x0001C4B4
	public static void DropPowerupAtPosition(int itemId, int objectID, Vector3 pos)
	{
		using (Packet packet = new Packet(35))
		{
			packet.Write(itemId);
			packet.Write(objectID);
			packet.Write(pos);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x0600058F RID: 1423 RVA: 0x0001E30C File Offset: 0x0001C50C
	public static void DropResources(int fromClient, int dropTableId, int droppedItemID)
	{
		using (Packet packet = new Packet(21))
		{
			packet.Write(fromClient);
			packet.Write(dropTableId);
			packet.Write(droppedItemID);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000590 RID: 1424 RVA: 0x0001E358 File Offset: 0x0001C558
	public static void PickupItem(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(18))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000591 RID: 1425 RVA: 0x0001E3A0 File Offset: 0x0001C5A0
	public static void PickupInteract(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(26))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000592 RID: 1426 RVA: 0x0001E3F0 File Offset: 0x0001C5F0
	public static void WeaponInHand(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(19))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x06000593 RID: 1427 RVA: 0x0001E438 File Offset: 0x0001C638
	public static void SendBuild(int fromClient, int itemId, int newObjectId, Vector3 pos, int yRot)
	{
		using (Packet packet = new Packet(23))
		{
			packet.Write(fromClient);
			packet.Write(itemId);
			packet.Write(newObjectId);
			packet.Write(pos);
			packet.Write(yRot);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000594 RID: 1428 RVA: 0x0001E4A0 File Offset: 0x0001C6A0
	public static void AnimationUpdate(int fromClient, int animation, bool b)
	{
		using (Packet packet = new Packet(22))
		{
			packet.Write(fromClient);
			packet.Write(animation);
			packet.Write(b);
			Vector3 pos = Server.clients[fromClient].player.pos;
			foreach (Client client in Server.clients.Values)
			{
				if (((client != null) ? client.player : null) != null && client.id != fromClient && Vector3.Distance(pos, client.player.pos) <= 100f)
				{
					ServerSend.SendUDPData(client.id, packet);
				}
			}
		}
	}

	// Token: 0x06000595 RID: 1429 RVA: 0x0001E574 File Offset: 0x0001C774
	public static void ShootArrow(Vector3 pos, Vector3 rot, float force, int arrowId, int playerId)
	{
		using (Packet packet = new Packet(44))
		{
			packet.Write(pos);
			packet.Write(rot);
			packet.Write(force);
			packet.Write(arrowId);
			packet.Write(playerId);
			ServerSend.SendTCPDataToAll(playerId, packet);
		}
	}

	// Token: 0x06000596 RID: 1430 RVA: 0x0001E5D4 File Offset: 0x0001C7D4
	public static void OpenChest(int fromClient, int chestId, bool use)
	{
		using (Packet packet = new Packet(24))
		{
			packet.Write(fromClient);
			packet.Write(chestId);
			packet.Write(use);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000597 RID: 1431 RVA: 0x0001E620 File Offset: 0x0001C820
	public static void UpdateChest(int fromClient, int chestId, int cellId, int itemId, int amount)
	{
		using (Packet packet = new Packet(25))
		{
			packet.Write(fromClient);
			packet.Write(chestId);
			packet.Write(cellId);
			packet.Write(itemId);
			packet.Write(amount);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000598 RID: 1432 RVA: 0x0001E688 File Offset: 0x0001C888
	public static void PlayerHitObject(int fromClient, int objectID, int hp, int hitEffect, Vector3 pos)
	{
		using (Packet packet = new Packet(20))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			packet.Write(hp);
			packet.Write(hitEffect);
			packet.Write(pos);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000599 RID: 1433 RVA: 0x0001E6F0 File Offset: 0x0001C8F0
	public static void SpawnEffect(int effectId, Vector3 pos, int fromClient)
	{
		using (Packet packet = new Packet(49))
		{
			packet.Write(effectId);
			packet.Write(pos);
			ServerSend.SendUDPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x0600059A RID: 1434 RVA: 0x0001E738 File Offset: 0x0001C938
	public static void HitPlayer(int fromClient, int damage, float hpRatioEstimate, int hurtPlayerId, int hitEffect, Vector3 pos)
	{
		using (Packet packet = new Packet(28))
		{
			packet.Write(fromClient);
			packet.Write(damage);
			packet.Write(hpRatioEstimate);
			packet.Write(hurtPlayerId);
			packet.Write(hitEffect);
			packet.Write(pos);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x0600059B RID: 1435 RVA: 0x0001E79C File Offset: 0x0001C99C
	public static void SpawnPlayer(int toClient, Player player, Vector3 pos)
	{
		using (Packet packet = new Packet(2))
		{
			Debug.Log(string.Concat(new object[]
			{
				"spawning player, id: ",
				player.id,
				", sending to ",
				toClient
			}));
			packet.Write(player.id);
			packet.Write(player.username);
			Vector3 value = new Vector3(player.color.r, player.color.g, player.color.b);
			packet.Write(value);
			player.pos = pos;
			packet.Write(pos);
			packet.Write(player.yOrientation);
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x0600059C RID: 1436 RVA: 0x0001E86C File Offset: 0x0001CA6C
	public static void PlayerHp(int fromId, float hpRatio)
	{
		using (Packet packet = new Packet(42))
		{
			packet.Write(fromId);
			packet.Write(hpRatio);
			ServerSend.SendUDPDataToAll(fromId, packet);
		}
	}

	// Token: 0x0600059D RID: 1437 RVA: 0x0001E8B4 File Offset: 0x0001CAB4
	public static void PlayerPosition(Player player, int t)
	{
		using (Packet packet = new Packet(3))
		{
			packet.Write(player.id);
			packet.Write(player.pos);
			ServerSend.SendUDPDataToAll(player.id, packet);
		}
	}

	// Token: 0x0600059E RID: 1438 RVA: 0x0001E908 File Offset: 0x0001CB08
	public static void PlayerRotation(Player player)
	{
		using (Packet packet = new Packet(4))
		{
			packet.Write(player.id);
			packet.Write(player.yOrientation);
			packet.Write(player.xOrientation);
			ServerSend.SendUDPDataToAll(player.id, packet);
		}
	}

	// Token: 0x0600059F RID: 1439 RVA: 0x0001E968 File Offset: 0x0001CB68
	public static void PingPlayer(int player, string ms)
	{
		using (Packet packet = new Packet(7))
		{
			packet.Write(player);
			packet.Write(ms);
			ServerSend.SendUDPData(player, packet);
		}
	}

	// Token: 0x060005A0 RID: 1440 RVA: 0x0001E9B0 File Offset: 0x0001CBB0
	public static void DisconnectPlayer(int player)
	{
		using (Packet packet = new Packet(5))
		{
			packet.Write(player);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x060005A1 RID: 1441 RVA: 0x0001E9F0 File Offset: 0x0001CBF0
	public static void ShrineStart(int[] mobIds, int shrineId)
	{
		using (Packet packet = new Packet(34))
		{
			packet.Write(shrineId);
			int num = mobIds.Length;
			packet.Write(num);
			for (int i = 0; i < num; i++)
			{
				packet.Write(mobIds[i]);
			}
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A2 RID: 1442 RVA: 0x0001EA58 File Offset: 0x0001CC58
	public static void MobMove(int mobId, Vector3 pos)
	{
		using (Packet packet = new Packet(30))
		{
			packet.Write(mobId);
			packet.Write(pos);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A3 RID: 1443 RVA: 0x0001EAA8 File Offset: 0x0001CCA8
	public static void MobSetDestination(int mobId, Vector3 dest)
	{
		using (Packet packet = new Packet(31))
		{
			packet.Write(mobId);
			packet.Write(dest);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A4 RID: 1444 RVA: 0x0001EAF8 File Offset: 0x0001CCF8
	public static void SendMobTarget(int mobId, int targetId)
	{
		using (Packet packet = new Packet(54))
		{
			packet.Write(mobId);
			packet.Write(targetId);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A5 RID: 1445 RVA: 0x0001EB48 File Offset: 0x0001CD48
	public static void MobSpawn(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier)
	{
		using (Packet packet = new Packet(29))
		{
			packet.Write(pos);
			packet.Write(mobType);
			packet.Write(mobId);
			packet.Write(multiplier);
			packet.Write(bossMultiplier);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A6 RID: 1446 RVA: 0x0001EBB0 File Offset: 0x0001CDB0
	public static void MobAttack(int mobId, int targetPlayerId, int attackAnimationIndex)
	{
		using (Packet packet = new Packet(32))
		{
			packet.Write(mobId);
			packet.Write(targetPlayerId);
			packet.Write(attackAnimationIndex);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A7 RID: 1447 RVA: 0x0001EC08 File Offset: 0x0001CE08
	public static void MobSpawnProjectile(Vector3 pos, Vector3 dir, float force, int itemId, int mobObjectId)
	{
		using (Packet packet = new Packet(46))
		{
			packet.Write(pos);
			packet.Write(dir);
			packet.Write(force);
			packet.Write(itemId);
			packet.Write(mobObjectId);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A8 RID: 1448 RVA: 0x0001EC70 File Offset: 0x0001CE70
	public static void PlayerHitMob(int fromClient, int mobId, int hpLeft, int hitEffect, Vector3 pos)
	{
		using (Packet packet = new Packet(33))
		{
			packet.Write(fromClient);
			packet.Write(mobId);
			packet.Write(hpLeft);
			packet.Write(hitEffect);
			packet.Write(pos);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005A9 RID: 1449 RVA: 0x0001ECD8 File Offset: 0x0001CED8
	public static void KnockbackMob(int mobId, Vector3 dir)
	{
		using (Packet packet = new Packet(48))
		{
			packet.Write(mobId);
			packet.Write(dir);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x060005AA RID: 1450 RVA: 0x0001ED20 File Offset: 0x0001CF20
	public static void Interact(int interactId, int fromId)
	{
		using (Packet packet = new Packet(53))
		{
			packet.Write(interactId);
			packet.Write(fromId);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005AB RID: 1451 RVA: 0x0001ED70 File Offset: 0x0001CF70
	public static void MobZoneSpawn(Vector3 pos, int mobType, int mobId, int mobZoneId)
	{
		using (Packet packet = new Packet(36))
		{
			packet.Write(pos);
			packet.Write(mobType);
			packet.Write(mobId);
			packet.Write(mobZoneId);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005AC RID: 1452 RVA: 0x0001EDD0 File Offset: 0x0001CFD0
	public static void PickupZoneSpawn(Vector3 pos, int entityId, int mobId, int mobZoneId)
	{
		using (Packet packet = new Packet(38))
		{
			packet.Write(pos);
			packet.Write(entityId);
			packet.Write(mobId);
			packet.Write(mobZoneId);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005AD RID: 1453 RVA: 0x0001EE30 File Offset: 0x0001D030
	public static void MobZoneToggle(bool show, int objectID)
	{
		using (Packet packet = new Packet(37))
		{
			packet.Write(show);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x060005AE RID: 1454 RVA: 0x0001EE78 File Offset: 0x0001D078
	public static void SendChatMessage(int fromClient, string username, string msg)
	{
		using (Packet packet = new Packet(39))
		{
			packet.Write(fromClient);
			packet.Write(username);
			packet.Write(msg);
			ServerSend.SendUDPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x060005AF RID: 1455 RVA: 0x0001EEC8 File Offset: 0x0001D0C8
	public static void SendPing(int fromClient, Vector3 pos, string username)
	{
		using (Packet packet = new Packet(40))
		{
			packet.Write(pos);
			packet.Write(username);
			ServerSend.SendUDPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x060005B0 RID: 1456 RVA: 0x0001EF10 File Offset: 0x0001D110
	public static void SendArmor(int fromClient, int armorSlot, int itemId)
	{
		using (Packet packet = new Packet(41))
		{
			packet.Write(fromClient);
			packet.Write(armorSlot);
			packet.Write(itemId);
			ServerSend.SendTCPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x060005B1 RID: 1457 RVA: 0x0001EF60 File Offset: 0x0001D160
	public static void NewDay(int day)
	{
		using (Packet packet = new Packet(47))
		{
			packet.Write(day);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005B2 RID: 1458 RVA: 0x0001EFA8 File Offset: 0x0001D1A8
	public static void GameOver(int winnerId = -2)
	{
		using (Packet packet = new Packet(11))
		{
			packet.Write(winnerId);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x060005B3 RID: 1459 RVA: 0x0001EFF0 File Offset: 0x0001D1F0
	public static void PlayerFinishedLoading(int playerId)
	{
		using (Packet packet = new Packet(50))
		{
			packet.Write(playerId);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x04000505 RID: 1285
	private static P2PSend TCPvariant = P2PSend.Reliable;

	// Token: 0x04000506 RID: 1286
	private static P2PSend UDPVariant = P2PSend.Unreliable;
}
