using System;
using Steamworks;
using UnityEngine;

// Token: 0x02000090 RID: 144
public class ClientSend : MonoBehaviour
{
	// Token: 0x06000413 RID: 1043 RVA: 0x00014950 File Offset: 0x00012B50
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

	// Token: 0x06000414 RID: 1044 RVA: 0x000149BC File Offset: 0x00012BBC
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

	// Token: 0x06000415 RID: 1045 RVA: 0x00014A28 File Offset: 0x00012C28
	public static void JoinLobby()
	{
		using (Packet packet = new Packet((int)ClientPackets.joinLobby))
		{
			packet.Write(SteamClient.Name);
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000416 RID: 1046 RVA: 0x00014A6C File Offset: 0x00012C6C
	public static void PlayerFinishedLoading()
	{
		using (Packet packet = new Packet((int)ClientPackets.finishedLoading))
		{
			ClientSend.SendTCPData(packet);
		}
	}

	// Token: 0x06000417 RID: 1047 RVA: 0x00014AA4 File Offset: 0x00012CA4
	public static void WelcomeReceived(int id, string username)
	{
		using (Packet packet = new Packet((int)ClientPackets.welcomeReceived))
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

	// Token: 0x06000418 RID: 1048 RVA: 0x00014B14 File Offset: 0x00012D14
	public static void PlayerPosition(Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerPosition))
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

	// Token: 0x06000419 RID: 1049 RVA: 0x00014B68 File Offset: 0x00012D68
	public static void PlayerHp(int hp, int maxHp)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerHp))
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

	// Token: 0x0600041A RID: 1050 RVA: 0x00014BC4 File Offset: 0x00012DC4
	public static void PlayerDied()
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerDied))
			{
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600041B RID: 1051 RVA: 0x00014C10 File Offset: 0x00012E10
	public static void RevivePlayer(int revivePlayerId, int objectId = -1, bool grave = false)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.reviveRequest))
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

	// Token: 0x0600041C RID: 1052 RVA: 0x00014C74 File Offset: 0x00012E74
	public static void PlayerDied(int hp)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerHp))
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

	// Token: 0x0600041D RID: 1053 RVA: 0x00014CC8 File Offset: 0x00012EC8
	public static void PlayerRotation(float yOrientation, float xOrientation)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerRotation))
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

	// Token: 0x0600041E RID: 1054 RVA: 0x00014D24 File Offset: 0x00012F24
	public static void PlayerKilled(Vector3 position, int killedID)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerKilled))
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

	// Token: 0x0600041F RID: 1055 RVA: 0x00014D88 File Offset: 0x00012F88
	public static void PlayerHit(int damage, int hurtPlayer, float sharpness, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerHit))
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

	// Token: 0x06000420 RID: 1056 RVA: 0x00014DF8 File Offset: 0x00012FF8
	public static void ShootArrow(Vector3 pos, Vector3 rot, float force, int projectileId)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.shootArrow))
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

	// Token: 0x06000421 RID: 1057 RVA: 0x00014E60 File Offset: 0x00013060
	public static void DropItem(int itemID, int amount)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.dropItem))
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

	// Token: 0x06000422 RID: 1058 RVA: 0x00014EC4 File Offset: 0x000130C4
	public static void DropItemAtPosition(int itemID, int amount, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.dropItemAtPosition))
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

	// Token: 0x06000423 RID: 1059 RVA: 0x00014F28 File Offset: 0x00013128
	public static void PickupItem(int itemID)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.pickupItem))
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

	// Token: 0x06000424 RID: 1060 RVA: 0x00014F9C File Offset: 0x0001319C
	public static void PickupInteract(int objectId)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.pickupInteract))
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

	// Token: 0x06000425 RID: 1061 RVA: 0x00015010 File Offset: 0x00013210
	public static void PlayerHitObject(int damage, int objectID, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerHitObject))
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

	// Token: 0x06000426 RID: 1062 RVA: 0x00015078 File Offset: 0x00013278
	public static void SpawnEffect(int effectId, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.spawnEffect))
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

	// Token: 0x06000427 RID: 1063 RVA: 0x000150D4 File Offset: 0x000132D4
	public static void WeaponInHand(int itemID)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.weaponInHand))
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

	// Token: 0x06000428 RID: 1064 RVA: 0x00015128 File Offset: 0x00013328
	public static void SendArmor(int armorSlot, int itemId)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.sendArmor))
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

	// Token: 0x06000429 RID: 1065 RVA: 0x00015184 File Offset: 0x00013384
	public static void AnimationUpdate(OnlinePlayer.SharedAnimation animation, bool b)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.animationUpdate))
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

	// Token: 0x0600042A RID: 1066 RVA: 0x000151E0 File Offset: 0x000133E0
	public static void RequestBuild(int itemId, Vector3 pos, int yRot)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.requestBuild))
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

	// Token: 0x0600042B RID: 1067 RVA: 0x00015244 File Offset: 0x00013444
	public static void RequestChest(int chestId, bool use)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.requestChest))
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

	// Token: 0x0600042C RID: 1068 RVA: 0x000152BC File Offset: 0x000134BC
	public static void ChestUpdate(int chestId, int cellId, int itemId, int amount)
	{
		ChestManager.Instance.SendChestUpdate(chestId, cellId);
		ChestManager.Instance.chests[chestId].UpdateCraftables();
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.updateChest))
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

	// Token: 0x0600042D RID: 1069 RVA: 0x00015348 File Offset: 0x00013548
	public static void PingServer()
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.sendPing))
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

	// Token: 0x0600042E RID: 1070 RVA: 0x000153AC File Offset: 0x000135AC
	public static void PlayerDisconnect()
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.sendDisconnect))
			{
				ClientSend.SendTCPData(packet);
			}
		}
		catch (Exception message)
		{
			Debug.Log(message);
		}
	}

	// Token: 0x0600042F RID: 1071 RVA: 0x000153F8 File Offset: 0x000135F8
	public static void StartCombatShrine(int shrineId)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.shrineCombatStart))
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

	// Token: 0x06000430 RID: 1072 RVA: 0x0001544C File Offset: 0x0001364C
	public static void PlayerDamageMob(int mobId, int damage, float sharpness, int hitEffect, Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerDamageMob))
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

	// Token: 0x06000431 RID: 1073 RVA: 0x000154BC File Offset: 0x000136BC
	public static void SendChatMessage(string msg)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.sendChatMessage))
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

	// Token: 0x06000432 RID: 1074 RVA: 0x00015510 File Offset: 0x00013710
	public static void PlayerPing(Vector3 pos)
	{
		try
		{
			using (Packet packet = new Packet((int)ClientPackets.playerPing))
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

	// Token: 0x04000378 RID: 888
	public static int packetsSent;

	// Token: 0x04000379 RID: 889
	public static int bytesSent;
}
