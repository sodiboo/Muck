using System;
using Steamworks;
using UnityEngine;

// Token: 0x020000B6 RID: 182
public class ClientSend : MonoBehaviour
{
	// Token: 0x0600046C RID: 1132 RVA: 0x00018708 File Offset: 0x00016908
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

	// Token: 0x0600046D RID: 1133 RVA: 0x00018774 File Offset: 0x00016974
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

	// Token: 0x0600046E RID: 1134 RVA: 0x000187E0 File Offset: 0x000169E0
	public static void JoinLobby()
	{
		using (Packet packet = new Packet(2))
		{
			packet.Write(SteamClient.Name);
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x0600046F RID: 1135 RVA: 0x00018824 File Offset: 0x00016A24
	public static void StartedLoading()
	{
		using (Packet packet = new Packet(33))
		{
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000470 RID: 1136 RVA: 0x0001885C File Offset: 0x00016A5C
	public static void PlayerFinishedLoading()
	{
		using (Packet packet = new Packet(29))
		{
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000471 RID: 1137 RVA: 0x00018894 File Offset: 0x00016A94
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

	// Token: 0x06000472 RID: 1138 RVA: 0x00018904 File Offset: 0x00016B04
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

	// Token: 0x06000473 RID: 1139 RVA: 0x00018958 File Offset: 0x00016B58
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

	// Token: 0x06000474 RID: 1140 RVA: 0x000189B4 File Offset: 0x00016BB4
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

	// Token: 0x06000475 RID: 1141 RVA: 0x00018A00 File Offset: 0x00016C00
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

	// Token: 0x06000476 RID: 1142 RVA: 0x00018A64 File Offset: 0x00016C64
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

	// Token: 0x06000477 RID: 1143 RVA: 0x00018AB8 File Offset: 0x00016CB8
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

	// Token: 0x06000478 RID: 1144 RVA: 0x00018B14 File Offset: 0x00016D14
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

	// Token: 0x06000479 RID: 1145 RVA: 0x00018B78 File Offset: 0x00016D78
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

	// Token: 0x0600047A RID: 1146 RVA: 0x00018BE8 File Offset: 0x00016DE8
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

	// Token: 0x0600047B RID: 1147 RVA: 0x00018C50 File Offset: 0x00016E50
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

	// Token: 0x0600047C RID: 1148 RVA: 0x00018CB4 File Offset: 0x00016EB4
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

	// Token: 0x0600047D RID: 1149 RVA: 0x00018D18 File Offset: 0x00016F18
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

	// Token: 0x0600047E RID: 1150 RVA: 0x00018D8C File Offset: 0x00016F8C
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

	// Token: 0x0600047F RID: 1151 RVA: 0x00018E00 File Offset: 0x00017000
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

	// Token: 0x06000480 RID: 1152 RVA: 0x00018E68 File Offset: 0x00017068
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

	// Token: 0x06000481 RID: 1153 RVA: 0x00018EC4 File Offset: 0x000170C4
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

	// Token: 0x06000482 RID: 1154 RVA: 0x00018F18 File Offset: 0x00017118
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

	// Token: 0x06000483 RID: 1155 RVA: 0x00018F74 File Offset: 0x00017174
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

	// Token: 0x06000484 RID: 1156 RVA: 0x00018FD0 File Offset: 0x000171D0
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

	// Token: 0x06000485 RID: 1157 RVA: 0x00019034 File Offset: 0x00017234
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
			Debug.Log(message);
		}
	}

	// Token: 0x06000486 RID: 1158 RVA: 0x000190AC File Offset: 0x000172AC
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

	// Token: 0x06000487 RID: 1159 RVA: 0x00019138 File Offset: 0x00017338
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

	// Token: 0x06000488 RID: 1160 RVA: 0x0001919C File Offset: 0x0001739C
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

	// Token: 0x06000489 RID: 1161 RVA: 0x000191E8 File Offset: 0x000173E8
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

	// Token: 0x0600048A RID: 1162 RVA: 0x0001923C File Offset: 0x0001743C
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

	// Token: 0x0600048B RID: 1163 RVA: 0x00019290 File Offset: 0x00017490
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

	// Token: 0x0600048C RID: 1164 RVA: 0x00019300 File Offset: 0x00017500
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

	// Token: 0x0600048D RID: 1165 RVA: 0x00019354 File Offset: 0x00017554
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

	// Token: 0x04000433 RID: 1075
	public static int packetsSent;

	// Token: 0x04000434 RID: 1076
	public static int bytesSent;
}
