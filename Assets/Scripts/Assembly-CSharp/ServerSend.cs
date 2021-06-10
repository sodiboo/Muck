
using System.Collections.Generic;
using Steamworks;
using UnityEngine;

// Token: 0x020000A2 RID: 162
public class ServerSend
{
	// Token: 0x060004EF RID: 1263 RVA: 0x000194F0 File Offset: 0x000176F0
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

	// Token: 0x060004F0 RID: 1264 RVA: 0x00019564 File Offset: 0x00017764
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

	// Token: 0x060004F1 RID: 1265 RVA: 0x000195D8 File Offset: 0x000177D8
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
				Debug.Log("Sending packet to id: " + client.id);
				SteamPacketManager.SendPacket(client.player.steamId.Value, packet, ServerSend.TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
			}
		}
	}

	// Token: 0x060004F2 RID: 1266 RVA: 0x000196AC File Offset: 0x000178AC
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

	// Token: 0x060004F3 RID: 1267 RVA: 0x00019788 File Offset: 0x00017988
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

	// Token: 0x060004F4 RID: 1268 RVA: 0x000198A8 File Offset: 0x00017AA8
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

	// Token: 0x060004F5 RID: 1269 RVA: 0x00019964 File Offset: 0x00017B64
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

	// Token: 0x060004F6 RID: 1270 RVA: 0x00019A40 File Offset: 0x00017C40
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

	// Token: 0x060004F7 RID: 1271 RVA: 0x00019A90 File Offset: 0x00017C90
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

	// Token: 0x060004F8 RID: 1272 RVA: 0x00019BC8 File Offset: 0x00017DC8
	public static void ConnectionSuccessful(int toClient)
	{
		using (Packet packet = new Packet(8))
		{
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x060004F9 RID: 1273 RVA: 0x00019C00 File Offset: 0x00017E00
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

	// Token: 0x060004FA RID: 1274 RVA: 0x00019CB4 File Offset: 0x00017EB4
	public static void RespawnPlayer(int respawnId)
	{
		using (Packet packet = new Packet(43))
		{
			packet.Write(respawnId);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x060004FB RID: 1275 RVA: 0x00019CF4 File Offset: 0x00017EF4
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

	// Token: 0x060004FC RID: 1276 RVA: 0x00019D54 File Offset: 0x00017F54
	public static void PlayerReady(int fromClient, bool ready)
	{
		using (Packet packet = new Packet(15))
		{
			packet.Write(fromClient);
			packet.Write(ready);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x060004FD RID: 1277 RVA: 0x00019D9C File Offset: 0x00017F9C
	public static void PlayerReady(int fromClient, bool ready, int toClient)
	{
		using (Packet packet = new Packet(15))
		{
			packet.Write(fromClient);
			packet.Write(ready);
			ServerSend.SendTCPData(toClient, packet);
		}
	}

	// Token: 0x060004FE RID: 1278 RVA: 0x00019DE4 File Offset: 0x00017FE4
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

	// Token: 0x060004FF RID: 1279 RVA: 0x00019E44 File Offset: 0x00018044
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

	// Token: 0x06000500 RID: 1280 RVA: 0x00019EA4 File Offset: 0x000180A4
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

	// Token: 0x06000501 RID: 1281 RVA: 0x00019EFC File Offset: 0x000180FC
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

	// Token: 0x06000502 RID: 1282 RVA: 0x00019F48 File Offset: 0x00018148
	public static void PickupItem(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(18))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000503 RID: 1283 RVA: 0x00019F90 File Offset: 0x00018190
	public static void PickupInteract(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(26))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000504 RID: 1284 RVA: 0x00019FE0 File Offset: 0x000181E0
	public static void WeaponInHand(int fromClient, int objectID)
	{
		using (Packet packet = new Packet(19))
		{
			packet.Write(fromClient);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x06000505 RID: 1285 RVA: 0x0001A028 File Offset: 0x00018228
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

	// Token: 0x06000506 RID: 1286 RVA: 0x0001A090 File Offset: 0x00018290
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

	// Token: 0x06000507 RID: 1287 RVA: 0x0001A164 File Offset: 0x00018364
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

	// Token: 0x06000508 RID: 1288 RVA: 0x0001A1C4 File Offset: 0x000183C4
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

	// Token: 0x06000509 RID: 1289 RVA: 0x0001A210 File Offset: 0x00018410
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

	// Token: 0x0600050A RID: 1290 RVA: 0x0001A278 File Offset: 0x00018478
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

	// Token: 0x0600050B RID: 1291 RVA: 0x0001A2E0 File Offset: 0x000184E0
	public static void SpawnEffect(int effectId, Vector3 pos, int fromClient)
	{
		using (Packet packet = new Packet(49))
		{
			packet.Write(effectId);
			packet.Write(pos);
			ServerSend.SendUDPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x0600050C RID: 1292 RVA: 0x0001A328 File Offset: 0x00018528
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

	// Token: 0x0600050D RID: 1293 RVA: 0x0001A38C File Offset: 0x0001858C
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

	// Token: 0x0600050E RID: 1294 RVA: 0x0001A45C File Offset: 0x0001865C
	public static void PlayerHp(int fromId, float hpRatio)
	{
		using (Packet packet = new Packet(42))
		{
			packet.Write(fromId);
			packet.Write(hpRatio);
			ServerSend.SendUDPDataToAll(fromId, packet);
		}
	}

	// Token: 0x0600050F RID: 1295 RVA: 0x0001A4A4 File Offset: 0x000186A4
	public static void PlayerPosition(Player player, int t)
	{
		using (Packet packet = new Packet(3))
		{
			packet.Write(player.id);
			packet.Write(player.pos);
			ServerSend.SendUDPDataToAll(player.id, packet);
		}
	}

	// Token: 0x06000510 RID: 1296 RVA: 0x0001A4F8 File Offset: 0x000186F8
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

	// Token: 0x06000511 RID: 1297 RVA: 0x0001A558 File Offset: 0x00018758
	public static void PingPlayer(int player, string ms)
	{
		using (Packet packet = new Packet(7))
		{
			packet.Write(player);
			packet.Write(ms);
			ServerSend.SendUDPData(player, packet);
		}
	}

	// Token: 0x06000512 RID: 1298 RVA: 0x0001A5A0 File Offset: 0x000187A0
	public static void DisconnectPlayer(int player)
	{
		using (Packet packet = new Packet(5))
		{
			packet.Write(player);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x06000513 RID: 1299 RVA: 0x0001A5E0 File Offset: 0x000187E0
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

	// Token: 0x06000514 RID: 1300 RVA: 0x0001A648 File Offset: 0x00018848
	public static void MobMove(int mobId, Vector3 pos)
	{
		using (Packet packet = new Packet(30))
		{
			packet.Write(mobId);
			packet.Write(pos);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000515 RID: 1301 RVA: 0x0001A698 File Offset: 0x00018898
	public static void MobSetDestination(int mobId, Vector3 dest)
	{
		using (Packet packet = new Packet(31))
		{
			packet.Write(mobId);
			packet.Write(dest);
			ServerSend.SendUDPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000516 RID: 1302 RVA: 0x0001A6E8 File Offset: 0x000188E8
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

	// Token: 0x06000517 RID: 1303 RVA: 0x0001A750 File Offset: 0x00018950
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

	// Token: 0x06000518 RID: 1304 RVA: 0x0001A7A8 File Offset: 0x000189A8
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

	// Token: 0x06000519 RID: 1305 RVA: 0x0001A810 File Offset: 0x00018A10
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

	// Token: 0x0600051A RID: 1306 RVA: 0x0001A878 File Offset: 0x00018A78
	public static void KnockbackMob(int mobId, Vector3 dir)
	{
		using (Packet packet = new Packet(48))
		{
			packet.Write(mobId);
			packet.Write(dir);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x0600051B RID: 1307 RVA: 0x0001A8C0 File Offset: 0x00018AC0
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

	// Token: 0x0600051C RID: 1308 RVA: 0x0001A920 File Offset: 0x00018B20
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

	// Token: 0x0600051D RID: 1309 RVA: 0x0001A980 File Offset: 0x00018B80
	public static void MobZoneToggle(bool show, int objectID)
	{
		using (Packet packet = new Packet(37))
		{
			packet.Write(show);
			packet.Write(objectID);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x0600051E RID: 1310 RVA: 0x0001A9C8 File Offset: 0x00018BC8
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

	// Token: 0x0600051F RID: 1311 RVA: 0x0001AA18 File Offset: 0x00018C18
	public static void SendPing(int fromClient, Vector3 pos, string username)
	{
		using (Packet packet = new Packet(40))
		{
			packet.Write(pos);
			packet.Write(username);
			ServerSend.SendUDPDataToAll(fromClient, packet);
		}
	}

	// Token: 0x06000520 RID: 1312 RVA: 0x0001AA60 File Offset: 0x00018C60
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

	// Token: 0x06000521 RID: 1313 RVA: 0x0001AAB0 File Offset: 0x00018CB0
	public static void NewDay(int day)
	{
		using (Packet packet = new Packet(47))
		{
			packet.Write(day);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000522 RID: 1314 RVA: 0x0001AAF8 File Offset: 0x00018CF8
	public static void GameOver(int winnerId = -2)
	{
		using (Packet packet = new Packet(11))
		{
			packet.Write(winnerId);
			ServerSend.SendTCPDataToAll(LocalClient.instance.myId, packet);
		}
	}

	// Token: 0x06000523 RID: 1315 RVA: 0x0001AB40 File Offset: 0x00018D40
	public static void PlayerFinishedLoading(int playerId)
	{
		using (Packet packet = new Packet(50))
		{
			packet.Write(playerId);
			ServerSend.SendTCPDataToAll(packet);
		}
	}

	// Token: 0x04000428 RID: 1064
	private static P2PSend TCPvariant = P2PSend.Reliable;

	// Token: 0x04000429 RID: 1065
	private static P2PSend UDPVariant = P2PSend.Unreliable;
}
