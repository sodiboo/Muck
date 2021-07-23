using System.Collections.Generic;
using UnityEngine;

public class ServerHandle
{
    public static void WelcomeReceived(int fromClient, Packet packet)
    {
        int num = packet.ReadInt();
        string playerName = packet.ReadString();
        Color color = new Color(packet.ReadFloat(), packet.ReadFloat(), packet.ReadFloat());
        if (fromClient != num)
        {
            Debug.Log("Something went very wrong in ServerHandle");
        }
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            Debug.Log($"{Server.clients[fromClient].tcp.socket.Client.RemoteEndPoint} connected successfully and is now player {fromClient}.");
            Server.clients[fromClient].StartClient(playerName, color);
        }
        ServerSend.ConnectionSuccessful(fromClient);
        Server.clients[fromClient].SendIntoGame();
    }

    public static void JoinRequest(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player.joined)
        {
            Debug.LogError("Player already joined: " + fromClient);
            return;
        }
        Debug.LogError("Player wants to join, id: " + fromClient);
        Server.clients[fromClient].player.joined = true;
        Server.clients[fromClient].player.username = packet.ReadString();
        ServerSend.Welcome(fromClient, "weclome");
    }

    public static void StartedLoading(int fromClient, Packet packet)
    {
        if (!Server.clients[fromClient].player.loading)
        {
            Server.clients[fromClient].player.loading = true;
        }
    }

    public static void PlayerFinishedLoading(int fromClient, Packet packet)
    {
        Debug.Log("Player finished loading: " + fromClient);
        Server.clients[fromClient].player.ready = true;
        ServerSend.PlayerFinishedLoading(fromClient);
        int num = 0;
        int num2 = 0;
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null)
            {
                num2++;
                if (value.player.ready)
                {
                    num++;
                }
            }
        }
        if (num >= num2)
        {
            Debug.Log("ready players: " + num + " / " + num2);
            List<Vector3> spawnPositions = ((GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus) ? GameManager.instance.FindVersusSpawnPositions(num2) : GameManager.instance.FindSurvivalSpawnPositions(num2));
            if (num >= num2)
            {
                GameManager.instance.SendPlayersIntoGame(spawnPositions);
            }
        }
    }

    public static void PlayerDisconnect(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            DisconnectPlayer(fromClient);
        }
    }

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

    public static void KickPlayer(int client)
    {
        ServerSend.DisconnectPlayer(client);
        try
        {
            string msg = Server.clients[client].player.username + " kicked";
            ServerSend.SendChatMessage(-1, "Server", msg);
        }
        catch
        {
            Debug.LogError("Failed to send disconnect message to clients");
        }
        Server.clients[client] = null;
    }

    public static void SpawnPlayersRequest(int fromClient, Packet packet)
    {
        Debug.Log("received request to spawn players");
        if (Server.clients[fromClient].player != null)
        {
            Server.clients[fromClient].SendIntoGame();
        }
    }

    public static void PlayerHp(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int num = packet.ReadInt();
            int num2 = packet.ReadInt();
            Server.clients[fromClient].player.currentHp = num;
            float hpRatio = (float)num / (float)num2;
            ServerSend.PlayerHp(fromClient, hpRatio);
        }
    }

    public static void PlayerDied(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null && !Server.clients[fromClient].player.dead)
        {
            int damageFromPlayer = packet.ReadInt();
            Server.clients[fromClient].player.Died();
            GameManager.players[fromClient].dead = true;
            Vector3 gravePosition = GameManager.instance.GetGravePosition(fromClient);
            ServerSend.SendChatMessage(-1, "", "<color=orange>" + Server.clients[fromClient].player.username + " has died.");
            ServerSend.PlayerDied(fromClient, Server.clients[fromClient].player.pos, gravePosition, damageFromPlayer);
            Server.clients[fromClient].player.stats["Deaths"]++;
            if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
            {
                GameManager.instance.CheckIfGameOver();
            }
        }
    }

    public static void RevivePlayer(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        bool flag = packet.ReadBool();
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
        int num2 = packet.ReadInt();
        if (ResourceManager.Instance.list.ContainsKey(num2))
        {
            ResourceManager.Instance.list[num2].GetComponentInChildren<Interactable>().AllExecute();
        }
        ServerSend.SendChatMessage(-1, "", "<color=orange>" + Server.clients[fromClient].player.username + " has revived " + Server.clients[num].player.username + ".");
        ServerSend.RevivePlayer(fromClient, num, flag, num2);
        if (fromClient == LocalClient.instance.myId)
        {
            AchievementManager.Instance.ReviveTeammate();
        }
        Server.clients[fromClient].player.stats["Revives"]++;
    }

    public static void PlayerPosition(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            Vector3 pos = packet.ReadVector3();
            Server.clients[fromClient].player.pos = pos;
            ServerSend.PlayerPosition(Server.clients[fromClient].player, 0);
        }
    }

    public static void PlayerRotation(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            float yOrientation = packet.ReadFloat();
            float xOrientation = packet.ReadFloat();
            Server.clients[fromClient].player.yOrientation = yOrientation;
            Server.clients[fromClient].player.xOrientation = xOrientation;
            ServerSend.PlayerRotation(Server.clients[fromClient].player);
        }
    }

    public static void ItemDropped(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int itemId = packet.ReadInt();
            int amount = packet.ReadInt();
            int nextId = ItemManager.Instance.GetNextId();
            ItemManager.Instance.DropItem(fromClient, itemId, amount, nextId);
            ServerSend.DropItem(fromClient, itemId, amount, nextId);
        }
    }

    public static void ItemDroppedAtPosition(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int num = packet.ReadInt();
            int amount = packet.ReadInt();
            Vector3 pos = packet.ReadVector3();
            int nextId = ItemManager.Instance.GetNextId();
            ItemManager.Instance.DropItemAtPosition(num, amount, pos, num);
            ServerSend.DropItemAtPosition(num, amount, nextId, pos);
        }
    }

    public static void ItemPickedUp(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        Debug.Log("object: " + num + " picked up by player: " + fromClient);
        Item component = ItemManager.Instance.list[num].GetComponent<Item>();
        if ((bool)component.powerup)
        {
            Server.clients[fromClient].player.powerups[component.powerup.id]++;
        }
        if (!ItemManager.Instance.list.ContainsKey(num))
        {
            return;
        }
        if (fromClient == LocalClient.instance.myId)
        {
            if ((bool)component.item)
            {
                InventoryUI.Instance.AddItemToInventory(component.item);
            }
            else if ((bool)component.powerup)
            {
                Server.clients[fromClient].player.powerups[component.powerup.id]++;
                PowerupInventory.Instance.AddPowerup(component.powerup.name, component.powerup.id, num);
            }
        }
        if ((bool)component.powerup)
        {
            GameManager.instance.powerupsPickedup = true;
            Server.clients[fromClient].player.stats["Powerups"]++;
        }
        ItemManager.Instance.PickupItem(num);
        ServerSend.PickupItem(fromClient, num);
    }

    public static void ItemInteract(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
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
            if (componentInChildren.GetType() == typeof(LootContainerInteract))
            {
                Server.clients[fromClient].player.stats["Chests"]++;
            }
        }
    }

    public static void WeaponInHand(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int objectID = packet.ReadInt();
            ServerSend.WeaponInHand(fromClient, objectID);
        }
    }

    public static void AnimationUpdate(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null && Server.clients[fromClient].player != null)
        {
            int animation = packet.ReadInt();
            bool b = packet.ReadBool();
            ServerSend.AnimationUpdate(fromClient, animation, b);
        }
    }

    public static void ShootArrow(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null && Server.clients[fromClient].player != null)
        {
            Vector3 pos = packet.ReadVector3();
            Vector3 rot = packet.ReadVector3();
            float force = packet.ReadFloat();
            int arrowId = packet.ReadInt();
            ServerSend.ShootArrow(pos, rot, force, arrowId, fromClient);
        }
    }

    public static void RequestChest(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        bool flag = packet.ReadBool();
        if (!ChestManager.Instance.chests.ContainsKey(num))
        {
            return;
        }
        if (flag)
        {
            if (!ChestManager.Instance.IsChestOpen(num))
            {
                ChestManager.Instance.UseChest(num, inUse: true);
                ServerSend.OpenChest(fromClient, num, use: true);
                ChestManager.Instance.chests[num].GetComponent<ChestInteract>().ServerExecute(fromClient);
            }
        }
        else
        {
            ChestManager.Instance.UseChest(num, inUse: false);
            ServerSend.OpenChest(fromClient, num, use: false);
        }
    }

    public static void UpdateChest(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int chestId = packet.ReadInt();
            int cellId = packet.ReadInt();
            int itemId = packet.ReadInt();
            int amount = packet.ReadInt();
            Debug.Log("received chest update");
            Debug.Log("now sending to other players");
            ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
            ServerSend.UpdateChest(fromClient, chestId, cellId, itemId, amount);
        }
    }

    public static void RequestBuild(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int num = packet.ReadInt();
            Vector3 vector = packet.ReadVector3();
            int num2 = packet.ReadInt();
            int num3 = ((ItemManager.Instance.allItems[num].type != InventoryItem.ItemType.Storage) ? BuildManager.Instance.GetNextBuildId() : ResourceManager.Instance.GetNextId());
            BuildManager.Instance.BuildItem(fromClient, num, num3, vector, num2);
            ServerSend.SendBuild(fromClient, num, num3, vector, num2);
        }
    }

    public static void PlayerHitObject(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        int hitEffect = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        int num3 = packet.ReadInt();
        if (!ResourceManager.Instance.list.ContainsKey(num2))
        {
            return;
        }
        Hitable component = ResourceManager.Instance.list[num2].GetComponent<Hitable>();
        if (component.hp > 0)
        {
            int num4 = component.hp - num;
            component.hp = component.Damage(num4, fromClient, hitEffect, pos);
            Debug.Log("object hit from: " + fromClient);
            if (num4 <= 0)
            {
                num4 = 0;
                Debug.Log("dropping item");
                LootExtra.CheckDrop(fromClient, (HitableResource)component);
            }
            ServerSend.PlayerHitObject(fromClient, num2, num4, hitEffect, pos, num3);
            PlayerStatus.WeaponHitType weaponHitType = (PlayerStatus.WeaponHitType)num3;
            if (weaponHitType != PlayerStatus.WeaponHitType.Rock && weaponHitType != PlayerStatus.WeaponHitType.Undefined)
            {
                GameManager.instance.onlyRock = false;
            }
        }
    }

    public static void SpawnEffect(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int effectId = packet.ReadInt();
            Vector3 pos = packet.ReadVector3();
            ServerSend.SpawnEffect(effectId, pos, fromClient);
        }
    }

    public static void PlayerHit(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        float sharpness = packet.ReadFloat();
        int hitEffect = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        if ((bool)GameManager.players[num2])
        {
            if (fromClient == num2)
            {
                num = (int)((float)num * GameManager.instance.MobDamageMultiplier());
            }
            else if (GameManager.gameSettings.friendlyFire == GameSettings.FriendlyFire.Off && GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
            {
                return;
            }
            float hardness = 0.5f;
            float defenseMultiplier = PowerupInventory.Instance.GetDefenseMultiplier(Server.clients[num2].player.powerups);
            defenseMultiplier += (float)Server.clients[num2].player.totalArmor;
            int num3 = GameManager.instance.CalculateDamage(num, defenseMultiplier, sharpness, hardness);
            Debug.Log($"Player{num2} took {num3} damage from {fromClient} and had armor {defenseMultiplier}");
            Player player = Server.clients[num2].player;
            int num4 = player.Damage(num3);
            float num5 = (float)num4 / (float)PowerupInventory.Instance.GetMaxHpAndShield(player.powerups);
            if (num5 < 0f)
            {
                num5 = 0f;
            }
            Debug.Log("estimated hp left: " + num4 + ", ratio: " + num5 + ", maxhp: " + PowerupInventory.Instance.GetMaxHpAndShield(player.powerups));
            if (num2 == fromClient)
            {
                Debug.Log("Player took damage from mob btw lol");
            }
            ServerSend.HitPlayer(fromClient, num3, num5, num2, hitEffect, pos);
            Server.clients[fromClient].player.stats["DamageTaken"] += num3;
        }
    }

    public static void PlayerRequestedSpawns(int fromClient, Packet packet)
    {
        Debug.LogError("Player requested spawns, but method is not implemented");
    }

    public static void Ready(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            Debug.Log("Recevied ready from player: " + fromClient);
            bool ready = packet.ReadBool();
            ServerSend.PlayerReady(fromClient, ready);
            Server.clients[fromClient].player.ready = ready;
        }
    }

    public static void PingReceived(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            string ms = packet.ReadString();
            Server.clients[fromClient].player.PingPlayer();
            ServerSend.PingPlayer(fromClient, ms);
        }
    }

    public static void ShrineCombatStartRequest(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int key = packet.ReadInt();
        if (!ResourceManager.Instance.list.ContainsKey(key))
        {
            return;
        }
        Interactable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>();
        if (!componentInChildren.IsStarted())
        {
            if (fromClient == LocalClient.instance.myId)
            {
                componentInChildren.LocalExecute();
            }
            componentInChildren.ServerExecute(fromClient);
        }
    }

    public static void Interact(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        if (!ResourceManager.Instance.list.ContainsKey(num))
        {
            return;
        }
        Interactable componentInChildren = ResourceManager.Instance.list[num].GetComponentInChildren<Interactable>();
        if (!componentInChildren.IsStarted())
        {
            if (fromClient == LocalClient.instance.myId)
            {
                componentInChildren.LocalExecute();
            }
            componentInChildren.ServerExecute(fromClient);
            componentInChildren.AllExecute();
            ServerSend.Interact(num, fromClient);
        }
    }

    public static void PlayerDamageMob(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player == null)
        {
            return;
        }
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        float sharpness = packet.ReadFloat();
        int num3 = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        int num4 = packet.ReadInt();
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
        int num5 = GameManager.instance.CalculateDamage(num2, defense, sharpness, sharpDefense);
        Debug.Log($"Mob took {num5} damage from {fromClient}.");
        int num6 = component.hp - num5;
        if (num6 > component.maxHp)
        {
            num6 = component.maxHp;
        }
        if (num6 <= 0)
        {
            num6 = 0;
            LootDrop dropTable = component.dropTable;
            float buffMultiplier = 1f;
            Mob component2 = component.GetComponent<Mob>();
            if ((bool)component2 && component2.IsBuff())
            {
                buffMultiplier = 1.25f;
            }
            LootExtra.DropMobLoot(component.transform, dropTable, fromClient, buffMultiplier);
            if (component2.bossType != 0)
            {
                LootExtra.BossLoot(component.transform, mob.bossType);
            }
            Server.clients[fromClient].player.stats["Kills"]++;
        }
        component.hp = component.Damage(num6, fromClient, num3, pos);
        float knockbackMultiplier = PowerupInventory.Instance.GetKnockbackMultiplier(Server.clients[fromClient].player.powerups);
        if (((float)num5 / (float)mob.hitable.maxHp > mob.mobType.knockbackThreshold || knockbackMultiplier > 0f) && num6 > 0)
        {
            Vector3 v = component.transform.position - GameManager.players[fromClient].transform.position;
            v = VectorExtensions.XZVector(v).normalized;
            ServerSend.KnockbackMob(num, v);
            if (num3 == 0)
            {
                num3 = 4;
            }
        }
        if (num6 <= 0 && LocalClient.instance.myId == fromClient)
        {
            PlayerStatus.Instance.AddKill(num4, mob);
        }
        ServerSend.PlayerHitMob(fromClient, num, num6, num3, pos, num4);
        PlayerStatus.WeaponHitType weaponHitType = (PlayerStatus.WeaponHitType)num4;
        if (weaponHitType != PlayerStatus.WeaponHitType.Rock && weaponHitType != PlayerStatus.WeaponHitType.Undefined && num2 > 0)
        {
            GameManager.instance.onlyRock = false;
        }
        Server.clients[fromClient].player.stats["DamageDone"] += num5;
    }

    public static void ReceiveChatMessage(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            string msg = packet.ReadString();
            string username = GameManager.players[fromClient].username;
            ServerSend.SendChatMessage(fromClient, username, msg);
        }
    }

    public static void ReceivePing(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            Vector3 pos = packet.ReadVector3();
            string username = GameManager.players[fromClient].username;
            ServerSend.SendPing(fromClient, pos, username);
        }
    }

    public static void ReceiveArmor(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int armorSlot = packet.ReadInt();
            int itemId = packet.ReadInt();
            Server.clients[fromClient].player.UpdateArmor(armorSlot, itemId);
            ServerSend.SendArmor(fromClient, armorSlot, itemId);
        }
    }

    public static void ReceiveShipUpdate(int fromClient, Packet packet)
    {
        if (Server.clients[fromClient].player != null)
        {
            int type = packet.ReadInt();
            int interactId = packet.ReadInt();
            ServerSend.SendShipUpdate(fromClient, type, interactId);
        }
    }
}
