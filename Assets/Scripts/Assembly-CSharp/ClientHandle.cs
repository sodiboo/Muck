using System;
using System.Net;
using UnityEngine;

// Token: 0x020000B6 RID: 182
public class ClientHandle : MonoBehaviour
{
	// Token: 0x060004D6 RID: 1238 RVA: 0x00018E28 File Offset: 0x00017028
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

	// Token: 0x060004D7 RID: 1239 RVA: 0x00018EC4 File Offset: 0x000170C4
	public static void Clock(Packet packet)
	{
		int num = packet.ReadInt(true);
		LoadingScreen.Instance.players[num] = true;
	}

	// Token: 0x060004D8 RID: 1240 RVA: 0x00018EE6 File Offset: 0x000170E6
	public static void PlayerFinishedLoading(Packet packet)
	{
		LoadingScreen.Instance.UpdateStatuses(packet.ReadInt(true));
	}

	// Token: 0x060004D9 RID: 1241 RVA: 0x00018EFC File Offset: 0x000170FC
	public static void DropItem(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		ItemManager.Instance.DropItem(fromClient, itemId, amount, objectID);
	}

	// Token: 0x060004DA RID: 1242 RVA: 0x00018F38 File Offset: 0x00017138
	public static void DropItemAtPosition(Packet packet)
	{
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropItemAtPosition(itemId, amount, pos, objectID);
	}

	// Token: 0x060004DB RID: 1243 RVA: 0x00018F74 File Offset: 0x00017174
	public static void DropPowerupAtPosition(Packet packet)
	{
		int powerupId = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropPowerupAtPosition(powerupId, pos, objectID);
	}

	// Token: 0x060004DC RID: 1244 RVA: 0x00018FA8 File Offset: 0x000171A8
	public static void DropResources(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int dropTableId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MonoBehaviour.print("CLIENT: Dropping resources with id: " + num);
		ItemManager.Instance.DropResource(fromClient, dropTableId, num);
	}

	// Token: 0x060004DD RID: 1245 RVA: 0x00018FF0 File Offset: 0x000171F0
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

	// Token: 0x060004DE RID: 1246 RVA: 0x00019098 File Offset: 0x00017298
	public static void SpawnEffect(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		PowerupCalculations.Instance.SpawnOnHitEffect(id, false, pos, 0);
	}

	// Token: 0x060004DF RID: 1247 RVA: 0x000190C4 File Offset: 0x000172C4
	public static void WeaponInHand(Packet packet)
	{
		int key = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		GameManager.players[key].onlinePlayer.UpdateWeapon(objectID);
	}

	// Token: 0x060004E0 RID: 1248 RVA: 0x000190F8 File Offset: 0x000172F8
	public static void AnimationUpdate(Packet packet)
	{
		int key = packet.ReadInt(true);
		int animation = packet.ReadInt(true);
		bool b = packet.ReadBool(true);
		GameManager.players[key].onlinePlayer.NewAnimation(animation, b);
	}

	// Token: 0x060004E1 RID: 1249 RVA: 0x00019134 File Offset: 0x00017334
	public static void ShootArrowFromPlayer(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int arrowId = packet.ReadInt(true);
		int fromPlayer = packet.ReadInt(true);
		ProjectileController.Instance.SpawnProjectileFromPlayer(spawnPos, direction, force, arrowId, fromPlayer);
	}

	// Token: 0x060004E2 RID: 1250 RVA: 0x0001917C File Offset: 0x0001737C
	public static void PlayerHitObject(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int key = packet.ReadInt(true);
		int newHp = packet.ReadInt(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ResourceManager.Instance.list[key].GetComponent<Hitable>().Damage(newHp, fromClient, hitEffect, pos);
	}

	// Token: 0x060004E3 RID: 1251 RVA: 0x000191D4 File Offset: 0x000173D4
	public static void RemoveResource(Packet packet)
	{
		int id = packet.ReadInt(true);
		ResourceManager.Instance.RemoveItem(id);
	}

	// Token: 0x060004E4 RID: 1252 RVA: 0x000191F4 File Offset: 0x000173F4
	public static void PlayerHp(Packet packet)
	{
		int key = packet.ReadInt(true);
		float hpRatio = packet.ReadFloat(true);
		GameManager.players[key].SetHpRatio(hpRatio);
	}

	// Token: 0x060004E5 RID: 1253 RVA: 0x00019224 File Offset: 0x00017424
	public static void RespawnPlayer(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 zero = packet.ReadVector3(true);
		GameManager.instance.RespawnPlayer(id, zero);
	}

	// Token: 0x060004E6 RID: 1254 RVA: 0x00019250 File Offset: 0x00017450
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

	// Token: 0x060004E7 RID: 1255 RVA: 0x00019328 File Offset: 0x00017528
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

	// Token: 0x060004E8 RID: 1256 RVA: 0x0001937C File Offset: 0x0001757C
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

	// Token: 0x060004E9 RID: 1257 RVA: 0x00019450 File Offset: 0x00017650
	public static void UpdateChest(Packet packet)
	{
		packet.ReadInt(true);
		int chestId = packet.ReadInt(true);
		int cellId = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
	}

	// Token: 0x060004EA RID: 1258 RVA: 0x00019494 File Offset: 0x00017694
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

	// Token: 0x060004EB RID: 1259 RVA: 0x00019510 File Offset: 0x00017710
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

	// Token: 0x060004EC RID: 1260 RVA: 0x00019578 File Offset: 0x00017778
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

	// Token: 0x060004ED RID: 1261 RVA: 0x00019658 File Offset: 0x00017858
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

	// Token: 0x060004EE RID: 1262 RVA: 0x00019694 File Offset: 0x00017894
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

	// Token: 0x060004EF RID: 1263 RVA: 0x000196DC File Offset: 0x000178DC
	public static void ReceivePing(Packet packet)
	{
		packet.ReadInt(true);
		DateTime d = DateTime.Parse(packet.ReadString(true));
		NetStatus.AddPing((int)(DateTime.Now - d).TotalMilliseconds);
	}

	// Token: 0x060004F0 RID: 1264 RVA: 0x00019717 File Offset: 0x00017917
	public static void ReceiveStatus(Packet packet)
	{
		MonoBehaviour.print("received status");
	}

	// Token: 0x060004F1 RID: 1265 RVA: 0x00019723 File Offset: 0x00017923
	public static void ConnectionEstablished(Packet packet)
	{
		MonoBehaviour.print("connection has successfully been established. ready to enter game");
		GameManager.connected = true;
	}

	// Token: 0x060004F2 RID: 1266 RVA: 0x00019735 File Offset: 0x00017935
	public static void OpenDoor(Packet packet)
	{
		packet.ReadInt(true);
	}

	// Token: 0x060004F3 RID: 1267 RVA: 0x00019740 File Offset: 0x00017940
	public static void PlayerDied(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		GameManager.instance.KillPlayer(id, pos);
	}

	// Token: 0x060004F4 RID: 1268 RVA: 0x0001976C File Offset: 0x0001796C
	public static void SpawnGrave(Packet packet)
	{
		int playerId = packet.ReadInt(true);
		int graveObjectId = packet.ReadInt(true);
		Vector3 gravePos = packet.ReadVector3(true);
		GameManager.instance.SpawnGrave(gravePos, playerId, graveObjectId);
	}

	// Token: 0x060004F5 RID: 1269 RVA: 0x0001979E File Offset: 0x0001799E
	public static void Ready(Packet packet)
	{
		packet.ReadInt(true);
		packet.ReadBool(true);
	}

	// Token: 0x060004F6 RID: 1270 RVA: 0x000197B0 File Offset: 0x000179B0
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

	// Token: 0x060004F7 RID: 1271 RVA: 0x00019800 File Offset: 0x00017A00
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

	// Token: 0x060004F8 RID: 1272 RVA: 0x0001987C File Offset: 0x00017A7C
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

	// Token: 0x060004F9 RID: 1273 RVA: 0x00019938 File Offset: 0x00017B38
	public static void MobSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int mobType = packet.ReadInt(true);
		int mobId = packet.ReadInt(true);
		float multiplier = packet.ReadFloat(true);
		float bossMultiplier = packet.ReadFloat(true);
		int guardianType = packet.ReadInt(true);
		MobSpawner.Instance.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, Mob.BossType.None, guardianType);
	}

	// Token: 0x060004FA RID: 1274 RVA: 0x0001998C File Offset: 0x00017B8C
	public static void MobMove(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 position = packet.ReadVector3(true);
		if (MobManager.Instance.mobs[key])
		{
			MobManager.Instance.mobs[key].SetPosition(position);
		}
	}

	// Token: 0x060004FB RID: 1275 RVA: 0x000199D8 File Offset: 0x00017BD8
	public static void MobSetDestination(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 destination = packet.ReadVector3(true);
		MobManager.Instance.mobs[key].SetDestination(destination);
	}

	// Token: 0x060004FC RID: 1276 RVA: 0x00019A0C File Offset: 0x00017C0C
	public static void MobSetTarget(Packet packet)
	{
		int key = packet.ReadInt(true);
		int target = packet.ReadInt(true);
		MobManager.Instance.mobs[key].SetTarget(target);
	}

	// Token: 0x060004FD RID: 1277 RVA: 0x00019A40 File Offset: 0x00017C40
	public static void MobAttack(Packet packet)
	{
		int key = packet.ReadInt(true);
		int targetPlayerId = packet.ReadInt(true);
		int attackAnimationIndex = packet.ReadInt(true);
		MobManager.Instance.mobs[key].Attack(targetPlayerId, attackAnimationIndex);
	}

	// Token: 0x060004FE RID: 1278 RVA: 0x00019A7C File Offset: 0x00017C7C
	public static void MobSpawnProjectile(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int itemId = packet.ReadInt(true);
		int mobObjectId = packet.ReadInt(true);
		ProjectileController.Instance.SpawnMobProjectile(spawnPos, direction, force, itemId, mobObjectId);
	}

	// Token: 0x060004FF RID: 1279 RVA: 0x00019AC4 File Offset: 0x00017CC4
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

	// Token: 0x06000500 RID: 1280 RVA: 0x00019B38 File Offset: 0x00017D38
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

	// Token: 0x06000501 RID: 1281 RVA: 0x00019B80 File Offset: 0x00017D80
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

	// Token: 0x06000502 RID: 1282 RVA: 0x00019BE8 File Offset: 0x00017DE8
	public static void MobZoneToggle(Packet packet)
	{
		bool show = packet.ReadBool(true);
		int key = packet.ReadInt(true);
		MobZoneManager.Instance.zones[key].ToggleEntities(show);
	}

	// Token: 0x06000503 RID: 1283 RVA: 0x00019C1C File Offset: 0x00017E1C
	public static void MobZoneSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x06000504 RID: 1284 RVA: 0x00019C64 File Offset: 0x00017E64
	public static void PickupSpawnZone(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x06000505 RID: 1285 RVA: 0x00019CAC File Offset: 0x00017EAC
	public static void ReceiveChatMessage(Packet packet)
	{
		int fromUser = packet.ReadInt(true);
		string fromUsername = packet.ReadString(true);
		string message = packet.ReadString(true);
		ChatBox.Instance.AppendMessage(fromUser, message, fromUsername);
	}

	// Token: 0x06000506 RID: 1286 RVA: 0x00019CE0 File Offset: 0x00017EE0
	public static void ReceivePlayerPing(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		string name = packet.ReadString(true);
		PingController.Instance.MakePing(pos, name, "");
	}

	// Token: 0x06000507 RID: 1287 RVA: 0x00019D10 File Offset: 0x00017F10
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

	// Token: 0x06000508 RID: 1288 RVA: 0x00019D7C File Offset: 0x00017F7C
	public static void NewDay(Packet packet)
	{
		int day = packet.ReadInt(true);
		GameManager.instance.UpdateDay(day);
		DayCycle.time = 0f;
	}

	// Token: 0x06000509 RID: 1289 RVA: 0x00019DA8 File Offset: 0x00017FA8
	public static void GameOver(Packet packet)
	{
		int winnerId = packet.ReadInt(true);
		GameManager.instance.GameOver(winnerId, 4f);
	}

	// Token: 0x0600050A RID: 1290 RVA: 0x00019DD0 File Offset: 0x00017FD0
	public static void ShipUpdate(Packet packet)
	{
		Boat.BoatPackets p = (Boat.BoatPackets)packet.ReadInt(true);
		int interactId = packet.ReadInt(true);
		Boat.Instance.UpdateShipStatus(p, interactId);
	}

	// Token: 0x0600050B RID: 1291 RVA: 0x00019DFC File Offset: 0x00017FFC
	public static void DragonUpdate(Packet packet)
	{
		BobMob.DragonState state = (BobMob.DragonState)packet.ReadInt(true);
		if (Dragon.Instance)
		{
			Dragon.Instance.transform.root.GetComponent<BobMob>().DragonUpdate(state);
		}
	}
}
