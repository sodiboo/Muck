using System.Collections.Generic;
using Steamworks;
using UnityEngine;

public class ServerSend
{
    private static P2PSend TCPvariant = P2PSend.Reliable;

    private static P2PSend UDPVariant = P2PSend.Unreliable;

    private static void SendTCPData(int toClient, Packet packet)
    {
        Packet packet2 = new Packet();
        packet2.SetBytes(packet.CloneBytes());
        packet2.WriteLength();
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            Server.clients[toClient].tcp.SendData(packet2);
        }
        else
        {
            SteamPacketManager.SendPacket(Server.clients[toClient].player.steamId.Value, packet2, TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
        }
    }

    private static void SendUDPData(int toClient, Packet packet)
    {
        Packet packet2 = new Packet();
        packet2.SetBytes(packet.CloneBytes());
        packet2.WriteLength();
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            Server.clients[toClient].udp.SendData(packet2);
        }
        else
        {
            SteamPacketManager.SendPacket(Server.clients[toClient].player.steamId.Value, packet2, UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
        }
    }

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
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null)
            {
                SteamPacketManager.SendPacket(value.player.steamId.Value, packet, TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
            }
        }
    }

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
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null && SteamLobby.steamIdToClientId[value.player.steamId.Value] != exceptClient)
            {
                SteamPacketManager.SendPacket(value.player.steamId.Value, packet, TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
            }
        }
    }

    public static void SendTCPDataToSteamId(SteamId steamId, Packet packet)
    {
        Packet packet2 = new Packet();
        packet2.SetBytes(packet.CloneBytes());
        packet2.WriteLength();
        SteamPacketManager.SendPacket(steamId, packet2, TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
    }

    private static void SendTCPDataToAll(int[] exceptClients, Packet packet)
    {
        packet.WriteLength();
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            for (int i = 1; i < Server.MaxPlayers; i++)
            {
                bool flag = false;
                int[] array = exceptClients;
                foreach (int num in array)
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
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player == null)
            {
                continue;
            }
            bool flag2 = false;
            int[] array = exceptClients;
            foreach (int num2 in array)
            {
                if (SteamLobby.steamIdToClientId[value.player.steamId.Value] == num2)
                {
                    flag2 = true;
                }
            }
            if (!flag2)
            {
                SteamPacketManager.SendPacket(value.player.steamId.Value, packet, TCPvariant, SteamPacketManager.NetworkChannel.ToClient);
            }
        }
    }

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
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null)
            {
                SteamPacketManager.SendPacket(value.player.steamId.Value, packet, UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
            }
        }
    }

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
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null && SteamLobby.steamIdToClientId[value.player.steamId.Value] != exceptClient)
            {
                SteamPacketManager.SendPacket(value.player.steamId.Value, packet, UDPVariant, SteamPacketManager.NetworkChannel.ToClient);
            }
        }
    }

    public static void Welcome(int toClient, string msg)
    {
        using (Packet packet = new Packet(1))
        {
            packet.Write(msg);
            packet.Write(NetworkManager.Clock);
            packet.Write(toClient);
            SendTCPData(toClient, packet);
        }
    }

    public static void StartGame(int playerLobbyId, GameSettings settings)
    {
        using (Packet packet = new Packet(13))
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
            foreach (Player item in list)
            {
                packet.Write(item.id);
                packet.Write(item.username);
            }
            Debug.Log("Sending start game packet");
            SendTCPData(playerLobbyId, packet);
        }
    }

    public static void ConnectionSuccessful(int toClient)
    {
        using (Packet packet = new Packet(9))
        {
            SendTCPData(toClient, packet);
        }
    }

    public static void PlayerDied(int deadPlayerId, Vector3 deathPos, Vector3 gravePos, int damageFromPlayer)
    {
        using (Packet packet = new Packet(7))
        {
            Debug.Log("Player" + deadPlayerId + " has been killed, sending to players");
            packet.Write(deadPlayerId);
            packet.Write(gravePos);
            packet.Write(damageFromPlayer);
            SendTCPDataToAll(deadPlayerId, packet);
        }
        if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus && !GameManager.instance.boatLeft)
        {
            using (Packet packet2 = new Packet(53))
            {
                int nextId = ResourceManager.Instance.GetNextId();
                packet2.Write(deadPlayerId);
                packet2.Write(nextId);
                packet2.Write(gravePos);
                SendTCPDataToAll(packet2);
            }
        }
    }

    public static void RespawnPlayer(int respawnId)
    {
        using (Packet packet = new Packet(44))
        {
            packet.Write(respawnId);
            SendTCPDataToAll(packet);
        }
    }

    public static void RevivePlayer(int fromClient, int revivedId, bool shrine, int objectID)
    {
        using (Packet packet = new Packet(52))
        {
            packet.Write(fromClient);
            packet.Write(revivedId);
            packet.Write(shrine);
            packet.Write(objectID);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void PlayerReady(int fromClient, bool ready)
    {
        using (Packet packet = new Packet(16))
        {
            packet.Write(fromClient);
            packet.Write(ready);
            SendTCPDataToAll(packet);
        }
    }

    public static void PlayerReady(int fromClient, bool ready, int toClient)
    {
        using (Packet packet = new Packet(16))
        {
            packet.Write(fromClient);
            packet.Write(ready);
            SendTCPData(toClient, packet);
        }
    }

    public static void DropItem(int fromClient, int itemId, int amount, int objectID)
    {
        using (Packet packet = new Packet(18))
        {
            packet.Write(fromClient);
            packet.Write(itemId);
            packet.Write(amount);
            packet.Write(objectID);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void DropItemAtPosition(int itemId, int amount, int objectID, Vector3 pos)
    {
        using (Packet packet = new Packet(28))
        {
            packet.Write(itemId);
            packet.Write(amount);
            packet.Write(objectID);
            packet.Write(pos);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void DropPowerupAtPosition(int itemId, int objectID, Vector3 pos)
    {
        using (Packet packet = new Packet(36))
        {
            packet.Write(itemId);
            packet.Write(objectID);
            packet.Write(pos);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void DropResources(int fromClient, int dropTableId, int droppedItemID)
    {
        using (Packet packet = new Packet(22))
        {
            packet.Write(fromClient);
            packet.Write(dropTableId);
            packet.Write(droppedItemID);
            SendTCPDataToAll(packet);
        }
    }

    public static void PickupItem(int fromClient, int objectID)
    {
        using (Packet packet = new Packet(19))
        {
            packet.Write(fromClient);
            packet.Write(objectID);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void PickupInteract(int fromClient, int objectID)
    {
        using (Packet packet = new Packet(27))
        {
            packet.Write(fromClient);
            packet.Write(objectID);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void WeaponInHand(int fromClient, int objectID)
    {
        using (Packet packet = new Packet(20))
        {
            packet.Write(fromClient);
            packet.Write(objectID);
            SendTCPDataToAll(fromClient, packet);
        }
    }

    public static void SendBuild(int fromClient, int itemId, int newObjectId, Vector3 pos, int yRot)
    {
        using (Packet packet = new Packet(24))
        {
            packet.Write(fromClient);
            packet.Write(itemId);
            packet.Write(newObjectId);
            packet.Write(pos);
            packet.Write(yRot);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void AnimationUpdate(int fromClient, int animation, bool b)
    {
        using (Packet packet = new Packet(23))
        {
            packet.Write(fromClient);
            packet.Write(animation);
            packet.Write(b);
            SendUDPDataToAll(fromClient, packet);
        }
    }

    public static void ShootArrow(Vector3 pos, Vector3 rot, float force, int arrowId, int playerId)
    {
        using (Packet packet = new Packet(45))
        {
            packet.Write(pos);
            packet.Write(rot);
            packet.Write(force);
            packet.Write(arrowId);
            packet.Write(playerId);
            SendTCPDataToAll(playerId, packet);
        }
    }

    public static void OpenChest(int fromClient, int chestId, bool use)
    {
        using (Packet packet = new Packet(25))
        {
            packet.Write(fromClient);
            packet.Write(chestId);
            packet.Write(use);
            SendTCPDataToAll(packet);
        }
    }

    public static void UpdateChest(int fromClient, int chestId, int cellId, int itemId, int amount)
    {
        using (Packet packet = new Packet(26))
        {
            packet.Write(fromClient);
            packet.Write(chestId);
            packet.Write(cellId);
            packet.Write(itemId);
            packet.Write(amount);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void PlayerHitObject(int fromClient, int objectID, int hp, int hitEffect, Vector3 pos, int weaponHitType)
    {
        using (Packet packet = new Packet(21))
        {
            packet.Write(fromClient);
            packet.Write(objectID);
            packet.Write(hp);
            packet.Write(hitEffect);
            packet.Write(pos);
            packet.Write(weaponHitType);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void SpawnEffect(int effectId, Vector3 pos, int fromClient)
    {
        using (Packet packet = new Packet(50))
        {
            packet.Write(effectId);
            packet.Write(pos);
            SendUDPDataToAll(fromClient, packet);
        }
    }

    public static void HitPlayer(int fromClient, int damage, float hpRatioEstimate, int hurtPlayerId, int hitEffect, Vector3 pos)
    {
        using (Packet packet = new Packet(29))
        {
            packet.Write(fromClient);
            packet.Write(damage);
            packet.Write(hpRatioEstimate);
            packet.Write(hurtPlayerId);
            packet.Write(hitEffect);
            packet.Write(pos);
            SendTCPDataToAll(packet);
        }
    }

    public static void SpawnPlayer(int toClient, Player player, Vector3 pos)
    {
        using (Packet packet = new Packet(2))
        {
            Debug.Log("spawning player, id: " + player.id + ", sending to " + toClient);
            packet.Write(player.id);
            packet.Write(player.username);
            Vector3 value = new Vector3(player.color.r, player.color.g, player.color.b);
            packet.Write(value);
            player.pos = pos;
            packet.Write(pos);
            packet.Write(player.yOrientation);
            SendTCPData(toClient, packet);
        }
    }

    public static void PlayerHp(int fromId, float hpRatio)
    {
        using (Packet packet = new Packet(43))
        {
            packet.Write(fromId);
            packet.Write(hpRatio);
            SendUDPDataToAll(fromId, packet);
        }
    }

    public static void PlayerPosition(Player player, int t)
    {
        using (Packet packet = new Packet(3))
        {
            packet.Write(player.id);
            packet.Write(player.pos);
            SendUDPDataToAll(player.id, packet);
        }
    }

    public static void PlayerRotation(Player player)
    {
        using (Packet packet = new Packet(4))
        {
            packet.Write(player.id);
            packet.Write(player.yOrientation);
            packet.Write(player.xOrientation);
            SendUDPDataToAll(player.id, packet);
        }
    }

    public static void PingPlayer(int player, string ms)
    {
        using (Packet packet = new Packet(8))
        {
            packet.Write(player);
            packet.Write(ms);
            SendUDPData(player, packet);
        }
    }

    public static void DisconnectPlayer(int player)
    {
        using (Packet packet = new Packet(5))
        {
            packet.Write(player);
            SendTCPDataToAll(packet);
        }
    }

    public static void ShrineStart(int[] mobIds, int shrineId)
    {
        using (Packet packet = new Packet(35))
        {
            packet.Write(shrineId);
            int num = mobIds.Length;
            packet.Write(num);
            for (int i = 0; i < num; i++)
            {
                packet.Write(mobIds[i]);
            }
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobMove(int mobId, Vector3 pos)
    {
        using (Packet packet = new Packet(31))
        {
            packet.Write(mobId);
            packet.Write(pos);
            SendUDPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobSetDestination(int mobId, Vector3 dest)
    {
        using (Packet packet = new Packet(32))
        {
            packet.Write(mobId);
            packet.Write(dest);
            SendUDPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void SendMobTarget(int mobId, int targetId)
    {
        using (Packet packet = new Packet(55))
        {
            packet.Write(mobId);
            packet.Write(targetId);
            SendUDPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobSpawn(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier, int guardianType)
    {
        using (Packet packet = new Packet(30))
        {
            packet.Write(pos);
            packet.Write(mobType);
            packet.Write(mobId);
            packet.Write(multiplier);
            packet.Write(bossMultiplier);
            packet.Write(guardianType);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobAttack(int mobId, int targetPlayerId, int attackAnimationIndex)
    {
        using (Packet packet = new Packet(33))
        {
            packet.Write(mobId);
            packet.Write(targetPlayerId);
            packet.Write(attackAnimationIndex);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobSpawnProjectile(Vector3 pos, Vector3 dir, float force, int itemId, int mobObjectId)
    {
        using (Packet packet = new Packet(47))
        {
            packet.Write(pos);
            packet.Write(dir);
            packet.Write(force);
            packet.Write(itemId);
            packet.Write(mobObjectId);
            SendUDPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void PlayerHitMob(int fromClient, int mobId, int hpLeft, int hitEffect, Vector3 pos, int hitWeaponType)
    {
        using (Packet packet = new Packet(34))
        {
            packet.Write(fromClient);
            packet.Write(mobId);
            packet.Write(hpLeft);
            packet.Write(hitEffect);
            packet.Write(pos);
            packet.Write(hitWeaponType);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void KnockbackMob(int mobId, Vector3 dir)
    {
        using (Packet packet = new Packet(49))
        {
            packet.Write(mobId);
            packet.Write(dir);
            SendTCPDataToAll(packet);
        }
    }

    public static void Interact(int interactId, int fromId)
    {
        using (Packet packet = new Packet(54))
        {
            packet.Write(interactId);
            packet.Write(fromId);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobZoneSpawn(Vector3 pos, int mobType, int mobId, int mobZoneId)
    {
        using (Packet packet = new Packet(37))
        {
            packet.Write(pos);
            packet.Write(mobType);
            packet.Write(mobId);
            packet.Write(mobZoneId);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void PickupZoneSpawn(Vector3 pos, int entityId, int mobId, int mobZoneId)
    {
        using (Packet packet = new Packet(39))
        {
            packet.Write(pos);
            packet.Write(entityId);
            packet.Write(mobId);
            packet.Write(mobZoneId);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void MobZoneToggle(bool show, int objectID)
    {
        using (Packet packet = new Packet(38))
        {
            packet.Write(show);
            packet.Write(objectID);
            SendTCPDataToAll(packet);
        }
    }

    public static void SendChatMessage(int fromClient, string username, string msg)
    {
        using (Packet packet = new Packet(40))
        {
            packet.Write(fromClient);
            packet.Write(username);
            packet.Write(msg);
            SendUDPDataToAll(fromClient, packet);
        }
    }

    public static void SendPing(int fromClient, Vector3 pos, string username)
    {
        using (Packet packet = new Packet(41))
        {
            packet.Write(pos);
            packet.Write(username);
            SendUDPDataToAll(fromClient, packet);
        }
    }

    public static void SendArmor(int fromClient, int armorSlot, int itemId)
    {
        using (Packet packet = new Packet(42))
        {
            packet.Write(fromClient);
            packet.Write(armorSlot);
            packet.Write(itemId);
            SendTCPDataToAll(fromClient, packet);
        }
    }

    public static void NewDay(int day)
    {
        using (Packet packet = new Packet(48))
        {
            packet.Write(day);
            foreach (Client value in Server.clients.Values)
            {
                if (value != null && value.player != null)
                {
                    value.player.stats["Day"] = day;
                }
            }
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void GameOver(int winnerId = -2)
    {
        using (Packet packet = new Packet(12))
        {
            packet.Write(winnerId);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
        SendStats();
    }

    public static void PlayerFinishedLoading(int playerId)
    {
        using (Packet packet = new Packet(51))
        {
            packet.Write(playerId);
            SendTCPDataToAll(packet);
        }
    }

    public static void SendShipUpdate(int fromClient, int type, int interactId)
    {
        using (Packet packet = new Packet(56))
        {
            Debug.LogError("server sending ship update");
            packet.Write(type);
            packet.Write(interactId);
            SendTCPDataToAll(fromClient, packet);
        }
    }

    public static void DragonUpdate(int dragonUpdateType)
    {
        using (Packet packet = new Packet(57))
        {
            packet.Write(dragonUpdateType);
            SendTCPDataToAll(LocalClient.instance.myId, packet);
        }
    }

    public static void SendStats()
    {
        using (Packet packet = new Packet(58))
        {
            int num = 0;
            foreach (Client value in Server.clients.Values)
            {
                if (value != null && value.player != null)
                {
                    num++;
                }
            }
            packet.Write(num);
            foreach (Client value2 in Server.clients.Values)
            {
                if (value2 != null && value2.player != null)
                {
                    packet.Write(value2.player.id);
                    string[] allStats = Player.allStats;
                    foreach (string key in allStats)
                    {
                        packet.Write(value2.player.stats[key]);
                    }
                }
            }
            SendTCPDataToAll(packet);
        }
    }
}
