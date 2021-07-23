using System;
using System.Net;
using UnityEngine;

public class ClientHandle : MonoBehaviour
{
    public static void Welcome(Packet packet)
    {
        string text = packet.ReadString();
        packet.ReadFloat();
        int num = packet.ReadInt();
        Debug.Log("Message from server: " + text);
        UiManager.instance.ConnectionSuccessful();
        LocalClient.instance.myId = num;
        ClientSend.WelcomeReceived(num, LocalClient.instance.name);
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            LocalClient.instance.udp.Connect(((IPEndPoint)LocalClient.instance.tcp.socket.Client.LocalEndPoint).Port);
        }
    }

    public static void Clock(Packet packet)
    {
        int num = packet.ReadInt();
        LoadingScreen.Instance.players[num] = true;
    }

    public static void PlayerFinishedLoading(Packet packet)
    {
        LoadingScreen.Instance.UpdateStatuses(packet.ReadInt());
    }

    public static void DropItem(Packet packet)
    {
        int fromClient = packet.ReadInt();
        int itemId = packet.ReadInt();
        int amount = packet.ReadInt();
        int objectID = packet.ReadInt();
        ItemManager.Instance.DropItem(fromClient, itemId, amount, objectID);
    }

    public static void DropItemAtPosition(Packet packet)
    {
        int itemId = packet.ReadInt();
        int amount = packet.ReadInt();
        int objectID = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        ItemManager.Instance.DropItemAtPosition(itemId, amount, pos, objectID);
    }

    public static void DropPowerupAtPosition(Packet packet)
    {
        int powerupId = packet.ReadInt();
        int objectID = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        ItemManager.Instance.DropPowerupAtPosition(powerupId, pos, objectID);
    }

    public static void DropResources(Packet packet)
    {
        int fromClient = packet.ReadInt();
        int dropTableId = packet.ReadInt();
        int num = packet.ReadInt();
        MonoBehaviour.print("CLIENT: Dropping resources with id: " + num);
        ItemManager.Instance.DropResource(fromClient, dropTableId, num);
    }

    public static void PickupItem(Packet packet)
    {
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        Item component = ItemManager.Instance.list[num2].GetComponent<Item>();
        if (!component)
        {
            return;
        }
        if ((bool)component.powerup)
        {
            GameManager.instance.powerupsPickedup = true;
        }
        if (LocalClient.instance.myId == num && !LocalClient.serverOwner)
        {
            if ((bool)component.item)
            {
                InventoryUI.Instance.AddItemToInventory(component.item);
            }
            else if ((bool)component.powerup)
            {
                PowerupInventory.Instance.AddPowerup(component.powerup.name, component.powerup.id, num2);
            }
        }
        if (!LocalClient.serverOwner)
        {
            ItemManager.Instance.PickupItem(num2);
        }
    }

    public static void SpawnEffect(Packet packet)
    {
        int id = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        PowerupCalculations.Instance.SpawnOnHitEffect(id, owner: false, pos, 0);
    }

    public static void WeaponInHand(Packet packet)
    {
        int key = packet.ReadInt();
        int objectID = packet.ReadInt();
        GameManager.players[key].onlinePlayer.UpdateWeapon(objectID);
    }

    public static void AnimationUpdate(Packet packet)
    {
        int key = packet.ReadInt();
        int animation = packet.ReadInt();
        bool b = packet.ReadBool();
        GameManager.players[key].onlinePlayer.NewAnimation(animation, b);
    }

    public static void ShootArrowFromPlayer(Packet packet)
    {
        Vector3 spawnPos = packet.ReadVector3();
        Vector3 direction = packet.ReadVector3();
        float force = packet.ReadFloat();
        int arrowId = packet.ReadInt();
        int fromPlayer = packet.ReadInt();
        ProjectileController.Instance.SpawnProjectileFromPlayer(spawnPos, direction, force, arrowId, fromPlayer);
    }

    public static void PlayerHitObject(Packet packet)
    {
        int fromClient = packet.ReadInt();
        int key = packet.ReadInt();
        int newHp = packet.ReadInt();
        int hitEffect = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        PlayerStatus.WeaponHitType weaponHitType = (PlayerStatus.WeaponHitType)packet.ReadInt();
        if (weaponHitType != PlayerStatus.WeaponHitType.Rock && weaponHitType != PlayerStatus.WeaponHitType.Undefined)
        {
            GameManager.instance.onlyRock = false;
        }
        ResourceManager.Instance.list[key].GetComponent<Hitable>().Damage(newHp, fromClient, hitEffect, pos);
    }

    public static void RemoveResource(Packet packet)
    {
        int id = packet.ReadInt();
        ResourceManager.Instance.RemoveItem(id);
    }

    public static void PlayerHp(Packet packet)
    {
        int key = packet.ReadInt();
        float hpRatio = packet.ReadFloat();
        GameManager.players[key].SetHpRatio(hpRatio);
    }

    public static void RespawnPlayer(Packet packet)
    {
        int id = packet.ReadInt();
        Vector3 zero = packet.ReadVector3();
        GameManager.instance.RespawnPlayer(id, zero);
    }

    public static void PlayerHit(Packet packet)
    {
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        float num3 = packet.ReadFloat();
        int num4 = packet.ReadInt();
        int hitEffect = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        if (num2 > 0)
        {
            GameManager.instance.damageTaken = true;
        }
        MonoBehaviour.print("recevied player hit. Damage: " + num2 + ", ratio: " + num3 + "from: " + num + ", to: " + num4);
        PlayerManager playerManager = GameManager.players[num4];
        if (num4 == LocalClient.instance.myId)
        {
            PlayerStatus.Instance.DealDamage(num2, 1, ignoreProtection: true, num);
        }
        else
        {
            playerManager.SetHpRatio(num3);
        }
        playerManager.hitable.Damage(num2, num, hitEffect, pos);
    }

    public static void FinalizeBuild(Packet packet)
    {
        int buildOwner = packet.ReadInt();
        int itemID = packet.ReadInt();
        int objectId = packet.ReadInt();
        Vector3 position = packet.ReadVector3();
        int yRotation = packet.ReadInt();
        MonoBehaviour.print("Received build, now building");
        BuildManager.Instance.BuildItem(buildOwner, itemID, objectId, position, yRotation);
    }

    public static void OpenChest(Packet packet)
    {
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        bool flag = packet.ReadBool();
        MonoBehaviour.print($"player{num} now {flag} chest{num2}");
        ChestManager.Instance.UseChest(num2, flag);
        if (flag && num == LocalClient.instance.myId)
        {
            if (OtherInput.Instance.currentChest != null)
            {
                ClientSend.RequestChest(OtherInput.Instance.currentChest.id, use: false);
                OtherInput.Instance.currentChest = null;
            }
            OtherInput.Instance.currentChest = ChestManager.Instance.chests[num2];
            OtherInput.CraftingState state = ChestManager.Instance.chests[num2].GetComponentInChildren<ChestInteract>().state;
            OtherInput.Instance.ToggleInventory(state);
        }
    }

    public static void UpdateChest(Packet packet)
    {
        packet.ReadInt();
        int chestId = packet.ReadInt();
        int cellId = packet.ReadInt();
        int itemId = packet.ReadInt();
        int amount = packet.ReadInt();
        ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
    }

    public static void PickupInteract(Packet packet)
    {
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        Debug.Log("Received pickup with id: " + num2);
        Interactable componentInChildren = ResourceManager.Instance.list[num2].GetComponentInChildren<Interactable>();
        componentInChildren.AllExecute();
        if (LocalClient.instance.myId == num && !LocalClient.serverOwner)
        {
            componentInChildren.LocalExecute();
        }
        if (!LocalClient.serverOwner)
        {
            ResourceManager.Instance.RemoveInteractItem(num2);
        }
    }

    public static void SpawnPlayer(Packet packet)
    {
        int id = packet.ReadInt();
        string username = packet.ReadString();
        Vector3 vector = packet.ReadVector3();
        Vector3 position = packet.ReadVector3();
        float orientationY = packet.ReadFloat();
        GameManager.instance.SpawnPlayer(id, username, new Color(vector.x, vector.y, vector.z), position, orientationY);
        GameManager.instance.StartGame();
    }

    public static void StartGame(Packet packet)
    {
        if (!NetworkController.Instance.loading)
        {
            LocalClient.instance.myId = packet.ReadInt();
            int seed = packet.ReadInt();
            int gameMode = packet.ReadInt();
            int friendlyFire = packet.ReadInt();
            int difficulty = packet.ReadInt();
            int gameLength = packet.ReadInt();
            int multiplayer = packet.ReadInt();
            GameManager.gameSettings = new GameSettings(seed, gameMode, friendlyFire, difficulty, gameLength, multiplayer);
            MonoBehaviour.print("Game settings successfully loaded");
            MonoBehaviour.print("loading game scene, assigned id: " + LocalClient.instance.myId);
            int num = packet.ReadInt();
            NetworkController.Instance.nPlayers = num;
            string[] array = new string[num];
            for (int i = 0; i < num; i++)
            {
                packet.ReadInt();
                string text = (array[i] = packet.ReadString());
            }
            NetworkController.Instance.LoadGame(array);
            ClientSend.StartedLoading();
        }
    }

    public static void PlayerPosition(Packet packet)
    {
        int key = packet.ReadInt();
        Vector3 desiredPosition = packet.ReadVector3();
        if (GameManager.players.ContainsKey(key))
        {
            GameManager.players[key].SetDesiredPosition(desiredPosition);
        }
    }

    public static void PlayerRotation(Packet packet)
    {
        int key = packet.ReadInt();
        if (GameManager.players.ContainsKey(key))
        {
            float orientationY = packet.ReadFloat();
            float orientationX = packet.ReadFloat();
            GameManager.players[key].SetDesiredRotation(orientationY, orientationX);
        }
    }

    public static void ReceivePing(Packet packet)
    {
        packet.ReadInt();
        DateTime dateTime = DateTime.Parse(packet.ReadString());
        NetStatus.AddPing((int)(DateTime.Now - dateTime).TotalMilliseconds);
    }

    public static void ReceiveStatus(Packet packet)
    {
        MonoBehaviour.print("received status");
    }

    public static void ConnectionEstablished(Packet packet)
    {
        MonoBehaviour.print("connection has successfully been established. ready to enter game");
        GameManager.connected = true;
    }

    public static void OpenDoor(Packet packet)
    {
        packet.ReadInt();
    }

    public static void PlayerDied(Packet packet)
    {
        int num = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        int num2 = packet.ReadInt();
        GameManager.instance.KillPlayer(num, pos);
        if (LocalClient.instance.myId == num2 && LocalClient.instance.myId != num && GameManager.gameSettings.gameMode == GameSettings.GameMode.Survival)
        {
            AchievementManager.Instance.AddPlayerKill();
        }
    }

    public static void SpawnGrave(Packet packet)
    {
        int playerId = packet.ReadInt();
        int graveObjectId = packet.ReadInt();
        Vector3 gravePos = packet.ReadVector3();
        GameManager.instance.SpawnGrave(gravePos, playerId, graveObjectId);
    }

    public static void Ready(Packet packet)
    {
        packet.ReadInt();
        packet.ReadBool();
    }

    public static void KickPlayer(Packet packet)
    {
        SteamManager.Instance.leaveLobby();
        if ((bool)GameManager.instance)
        {
            GameManager.instance.LeaveGame();
        }
    }

    public static void DisconnectPlayer(Packet packet)
    {
        int num = packet.ReadInt();
        Debug.Log($"Player {num} has disconnected");
        if (num == LocalClient.instance.myId)
        {
            SteamManager.Instance.leaveLobby();
            if ((bool)GameManager.instance)
            {
                GameManager.instance.LeaveGame();
            }
        }
        else if ((bool)GameManager.instance)
        {
            GameManager.instance.DisconnectPlayer(num);
        }
    }

    public static void ShrineCombatStart(Packet packet)
    {
        int key = packet.ReadInt();
        int num = packet.ReadInt();
        ShrineInteractable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<ShrineInteractable>();
        if ((bool)componentInChildren)
        {
            MonoBehaviour.print("starting new shrine with mobs: " + num);
            int[] array = new int[num];
            for (int i = 0; i < num; i++)
            {
                array[i] = packet.ReadInt();
            }
            componentInChildren.StartShrine(array);
        }
    }

    public static void RevivePlayer(Packet packet)
    {
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        bool flag = packet.ReadBool();
        GameManager.instance.RespawnPlayer(num2, Vector3.zero);
        if (num == LocalClient.instance.myId && !flag)
        {
            InventoryUI.Instance.UseMoney(RespawnTotemUI.Instance.GetRevivePrice());
        }
        if (!flag && GameManager.players[num2] != null)
        {
            GameManager.players[num2].RemoveGrave();
        }
        RespawnTotemUI.Instance.Refresh();
        int key = packet.ReadInt();
        if (ResourceManager.Instance.list.ContainsKey(key))
        {
            ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>().AllExecute();
        }
        if (num == LocalClient.instance.myId)
        {
            AchievementManager.Instance.ReviveTeammate();
        }
    }

    public static void MobSpawn(Packet packet)
    {
        Vector3 pos = packet.ReadVector3();
        int mobType = packet.ReadInt();
        int mobId = packet.ReadInt();
        float multiplier = packet.ReadFloat();
        float bossMultiplier = packet.ReadFloat();
        int guardianType = packet.ReadInt();
        MobSpawner.Instance.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, Mob.BossType.None, guardianType);
    }

    public static void MobMove(Packet packet)
    {
        int key = packet.ReadInt();
        Vector3 position = packet.ReadVector3();
        if ((bool)MobManager.Instance.mobs[key])
        {
            MobManager.Instance.mobs[key].SetPosition(position);
        }
    }

    public static void MobSetDestination(Packet packet)
    {
        int key = packet.ReadInt();
        Vector3 destination = packet.ReadVector3();
        MobManager.Instance.mobs[key].SetDestination(destination);
    }

    public static void MobSetTarget(Packet packet)
    {
        int key = packet.ReadInt();
        int target = packet.ReadInt();
        MobManager.Instance.mobs[key].SetTarget(target);
    }

    public static void MobAttack(Packet packet)
    {
        int key = packet.ReadInt();
        int targetPlayerId = packet.ReadInt();
        int attackAnimationIndex = packet.ReadInt();
        MobManager.Instance.mobs[key].Attack(targetPlayerId, attackAnimationIndex);
    }

    public static void MobSpawnProjectile(Packet packet)
    {
        Vector3 spawnPos = packet.ReadVector3();
        Vector3 direction = packet.ReadVector3();
        float force = packet.ReadFloat();
        int itemId = packet.ReadInt();
        int mobObjectId = packet.ReadInt();
        ProjectileController.Instance.SpawnMobProjectile(spawnPos, direction, force, itemId, mobObjectId);
    }

    public static void PlayerDamageMob(Packet packet)
    {
        int num = packet.ReadInt();
        int key = packet.ReadInt();
        int num2 = packet.ReadInt();
        int hitEffect = packet.ReadInt();
        Vector3 pos = packet.ReadVector3();
        int num3 = packet.ReadInt();
        HitableMob component = MobManager.Instance.mobs[key].GetComponent<HitableMob>();
        if ((bool)component)
        {
            if (num2 <= 0 && LocalClient.instance.myId == num)
            {
                PlayerStatus.Instance.AddKill(num3, component.mob);
            }
            int num4 = MobManager.Instance.mobs[key].hitable.Damage(num2, num, hitEffect, pos);
            PlayerStatus.WeaponHitType weaponHitType = (PlayerStatus.WeaponHitType)num3;
            if (weaponHitType != PlayerStatus.WeaponHitType.Rock && weaponHitType != PlayerStatus.WeaponHitType.Undefined && num4 > 0)
            {
                GameManager.instance.onlyRock = false;
                Debug.LogError("hit: " + component.gameObject.name + ", type: " + num3 + ", type: " + weaponHitType);
            }
        }
    }

    public static void KnockbackMob(Packet packet)
    {
        int key = packet.ReadInt();
        Vector3 dir = packet.ReadVector3();
        if (MobManager.Instance.mobs.ContainsKey(key))
        {
            MobManager.Instance.mobs[key].Knockback(dir);
        }
    }

    public static void Interact(Packet packet)
    {
        int key = packet.ReadInt();
        int num = packet.ReadInt();
        if (!ResourceManager.Instance.list.ContainsKey(key))
        {
            return;
        }
        Interactable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>();
        if (!componentInChildren.IsStarted())
        {
            if (num == LocalClient.instance.myId)
            {
                componentInChildren.LocalExecute();
            }
            componentInChildren.AllExecute();
        }
    }

    public static void MobZoneToggle(Packet packet)
    {
        bool show = packet.ReadBool();
        int key = packet.ReadInt();
        MobZoneManager.Instance.zones[key].ToggleEntities(show);
    }

    public static void MobZoneSpawn(Packet packet)
    {
        Vector3 pos = packet.ReadVector3();
        int entityType = packet.ReadInt();
        int objectId = packet.ReadInt();
        int num = packet.ReadInt();
        MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
    }

    public static void PickupSpawnZone(Packet packet)
    {
        Vector3 pos = packet.ReadVector3();
        int entityType = packet.ReadInt();
        int objectId = packet.ReadInt();
        int num = packet.ReadInt();
        MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
    }

    public static void ReceiveChatMessage(Packet packet)
    {
        int fromUser = packet.ReadInt();
        string fromUsername = packet.ReadString();
        string message = packet.ReadString();
        ChatBox.Instance.AppendMessage(fromUser, message, fromUsername);
    }

    public static void ReceivePlayerPing(Packet packet)
    {
        Vector3 pos = packet.ReadVector3();
        string text = packet.ReadString();
        PingController.Instance.MakePing(pos, text, "");
    }

    public static void ReceivePlayerArmor(Packet packet)
    {
        int key = packet.ReadInt();
        int num = packet.ReadInt();
        int num2 = packet.ReadInt();
        MonoBehaviour.print("received armor slot: " + num + ", armor: " + num2);
        GameManager.players[key].SetArmor(num, num2);
    }

    public static void NewDay(Packet packet)
    {
        int day = packet.ReadInt();
        GameManager.instance.UpdateDay(day);
        DayCycle.time = 0f;
    }

    public static void GameOver(Packet packet)
    {
        int winnerId = packet.ReadInt();
        GameManager.instance.GameOver(winnerId);
    }

    public static void ShipUpdate(Packet packet)
    {
        Boat.BoatPackets p = (Boat.BoatPackets)packet.ReadInt();
        int interactId = packet.ReadInt();
        Boat.Instance.UpdateShipStatus(p, interactId);
    }

    public static void DragonUpdate(Packet packet)
    {
        BobMob.DragonState state = (BobMob.DragonState)packet.ReadInt();
        if ((bool)Dragon.Instance)
        {
            Dragon.Instance.transform.root.GetComponent<BobMob>().DragonUpdate(state);
        }
    }

    public static void ReceiveStats(Packet packet)
    {
        GameManager.instance.MakeStats(packet);
    }
}
