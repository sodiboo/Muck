using System;
using System.IO;
using System.Net;
using UnityEngine;


public class ClientHandle : MonoBehaviour
{

    public static void Welcome(Packet packet)
    {
        string str = packet.ReadString(true);
        packet.ReadFloat(true);
        int num = packet.ReadInt(true);
        Debug.Log("Message from server: " + str);
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
        int num = packet.ReadInt(true);
        LoadingScreen.Instance.players[num] = true;
    }


    public static void PlayerFinishedLoading(Packet packet)
    {
        LoadingScreen.Instance.UpdateStatuses(packet.ReadInt(true));
    }


    public static void DropItem(Packet packet)
    {
        int fromClient = packet.ReadInt(true);
        int itemId = packet.ReadInt(true);
        int amount = packet.ReadInt(true);
        int objectID = packet.ReadInt(true);
        ItemManager.Instance.DropItem(fromClient, itemId, amount, objectID);
    }


    public static void DropItemAtPosition(Packet packet)
    {
        int itemId = packet.ReadInt(true);
        int amount = packet.ReadInt(true);
        int objectID = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        ItemManager.Instance.DropItemAtPosition(itemId, amount, pos, objectID);
    }


    public static void DropPowerupAtPosition(Packet packet)
    {
        int powerupId = packet.ReadInt(true);
        int objectID = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        ItemManager.Instance.DropPowerupAtPosition(powerupId, pos, objectID);
    }


    public static void DropResources(Packet packet)
    {
        int fromClient = packet.ReadInt(true);
        int dropTableId = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        MonoBehaviour.print("CLIENT: Dropping resources with id: " + num);
        ItemManager.Instance.DropResource(fromClient, dropTableId, num);
    }


    public static void PickupItem(Packet packet)
    {
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        if (LocalClient.instance.myId == num && !LocalClient.serverOwner)
        {
            Item component = ItemManager.Instance.list[num2].GetComponent<Item>();
            if (component.item)
            {
                InventoryUI.Instance.AddItemToInventory(component.item);
            }
            else if (component.powerup)
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
        int id = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        PowerupCalculations.Instance.SpawnOnHitEffect(id, false, pos, 0);
    }


    public static void WeaponInHand(Packet packet)
    {
        int key = packet.ReadInt(true);
        int objectID = packet.ReadInt(true);
        GameManager.players[key].onlinePlayer.UpdateWeapon(objectID);
    }


    public static void AnimationUpdate(Packet packet)
    {
        int key = packet.ReadInt(true);
        int animation = packet.ReadInt(true);
        bool b = packet.ReadBool(true);
        GameManager.players[key].onlinePlayer.NewAnimation(animation, b);
    }


    public static void ShootArrowFromPlayer(Packet packet)
    {
        Vector3 spawnPos = packet.ReadVector3(true);
        Vector3 direction = packet.ReadVector3(true);
        float force = packet.ReadFloat(true);
        int arrowId = packet.ReadInt(true);
        int fromPlayer = packet.ReadInt(true);
        ProjectileController.Instance.SpawnProjectileFromPlayer(spawnPos, direction, force, arrowId, fromPlayer);
    }


    public static void PlayerHitObject(Packet packet)
    {
        int fromClient = packet.ReadInt(true);
        int key = packet.ReadInt(true);
        int newHp = packet.ReadInt(true);
        int hitEffect = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        ResourceManager.Instance.list[key].GetComponent<Hitable>().Damage(newHp, fromClient, hitEffect, pos);
    }


    public static void RemoveResource(Packet packet)
    {
        int id = packet.ReadInt(true);
        ResourceManager.Instance.RemoveItem(id);
    }


    public static void PlayerHp(Packet packet)
    {
        int key = packet.ReadInt(true);
        float hpRatio = packet.ReadFloat(true);
        GameManager.players[key].SetHpRatio(hpRatio);
    }


    public static void RespawnPlayer(Packet packet)
    {
        int id = packet.ReadInt(true);
        Vector3 zero = packet.ReadVector3(true);
        GameManager.instance.RespawnPlayer(id, zero);
    }


    public static void PlayerHit(Packet packet)
    {
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        float num3 = packet.ReadFloat(true);
        int num4 = packet.ReadInt(true);
        int hitEffect = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        MonoBehaviour.print(string.Concat(new object[]
        {
            "recevied player hit. Damage: ",
            num2,
            ", ratio: ",
            num3,
            "from: ",
            num,
            ", to: ",
            num4
        }));
        PlayerManager playerManager = GameManager.players[num4];
        if (num4 == LocalClient.instance.myId)
        {
            PlayerStatus.Instance.DealDamage(num2, false);
        }
        else
        {
            playerManager.SetHpRatio(num3);
        }
        playerManager.hitable.Damage(num2, num, hitEffect, pos);
    }


    public static void FinalizeBuild(Packet packet)
    {
        int buildOwner = packet.ReadInt(true);
        int itemID = packet.ReadInt(true);
        int objectId = packet.ReadInt(true);
        Vector3 position = packet.ReadVector3(true);
        Quaternion rotation = packet.ReadQuaternion(true);
        BuildManager.Instance.BuildItem(buildOwner, itemID, objectId, position, rotation);
    }


    public static void OpenChest(Packet packet)
    {
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        bool flag = packet.ReadBool(true);
        MonoBehaviour.print(string.Format("player{0} now {1} chest{2}", num, flag, num2));
        ChestManager.Instance.UseChest(num2, flag);
        if (flag && num == LocalClient.instance.myId)
        {
            if (OtherInput.Instance.currentChest != null)
            {
                ClientSend.RequestChest(OtherInput.Instance.currentChest.id, false);
                OtherInput.Instance.currentChest = null;
            }
            OtherInput.Instance.currentChest = ChestManager.Instance.chests[num2];
            OtherInput.CraftingState state = ChestManager.Instance.chests[num2].GetComponentInChildren<ChestInteract>().state;
            OtherInput.Instance.ToggleInventory(state);
        }
    }


    public static void UpdateChest(Packet packet)
    {
        packet.ReadInt(true);
        int chestId = packet.ReadInt(true);
        int cellId = packet.ReadInt(true);
        int itemId = packet.ReadInt(true);
        int amount = packet.ReadInt(true);
        ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
    }


    public static void PickupInteract(Packet packet)
    {
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
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
        int id = packet.ReadInt(true);
        string username = packet.ReadString(true);
        Vector3 vector = packet.ReadVector3(true);
        Vector3 position = packet.ReadVector3(true);
        float orientationY = packet.ReadFloat(true);
        GameManager.instance.SpawnPlayer(id, username, new Color(vector.x, vector.y, vector.z), position, orientationY);
        GameManager.instance.StartGame();
    }


    public static void StartGame(Packet packet)
    {
        if (NetworkController.Instance.loading)
        {
            return;
        }
        LocalClient.instance.myId = packet.ReadInt(true);
        int seed = packet.ReadInt(true);
        int gameMode = packet.ReadInt(true);
        int friendlyFire = packet.ReadInt(true);
        int difficulty = packet.ReadInt(true);
        int gameLength = packet.ReadInt(true);
        int multiplayer = packet.ReadInt(true);
        GameManager.gameSettings = new GameSettings(seed, gameMode, friendlyFire, difficulty, gameLength, multiplayer);
        MonoBehaviour.print("Game settings successfully loaded");
        MonoBehaviour.print("loading game scene, assigned id: " + LocalClient.instance.myId);
        int num = packet.ReadInt(true);
        string[] array = new string[num];
        for (int i = 0; i < num; i++)
        {
            packet.ReadInt(true);
            string text = packet.ReadString(true);
            array[i] = text;
        }
        NetworkController.Instance.LoadGame(array);
        ClientSend.StartedLoading();
    }


    public static void PlayerPosition(Packet packet)
    {
        int key = packet.ReadInt(true);
        Vector3 desiredPosition = packet.ReadVector3(true);
        if (!GameManager.players.ContainsKey(key))
        {
            return;
        }
        GameManager.players[key].SetDesiredPosition(desiredPosition);
    }


    public static void PlayerRotation(Packet packet)
    {
        int key = packet.ReadInt(true);
        if (!GameManager.players.ContainsKey(key))
        {
            return;
        }
        float orientationY = packet.ReadFloat(true);
        float orientationX = packet.ReadFloat(true);
        GameManager.players[key].SetDesiredRotation(orientationY, orientationX);
    }


    public static void ReceivePing(Packet packet)
    {
        packet.ReadInt(true);
        DateTime d = DateTime.Parse(packet.ReadString(true));
        NetStatus.AddPing((int)(DateTime.Now - d).TotalMilliseconds);
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
        packet.ReadInt(true);
    }


    public static void PlayerDied(Packet packet)
    {
        int id = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        GameManager.instance.KillPlayer(id, pos);
    }


    public static void SpawnGrave(Packet packet)
    {
        int playerId = packet.ReadInt(true);
        int graveObjectId = packet.ReadInt(true);
        Vector3 gravePos = packet.ReadVector3(true);
        GameManager.instance.SpawnGrave(gravePos, playerId, graveObjectId);
    }


    public static void Ready(Packet packet)
    {
        packet.ReadInt(true);
        packet.ReadBool(true);
    }


    public static void DisconnectPlayer(Packet packet)
    {
        int num = packet.ReadInt(true);
        Debug.Log(string.Format("Player {0} has disconnected", num));
        if (num == LocalClient.instance.myId)
        {
            GameManager.instance.LeaveGame();
            return;
        }
        GameManager.instance.DisconnectPlayer(num);
    }


    public static void ShrineCombatStart(Packet packet)
    {
        int key = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        ShrineInteractable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<ShrineInteractable>();
        if (!componentInChildren)
        {
            return;
        }
        MonoBehaviour.print("starting new shrine with mobs: " + num);
        int[] array = new int[num];
        for (int i = 0; i < num; i++)
        {
            array[i] = packet.ReadInt(true);
        }
        componentInChildren.StartShrine(array);
    }


    public static void RevivePlayer(Packet packet)
    {
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        bool flag = packet.ReadBool(true);
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
        int key = packet.ReadInt(true);
        if (ResourceManager.Instance.list.ContainsKey(key))
        {
            ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>().AllExecute();
        }
    }


    public static void MobSpawn(Packet packet)
    {
        Vector3 pos = packet.ReadVector3(true);
        int mobType = packet.ReadInt(true);
        int mobId = packet.ReadInt(true);
        float multiplier = packet.ReadFloat(true);
        float bossMultiplier = packet.ReadFloat(true);
        MobSpawner.Instance.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, Mob.BossType.None);
    }


    public static void MobMove(Packet packet)
    {
        int key = packet.ReadInt(true);
        Vector3 position = packet.ReadVector3(true);
        if (MobManager.Instance.mobs[key])
        {
            MobManager.Instance.mobs[key].SetPosition(position);
        }
    }


    public static void MobSetDestination(Packet packet)
    {
        int key = packet.ReadInt(true);
        Vector3 destination = packet.ReadVector3(true);
        MobManager.Instance.mobs[key].SetDestination(destination);
    }


    public static void MobSetTarget(Packet packet)
    {
        int key = packet.ReadInt(true);
        int target = packet.ReadInt(true);
        MobManager.Instance.mobs[key].SetTarget(target);
    }


    public static void MobAttack(Packet packet)
    {
        int key = packet.ReadInt(true);
        int targetPlayerId = packet.ReadInt(true);
        int attackAnimationIndex = packet.ReadInt(true);
        MobManager.Instance.mobs[key].Attack(targetPlayerId, attackAnimationIndex);
    }


    public static void MobSpawnProjectile(Packet packet)
    {
        Vector3 spawnPos = packet.ReadVector3(true);
        Vector3 direction = packet.ReadVector3(true);
        float force = packet.ReadFloat(true);
        int itemId = packet.ReadInt(true);
        int mobObjectId = packet.ReadInt(true);
        ProjectileController.Instance.SpawnMobProjectile(spawnPos, direction, force, itemId, mobObjectId);
    }


    public static void PlayerDamageMob(Packet packet)
    {
        int num = packet.ReadInt(true);
        int key = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        int hitEffect = packet.ReadInt(true);
        Vector3 pos = packet.ReadVector3(true);
        if (num2 <= 0 && LocalClient.instance.myId == num)
        {
            PlayerStatus.Instance.Dracula();
        }
        MobManager.Instance.mobs[key].hitable.Damage(num2, num, hitEffect, pos);
    }


    public static void KnockbackMob(Packet packet)
    {
        int key = packet.ReadInt(true);
        Vector3 dir = packet.ReadVector3(true);
        if (!MobManager.Instance.mobs.ContainsKey(key))
        {
            return;
        }
        MobManager.Instance.mobs[key].Knockback(dir);
    }


    public static void Interact(Packet packet)
    {
        int key = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        if (ResourceManager.Instance.list.ContainsKey(key))
        {
            Interactable componentInChildren = ResourceManager.Instance.list[key].GetComponentInChildren<Interactable>();
            if (componentInChildren.IsStarted())
            {
                return;
            }
            if (num == LocalClient.instance.myId)
            {
                componentInChildren.LocalExecute();
            }
            componentInChildren.AllExecute();
        }
    }


    public static void MobZoneToggle(Packet packet)
    {
        bool show = packet.ReadBool(true);
        int key = packet.ReadInt(true);
        MobZoneManager.Instance.zones[key].ToggleEntities(show);
    }


    public static void MobZoneSpawn(Packet packet)
    {
        Vector3 pos = packet.ReadVector3(true);
        int entityType = packet.ReadInt(true);
        int objectId = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
    }


    public static void PickupSpawnZone(Packet packet)
    {
        Vector3 pos = packet.ReadVector3(true);
        int entityType = packet.ReadInt(true);
        int objectId = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
    }


    public static void ReceiveChatMessage(Packet packet)
    {
        int fromUser = packet.ReadInt(true);
        string fromUsername = packet.ReadString(true);
        string message = packet.ReadString(true);
        ChatBox.Instance.AppendMessage(fromUser, message, fromUsername);
    }


    public static void ReceivePlayerPing(Packet packet)
    {
        Vector3 pos = packet.ReadVector3(true);
        string name = packet.ReadString(true);
        PingController.Instance.MakePing(pos, name, "");
    }


    public static void ReceivePlayerArmor(Packet packet)
    {
        int key = packet.ReadInt(true);
        int num = packet.ReadInt(true);
        int num2 = packet.ReadInt(true);
        MonoBehaviour.print(string.Concat(new object[]
        {
            "received armor slot: ",
            num,
            ", armor: ",
            num2
        }));
        GameManager.players[key].SetArmor(num, num2);
    }


    public static void NewDay(Packet packet)
    {
        int day = packet.ReadInt(true);
        GameManager.instance.UpdateDay(day);
        DayCycle.totalTime = day;
    }


    public static void GameOver(Packet packet)
    {
        int winnerId = packet.ReadInt(true);
        GameManager.instance.GameOver(winnerId);
    }

    public static void EnterVehicle(Packet packet)
    {
        var fromClient = packet.ReadInt();
        var id = packet.ReadInt();
        var car = ResourceManager.Instance.cars[id];
        car.inUse = true;
        if (fromClient != LocalClient.instance.myId)
        {

            GameManager.players[fromClient].GetComponent<Collider>().enabled = false;
            return;
        }
        MoveCamera.Instance.state = MoveCamera.CameraState.Car;
        MoveCamera.Instance.gunCamera.enabled = false;
        PlayerMovement.Instance.GetPlayerCollider().enabled = false;
        PlayerMovement.Instance.GetRb().isKinematic = true;
        Hotbar.Instance.gameObject.SetActive(false);
        OtherInput.Instance.currentCar = car;
        if (Map.Instance.active) Map.Instance.ToggleMap();
        if (InventoryUI.Instance.backDrop.activeInHierarchy) InventoryUI.Instance.ToggleInventory();
        MusicController.Instance.PlaySong(MusicController.SongType.Eurobeat);
    }

    public static void UpdateCar(Packet packet)
    {
        var id = packet.ReadInt();
        var car = ResourceManager.Instance.cars[id];

        car.rb.angularVelocity = packet.ReadVector3();
        car.lastVelocity = packet.ReadVector3();
        car.rb.velocity = packet.ReadVector3();

        car.rb.rotation = packet.ReadQuaternion();
        car.rb.position = packet.ReadVector3();

        car.throttle = packet.ReadFloat();
        car.steering = packet.ReadFloat();
        car.breaking = packet.ReadBool();

        foreach (var sus in car.wheelPositions)
        {
            sus.wheelAngleVelocity = packet.ReadFloat();
            sus.lastCompression = packet.ReadFloat();
        }
    }

    public static void ExitVehicle(Packet packet)
    {
        var fromClient = packet.ReadInt();
        var id = packet.ReadInt();
        var car = ResourceManager.Instance.cars[id];
        car.inUse = false;
        car.breaking = true;
        car.throttle = 0f;
        car.steering = 0f;
        if (fromClient != LocalClient.instance.myId)
        {
            GameManager.players[fromClient].GetComponent<Collider>().enabled = true;
            return;
        }
        var target = MoveCamera.Instance.transform.parent.gameObject;
        MoveCamera.Instance.transform.SetParent(null);
        MoveCamera.Instance.state = MoveCamera.CameraState.Player;
        MoveCamera.Instance.gunCamera.enabled = true;
        PlayerMovement.Instance.GetPlayerCollider().enabled = true;
        PlayerMovement.Instance.GetRb().isKinematic = false;
        Hotbar.Instance.gameObject.SetActive(true);
        OtherInput.Instance.currentCar = null;
        Destroy(target);
        MusicController.Instance.StopSong();
    }

    public static void LoadSave(Packet packet)
    {
        SaveData.Instance.ReadPacket(packet);
        SaveData.Instance.ExecuteSave();
    }

    public static void DontDestroy(Packet packet)
    {
        BuildDestruction.dontDestroy = packet.ReadBool();
        if (BuildDestruction.dontDestroy)
        {
            ChatBox.Instance.AppendMessage(-1, $"<color=#{ColorUtility.ToHtmlStringRGB(Color.cyan)}>Breaking structures will no longer destroy their neighbors<color=white>", "");
        }
        else
        {
            ChatBox.Instance.AppendMessage(-1, $"<color=#{ColorUtility.ToHtmlStringRGB(Color.cyan)}>Breaking structures will now destroy their neighbors<color=white>", "");
        }
    }
}
