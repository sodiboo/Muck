using System;
using Steamworks;
using UnityEngine;

// Token: 0x020000B7 RID: 183
public class ClientSend : MonoBehaviour
{
	// Token: 0x0600050D RID: 1293 RVA: 0x00019E38 File Offset: 0x00018038
	private static void SendTCPData(Packet packet)
	{
		ClientSend.bytesSent += packet.Length();
		ClientSend.packetsSent++;
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			LocalClient.instance.tcp.SendData(packet);
			return;
		}
		SteamPacketManager.SendPacket(LocalClient.instance.serverHost.Value, packet, P2PSend.Reliable, SteamPacketManager.NetworkChannel.ToServer);
	}

	// Token: 0x0600050E RID: 1294 RVA: 0x00019EA4 File Offset: 0x000180A4
	private static void SendUDPData(Packet packet)
	{
		ClientSend.bytesSent += packet.Length();
		ClientSend.packetsSent++;
		packet.WriteLength();
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			LocalClient.instance.udp.SendData(packet);
			return;
		}
		SteamPacketManager.SendPacket(LocalClient.instance.serverHost.Value, packet, P2PSend.Unreliable, SteamPacketManager.NetworkChannel.ToServer);
	}

	// Token: 0x0600050F RID: 1295 RVA: 0x00019F10 File Offset: 0x00018110
	public static void JoinLobby()
	{
		using (Packet packet = new Packet(2))
		{
			packet.Write(SteamClient.Name);
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000510 RID: 1296 RVA: 0x00019F54 File Offset: 0x00018154
	public static void StartedLoading()
	{
		using (Packet packet = new Packet(33))
		{
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000511 RID: 1297 RVA: 0x00019F8C File Offset: 0x0001818C
	public static void PlayerFinishedLoading()
	{
		using (Packet packet = new Packet(29))
		{
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000512 RID: 1298 RVA: 0x00019FC4 File Offset: 0x000181C4
	public static void WelcomeReceived(int id, string username)
	{
		using (Packet packet = new Packet(1))
		{
			packet.Write(id);
			packet.Write(username);
			Color blue = Color.blue;
			packet.Write(blue.r);
			packet.Write(blue.g);
			packet.Write(blue.b);
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000513 RID: 1299 RVA: 0x0001A034 File Offset: 0x00018234
	public static void PlayerPosition(Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(3))
			{
				packet.Write(pos);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000514 RID: 1300 RVA: 0x0001A088 File Offset: 0x00018288
	public static void PlayerHp(int hp, int maxHp)
	{
		try
		{
			using (Packet packet = new Packet(26))
			{
				packet.Write(hp);
				packet.Write(maxHp);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000515 RID: 1301 RVA: 0x0001A0E4 File Offset: 0x000182E4
	public static void PlayerDied()
	{
		try
		{
			using (Packet packet = new Packet(27))
			{
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000516 RID: 1302 RVA: 0x0001A130 File Offset: 0x00018330
	public static void RevivePlayer(int revivePlayerId, int objectId = -1, bool grave = false)
	{
		try
		{
			using (Packet packet = new Packet(31))
			{
				packet.Write(revivePlayerId);
				packet.Write(grave);
				packet.Write(objectId);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000517 RID: 1303 RVA: 0x0001A194 File Offset: 0x00018394
	public static void PlayerDied(int hp)
	{
		try
		{
			using (Packet packet = new Packet(26))
			{
				packet.Write(hp);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000518 RID: 1304 RVA: 0x0001A1E8 File Offset: 0x000183E8
	public static void PlayerRotation(float yOrientation, float xOrientation)
	{
		try
		{
			using (Packet packet = new Packet(4))
			{
				packet.Write(yOrientation);
				packet.Write(xOrientation);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000519 RID: 1305 RVA: 0x0001A244 File Offset: 0x00018444
	public static void PlayerKilled(Vector3 position, int killedID)
	{
		try
		{
			using (Packet packet = new Packet(7))
			{
				MonoBehaviour.print("sending killed info");
				packet.Write(position);
				packet.Write(killedID);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051A RID: 1306 RVA: 0x0001A2A8 File Offset: 0x000184A8
	public static void PlayerHit(int damage, int hurtPlayer, float sharpness, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(20))
			{
				packet.Write(damage);
				packet.Write(hurtPlayer);
				packet.Write(sharpness);
				packet.Write(hitEffect);
				packet.Write(pos);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051B RID: 1307 RVA: 0x0001A318 File Offset: 0x00018518
	public static void ShootArrow(Vector3 pos, Vector3 rot, float force, int projectileId)
	{
		try
		{
			using (Packet packet = new Packet(28))
			{
				packet.Write(pos);
				packet.Write(rot);
				packet.Write(force);
				packet.Write(projectileId);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051C RID: 1308 RVA: 0x0001A380 File Offset: 0x00018580
	public static void DropItem(int itemID, int amount)
	{
		try
		{
			using (Packet packet = new Packet(10))
			{
				MonoBehaviour.print("sending drop item requesty");
				packet.Write(itemID);
				packet.Write(amount);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051D RID: 1309 RVA: 0x0001A3E4 File Offset: 0x000185E4
	public static void DropItemAtPosition(int itemID, int amount, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(11))
			{
				packet.Write(itemID);
				packet.Write(amount);
				packet.Write(pos);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051E RID: 1310 RVA: 0x0001A448 File Offset: 0x00018648
	public static void PickupItem(int itemID)
	{
		try
		{
			using (Packet packet = new Packet(12))
			{
				packet.Write(itemID);
				ClientSend.SendTCPData(packet);
				MonoBehaviour.print("sending pickup now from: " + LocalClient.instance.myId);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600051F RID: 1311 RVA: 0x0001A4BC File Offset: 0x000186BC
	public static void PickupInteract(int objectId)
	{
		try
		{
			using (Packet packet = new Packet(19))
			{
				packet.Write(objectId);
				ClientSend.SendTCPData(packet);
				MonoBehaviour.print("sending pickup interact now from: " + LocalClient.instance.myId);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000520 RID: 1312 RVA: 0x0001A530 File Offset: 0x00018730
	public static void PlayerHitObject(int damage, int objectID, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(14))
			{
				packet.Write(damage);
				packet.Write(objectID);
				packet.Write(hitEffect);
				packet.Write(pos);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000521 RID: 1313 RVA: 0x0001A598 File Offset: 0x00018798
	public static void SpawnEffect(int effectId, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(30))
			{
				packet.Write(effectId);
				packet.Write(pos);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000522 RID: 1314 RVA: 0x0001A5F4 File Offset: 0x000187F4
	public static void WeaponInHand(int itemID)
	{
		try
		{
			using (Packet packet = new Packet(13))
			{
				packet.Write(itemID);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000523 RID: 1315 RVA: 0x0001A648 File Offset: 0x00018848
	public static void SendArmor(int armorSlot, int itemId)
	{
		try
		{
			using (Packet packet = new Packet(25))
			{
				packet.Write(armorSlot);
				packet.Write(itemId);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000524 RID: 1316 RVA: 0x0001A6A4 File Offset: 0x000188A4
	public static void AnimationUpdate(OnlinePlayer.SharedAnimation animation, bool b)
	{
		try
		{
			using (Packet packet = new Packet(15))
			{
				packet.Write((int)animation);
				packet.Write(b);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000525 RID: 1317 RVA: 0x0001A700 File Offset: 0x00018900
	public static void RequestBuild(int itemId, Vector3 pos, int yRot)
	{
		try
		{
			using (Packet packet = new Packet(16))
			{
				packet.Write(itemId);
				packet.Write(pos);
				packet.Write(yRot);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000526 RID: 1318 RVA: 0x0001A764 File Offset: 0x00018964
	public static void RequestChest(int chestId, bool use)
	{
		try
		{
			using (Packet packet = new Packet(17))
			{
				packet.Write(chestId);
				packet.Write(use);
				MonoBehaviour.print(string.Format("sending new request to chest{0}, use: {1}", chestId, use));
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	// Token: 0x06000527 RID: 1319 RVA: 0x0001A7DC File Offset: 0x000189DC
	public static void ChestUpdate(int chestId, int cellId, int itemId, int amount)
	{
		ChestManager.Instance.SendChestUpdate(chestId, cellId);
		ChestManager.Instance.chests[chestId].UpdateCraftables();
		try
		{
			using (Packet packet = new Packet(18))
			{
				packet.Write(chestId);
				packet.Write(cellId);
				packet.Write(itemId);
				packet.Write(amount);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000528 RID: 1320 RVA: 0x0001A868 File Offset: 0x00018A68
	public static void PingServer()
	{
		try
		{
			using (Packet packet = new Packet(6))
			{
				packet.Write(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x06000529 RID: 1321 RVA: 0x0001A8CC File Offset: 0x00018ACC
	public static void PlayerDisconnect()
	{
		try
		{
			using (Packet packet = new Packet(5))
			{
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052A RID: 1322 RVA: 0x0001A918 File Offset: 0x00018B18
	public static void StartCombatShrine(int shrineId)
	{
		try
		{
			using (Packet packet = new Packet(22))
			{
				packet.Write(shrineId);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052B RID: 1323 RVA: 0x0001A96C File Offset: 0x00018B6C
	public static void Interact(int objectId)
	{
		try
		{
			using (Packet packet = new Packet(32))
			{
				packet.Write(objectId);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052C RID: 1324 RVA: 0x0001A9C0 File Offset: 0x00018BC0
	public static void PlayerDamageMob(int mobId, int damage, float sharpness, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(21))
			{
				packet.Write(mobId);
				packet.Write(damage);
				packet.Write(sharpness);
				packet.Write(hitEffect);
				packet.Write(pos);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052D RID: 1325 RVA: 0x0001AA30 File Offset: 0x00018C30
	public static void SendChatMessage(string msg)
	{
		try
		{
			using (Packet packet = new Packet(23))
			{
				packet.Write(msg);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052E RID: 1326 RVA: 0x0001AA84 File Offset: 0x00018C84
	public static void PlayerPing(Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet(24))
			{
				packet.Write(pos);
				ClientSend.SendUDPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600052F RID: 1327 RVA: 0x0001AAD8 File Offset: 0x00018CD8
	public static void SendShipStatus(Boat.BoatPackets boatPacket, int interactId = -1)
	{
		try
		{
			using (Packet packet = new Packet(34))
			{
				packet.Write((int)boatPacket);
				packet.Write(interactId);
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x04000485 RID: 1157
	public static int packetsSent;

	// Token: 0x04000486 RID: 1158
	public static int bytesSent;
}
