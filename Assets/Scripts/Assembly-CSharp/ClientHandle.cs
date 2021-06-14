using System;
using System.Net;
using UnityEngine;

// Token: 0x020000B5 RID: 181
public class ClientHandle : MonoBehaviour
{
	// Token: 0x06000437 RID: 1079 RVA: 0x00017808 File Offset: 0x00015A08
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

	// Token: 0x06000438 RID: 1080 RVA: 0x000178A4 File Offset: 0x00015AA4
	public static void Clock(Packet packet)
	{
		int num = packet.ReadInt(true);
		LoadingScreen.Instance.players[num] = true;
	}

	// Token: 0x06000439 RID: 1081 RVA: 0x00004F6E File Offset: 0x0000316E
	public static void PlayerFinishedLoading(Packet packet)
	{
		LoadingScreen.Instance.UpdateStatuses(packet.ReadInt(true));
	}

	// Token: 0x0600043A RID: 1082 RVA: 0x000178C8 File Offset: 0x00015AC8
	public static void DropItem(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		ItemManager.Instance.DropItem(fromClient, itemId, amount, objectID);
	}

	// Token: 0x0600043B RID: 1083 RVA: 0x00017904 File Offset: 0x00015B04
	public static void DropItemAtPosition(Packet packet)
	{
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropItemAtPosition(itemId, amount, pos, objectID);
	}

	// Token: 0x0600043C RID: 1084 RVA: 0x00017940 File Offset: 0x00015B40
	public static void DropPowerupAtPosition(Packet packet)
	{
		int powerupId = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropPowerupAtPosition(powerupId, pos, objectID);
	}

	// Token: 0x0600043D RID: 1085 RVA: 0x00017974 File Offset: 0x00015B74
	public static void DropResources(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int dropTableId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MonoBehaviour.print("CLIENT: Dropping resources with id: " + num);
		ItemManager.Instance.DropResource(fromClient, dropTableId, num);
	}

	// Token: 0x0600043E RID: 1086 RVA: 0x000179BC File Offset: 0x00015BBC
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

	// Token: 0x0600043F RID: 1087 RVA: 0x00017A64 File Offset: 0x00015C64
	public static void SpawnEffect(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		PowerupCalculations.Instance.SpawnOnHitEffect(id, false, pos, 0);
	}

	// Token: 0x06000440 RID: 1088 RVA: 0x00017A90 File Offset: 0x00015C90
	public static void WeaponInHand(Packet packet)
	{
		int key = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		GameManager.players[key].onlinePlayer.UpdateWeapon(objectID);
	}

	// Token: 0x06000441 RID: 1089 RVA: 0x00017AC4 File Offset: 0x00015CC4
	public static void AnimationUpdate(Packet packet)
	{
		int key = packet.ReadInt(true);
		int animation = packet.ReadInt(true);
		bool b = packet.ReadBool(true);
		GameManager.players[key].onlinePlayer.NewAnimation(animation, b);
	}

	// Token: 0x06000442 RID: 1090 RVA: 0x00017B00 File Offset: 0x00015D00
	public static void ShootArrowFromPlayer(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int arrowId = packet.ReadInt(true);
		int fromPlayer = packet.ReadInt(true);
		ProjectileController.Instance.SpawnProjectileFromPlayer(spawnPos, direction, force, arrowId, fromPlayer);
	}

	// Token: 0x06000443 RID: 1091 RVA: 0x00017B48 File Offset: 0x00015D48
	public static void PlayerHitObject(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int key = packet.ReadInt(true);
		int newHp = packet.ReadInt(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ResourceManager.Instance.list[key].GetComponent<Hitable>().Damage(newHp, fromClient, hitEffect, pos);
	}

	// Token: 0x06000444 RID: 1092 RVA: 0x00017BA0 File Offset: 0x00015DA0
	public static void RemoveResource(Packet packet)
	{
		int id = packet.ReadInt(true);
		ResourceManager.Instance.RemoveItem(id);
	}

	// Token: 0x06000445 RID: 1093 RVA: 0x00017BC0 File Offset: 0x00015DC0
	public static void PlayerHp(Packet packet)
	{
		int key = packet.ReadInt(true);
		float hpRatio = packet.ReadFloat(true);
		GameManager.players[key].SetHpRatio(hpRatio);
	}

	// Token: 0x06000446 RID: 1094 RVA: 0x00017BF0 File Offset: 0x00015DF0
	public static void RespawnPlayer(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 zero = packet.ReadVector3(true);
		GameManager.instance.RespawnPlayer(id, zero);
	}

	// Token: 0x06000447 RID: 1095 RVA: 0x00017C1C File Offset: 0x00015E1C
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

	// Token: 0x06000448 RID: 1096 RVA: 0x00017CF4 File Offset: 0x00015EF4
	public static void FinalizeBuild(Packet packet)
	{
		int buildOwner = packet.ReadInt(true);
		int itemID = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		Vector3 position = packet.ReadVector3(true);
		int yRotation = packet.ReadInt(true);
		MonoBehaviour.print("Received build, now building");
		BuildManager.Instance.BuildItem(buildOwner, itemID, objectId, position, yRotation);
	}

	// Token: 0x06000449 RID: 1097 RVA: 0x00017D48 File Offset: 0x00015F48
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

	// Token: 0x0600044A RID: 1098 RVA: 0x00017E1C File Offset: 0x0001601C
	public static void UpdateChest(Packet packet)
	{
		packet.ReadInt(true);
		int chestId = packet.ReadInt(true);
		int cellId = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
	}

	// Token: 0x0600044B RID: 1099 RVA: 0x00017E60 File Offset: 0x00016060
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

	// Token: 0x0600044C RID: 1100 RVA: 0x00017EDC File Offset: 0x000160DC
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

	// Token: 0x0600044D RID: 1101 RVA: 0x00017F44 File Offset: 0x00016144
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

	// Token: 0x0600044E RID: 1102 RVA: 0x00018024 File Offset: 0x00016224
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

	// Token: 0x0600044F RID: 1103 RVA: 0x00018060 File Offset: 0x00016260
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

	// Token: 0x06000450 RID: 1104 RVA: 0x000180A8 File Offset: 0x000162A8
	public static void ReceivePing(Packet packet)
	{
		packet.ReadInt(true);
		DateTime d = DateTime.Parse(packet.ReadString(true));
		NetStatus.AddPing((int)(DateTime.Now - d).TotalMilliseconds);
	}

	// Token: 0x06000451 RID: 1105 RVA: 0x00004F81 File Offset: 0x00003181
	public static void ReceiveStatus(Packet packet)
	{
		MonoBehaviour.print("received status");
	}

	// Token: 0x06000452 RID: 1106 RVA: 0x00004F8D File Offset: 0x0000318D
	public static void ConnectionEstablished(Packet packet)
	{
		MonoBehaviour.print("connection has successfully been established. ready to enter game");
		GameManager.connected = true;
	}

	// Token: 0x06000453 RID: 1107 RVA: 0x00004F9F File Offset: 0x0000319F
	public static void OpenDoor(Packet packet)
	{
		packet.ReadInt(true);
	}

	// Token: 0x06000454 RID: 1108 RVA: 0x000180E4 File Offset: 0x000162E4
	public static void PlayerDied(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		GameManager.instance.KillPlayer(id, pos);
	}

	// Token: 0x06000455 RID: 1109 RVA: 0x00018110 File Offset: 0x00016310
	public static void SpawnGrave(Packet packet)
	{
		int playerId = packet.ReadInt(true);
		int graveObjectId = packet.ReadInt(true);
		Vector3 gravePos = packet.ReadVector3(true);
		GameManager.instance.SpawnGrave(gravePos, playerId, graveObjectId);
	}

	// Token: 0x06000456 RID: 1110 RVA: 0x00004FA9 File Offset: 0x000031A9
	public static void Ready(Packet packet)
	{
		packet.ReadInt(true);
		packet.ReadBool(true);
	}

	// Token: 0x06000457 RID: 1111 RVA: 0x00018144 File Offset: 0x00016344
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

	// Token: 0x06000458 RID: 1112 RVA: 0x00018194 File Offset: 0x00016394
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

	// Token: 0x06000459 RID: 1113 RVA: 0x00018210 File Offset: 0x00016410
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

	// Token: 0x0600045A RID: 1114 RVA: 0x000182CC File Offset: 0x000164CC
	public static void MobSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int mobType = packet.ReadInt(true);
		int mobId = packet.ReadInt(true);
		float multiplier = packet.ReadFloat(true);
		float bossMultiplier = packet.ReadFloat(true);
		MobSpawner.Instance.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, Mob.BossType.None);
	}

	// Token: 0x0600045B RID: 1115 RVA: 0x00018314 File Offset: 0x00016514
	public static void MobMove(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 position = packet.ReadVector3(true);
		if (MobManager.Instance.mobs[key])
		{
			MobManager.Instance.mobs[key].SetPosition(position);
		}
	}

	// Token: 0x0600045C RID: 1116 RVA: 0x00018360 File Offset: 0x00016560
	public static void MobSetDestination(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 destination = packet.ReadVector3(true);
		MobManager.Instance.mobs[key].SetDestination(destination);
	}

	// Token: 0x0600045D RID: 1117 RVA: 0x00018394 File Offset: 0x00016594
	public static void MobSetTarget(Packet packet)
	{
		int key = packet.ReadInt(true);
		int target = packet.ReadInt(true);
		MobManager.Instance.mobs[key].SetTarget(target);
	}

	// Token: 0x0600045E RID: 1118 RVA: 0x000183C8 File Offset: 0x000165C8
	public static void MobAttack(Packet packet)
	{
		int key = packet.ReadInt(true);
		int targetPlayerId = packet.ReadInt(true);
		int attackAnimationIndex = packet.ReadInt(true);
		MobManager.Instance.mobs[key].Attack(targetPlayerId, attackAnimationIndex);
	}

	// Token: 0x0600045F RID: 1119 RVA: 0x00018404 File Offset: 0x00016604
	public static void MobSpawnProjectile(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int itemId = packet.ReadInt(true);
		int mobObjectId = packet.ReadInt(true);
		ProjectileController.Instance.SpawnMobProjectile(spawnPos, direction, force, itemId, mobObjectId);
	}

	// Token: 0x06000460 RID: 1120 RVA: 0x0001844C File Offset: 0x0001664C
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

	// Token: 0x06000461 RID: 1121 RVA: 0x000184C0 File Offset: 0x000166C0
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

	// Token: 0x06000462 RID: 1122 RVA: 0x00018508 File Offset: 0x00016708
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

	// Token: 0x06000463 RID: 1123 RVA: 0x00018570 File Offset: 0x00016770
	public static void MobZoneToggle(Packet packet)
	{
		bool show = packet.ReadBool(true);
		int key = packet.ReadInt(true);
		MobZoneManager.Instance.zones[key].ToggleEntities(show);
	}

	// Token: 0x06000464 RID: 1124 RVA: 0x000185A4 File Offset: 0x000167A4
	public static void MobZoneSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x06000465 RID: 1125 RVA: 0x000185A4 File Offset: 0x000167A4
	public static void PickupSpawnZone(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x06000466 RID: 1126 RVA: 0x000185EC File Offset: 0x000167EC
	public static void ReceiveChatMessage(Packet packet)
	{
		int fromUser = packet.ReadInt(true);
		string fromUsername = packet.ReadString(true);
		string message = packet.ReadString(true);
		ChatBox.Instance.AppendMessage(fromUser, message, fromUsername);
	}

	// Token: 0x06000467 RID: 1127 RVA: 0x00018620 File Offset: 0x00016820
	public static void ReceivePlayerPing(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		string name = packet.ReadString(true);
		PingController.Instance.MakePing(pos, name, "");
	}

	// Token: 0x06000468 RID: 1128 RVA: 0x00018650 File Offset: 0x00016850
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

	// Token: 0x06000469 RID: 1129 RVA: 0x000186BC File Offset: 0x000168BC
	public static void NewDay(Packet packet)
	{
		int day = packet.ReadInt(true);
		GameManager.instance.UpdateDay(day);
		DayCycle.time = 0f;
	}

	// Token: 0x0600046A RID: 1130 RVA: 0x000186E8 File Offset: 0x000168E8
	public static void GameOver(Packet packet)
	{
		int winnerId = packet.ReadInt(true);
		GameManager.instance.GameOver(winnerId);
	}
}
