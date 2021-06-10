using System;
using System.Net;
using UnityEngine;

// Token: 0x0200008F RID: 143
public class ClientHandle : MonoBehaviour
{
	// Token: 0x060003E0 RID: 992 RVA: 0x00013A74 File Offset: 0x00011C74
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

	// Token: 0x060003E1 RID: 993 RVA: 0x00013B10 File Offset: 0x00011D10
	public static void Clock(Packet packet)
	{
		int num = packet.ReadInt(true);
		LoadingScreen.Instance.players[num] = true;
	}

	// Token: 0x060003E2 RID: 994 RVA: 0x00013B32 File Offset: 0x00011D32
	public static void PlayerFinishedLoading(Packet packet)
	{
		LoadingScreen.Instance.UpdateStatuses(packet.ReadInt(true));
	}

	// Token: 0x060003E3 RID: 995 RVA: 0x00013B48 File Offset: 0x00011D48
	public static void DropItem(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		ItemManager.Instance.DropItem(fromClient, itemId, amount, objectID);
	}

	// Token: 0x060003E4 RID: 996 RVA: 0x00013B84 File Offset: 0x00011D84
	public static void DropItemAtPosition(Packet packet)
	{
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropItemAtPosition(itemId, amount, pos, objectID);
	}

	// Token: 0x060003E5 RID: 997 RVA: 0x00013BC0 File Offset: 0x00011DC0
	public static void DropPowerupAtPosition(Packet packet)
	{
		int powerupId = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ItemManager.Instance.DropPowerupAtPosition(powerupId, pos, objectID);
	}

	// Token: 0x060003E6 RID: 998 RVA: 0x00013BF4 File Offset: 0x00011DF4
	public static void DropResources(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int dropTableId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MonoBehaviour.print("CLIENT: Dropping resources with id: " + num);
		ItemManager.Instance.DropResource(fromClient, dropTableId, num);
	}

	// Token: 0x060003E7 RID: 999 RVA: 0x00013C3C File Offset: 0x00011E3C
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

	// Token: 0x060003E8 RID: 1000 RVA: 0x00013CE4 File Offset: 0x00011EE4
	public static void SpawnEffect(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		PowerupCalculations.Instance.SpawnOnHitEffect(id, false, pos, 0);
	}

	// Token: 0x060003E9 RID: 1001 RVA: 0x00013D10 File Offset: 0x00011F10
	public static void WeaponInHand(Packet packet)
	{
		int key = packet.ReadInt(true);
		int objectID = packet.ReadInt(true);
		GameManager.players[key].onlinePlayer.UpdateWeapon(objectID);
	}

	// Token: 0x060003EA RID: 1002 RVA: 0x00013D44 File Offset: 0x00011F44
	public static void AnimationUpdate(Packet packet)
	{
		int key = packet.ReadInt(true);
		int animation = packet.ReadInt(true);
		bool b = packet.ReadBool(true);
		GameManager.players[key].onlinePlayer.NewAnimation(animation, b);
	}

	// Token: 0x060003EB RID: 1003 RVA: 0x00013D80 File Offset: 0x00011F80
	public static void ShootArrowFromPlayer(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int arrowId = packet.ReadInt(true);
		int fromPlayer = packet.ReadInt(true);
		ProjectileController.Instance.SpawnProjectileFromPlayer(spawnPos, direction, force, arrowId, fromPlayer);
	}

	// Token: 0x060003EC RID: 1004 RVA: 0x00013DC8 File Offset: 0x00011FC8
	public static void PlayerHitObject(Packet packet)
	{
		int fromClient = packet.ReadInt(true);
		int key = packet.ReadInt(true);
		int newHp = packet.ReadInt(true);
		int hitEffect = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		ResourceManager.Instance.list[key].GetComponent<Hitable>().Damage(newHp, fromClient, hitEffect, pos);
	}

	// Token: 0x060003ED RID: 1005 RVA: 0x00013E20 File Offset: 0x00012020
	public static void RemoveResource(Packet packet)
	{
		int id = packet.ReadInt(true);
		ResourceManager.Instance.RemoveItem(id);
	}

	// Token: 0x060003EE RID: 1006 RVA: 0x00013E40 File Offset: 0x00012040
	public static void PlayerHp(Packet packet)
	{
		int key = packet.ReadInt(true);
		float hpRatio = packet.ReadFloat(true);
		GameManager.players[key].SetHpRatio(hpRatio);
	}

	// Token: 0x060003EF RID: 1007 RVA: 0x00013E70 File Offset: 0x00012070
	public static void RespawnPlayer(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 zero = packet.ReadVector3(true);
		GameManager.instance.RespawnPlayer(id, zero);
	}

	// Token: 0x060003F0 RID: 1008 RVA: 0x00013E9C File Offset: 0x0001209C
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
			PlayerStatus.Instance.DealDamage(num2);
		}
		else
		{
			playerManager.SetHpRatio(num3);
		}
		playerManager.hitable.Damage(num2, num, hitEffect, pos);
	}

	// Token: 0x060003F1 RID: 1009 RVA: 0x00013F74 File Offset: 0x00012174
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

	// Token: 0x060003F2 RID: 1010 RVA: 0x00013FC8 File Offset: 0x000121C8
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

	// Token: 0x060003F3 RID: 1011 RVA: 0x0001409C File Offset: 0x0001229C
	public static void UpdateChest(Packet packet)
	{
		packet.ReadInt(true);
		int chestId = packet.ReadInt(true);
		int cellId = packet.ReadInt(true);
		int itemId = packet.ReadInt(true);
		int amount = packet.ReadInt(true);
		ChestManager.Instance.UpdateChest(chestId, cellId, itemId, amount);
	}

	// Token: 0x060003F4 RID: 1012 RVA: 0x000140E0 File Offset: 0x000122E0
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

	// Token: 0x060003F5 RID: 1013 RVA: 0x0001415C File Offset: 0x0001235C
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

	// Token: 0x060003F6 RID: 1014 RVA: 0x000141C4 File Offset: 0x000123C4
	public static void StartGame(Packet packet)
	{
		LocalClient.instance.myId = packet.ReadInt(true);
		int seed = packet.ReadInt(true);
		int gameMode = packet.ReadInt(true);
		int friendlyFire = packet.ReadInt(true);
		int difficulty = packet.ReadInt(true);
		int gameLength = packet.ReadInt(true);
		GameManager.gameSettings = new GameSettings(seed, gameMode, friendlyFire, difficulty, gameLength);
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
	}

	// Token: 0x060003F7 RID: 1015 RVA: 0x00014288 File Offset: 0x00012488
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

	// Token: 0x060003F8 RID: 1016 RVA: 0x000142C4 File Offset: 0x000124C4
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

	// Token: 0x060003F9 RID: 1017 RVA: 0x0001430C File Offset: 0x0001250C
	public static void ReceivePing(Packet packet)
	{
		packet.ReadInt(true);
		DateTime d = DateTime.Parse(packet.ReadString(true));
		NetStatus.AddPing((int)(DateTime.Now - d).TotalMilliseconds);
	}

	// Token: 0x060003FA RID: 1018 RVA: 0x00014347 File Offset: 0x00012547
	public static void ReceiveStatus(Packet packet)
	{
		MonoBehaviour.print("received status");
	}

	// Token: 0x060003FB RID: 1019 RVA: 0x00014353 File Offset: 0x00012553
	public static void ConnectionEstablished(Packet packet)
	{
		MonoBehaviour.print("connection has successfully been established. ready to enter game");
		GameManager.connected = true;
	}

	// Token: 0x060003FC RID: 1020 RVA: 0x00014365 File Offset: 0x00012565
	public static void OpenDoor(Packet packet)
	{
		packet.ReadInt(true);
	}

	// Token: 0x060003FD RID: 1021 RVA: 0x00014370 File Offset: 0x00012570
	public static void PlayerDied(Packet packet)
	{
		int id = packet.ReadInt(true);
		Vector3 pos = packet.ReadVector3(true);
		GameManager.instance.KillPlayer(id, pos);
	}

	// Token: 0x060003FE RID: 1022 RVA: 0x0001439C File Offset: 0x0001259C
	public static void SpawnGrave(Packet packet)
	{
		int playerId = packet.ReadInt(true);
		int graveObjectId = packet.ReadInt(true);
		Vector3 gravePos = packet.ReadVector3(true);
		GameManager.instance.SpawnGrave(gravePos, playerId, graveObjectId);
	}

	// Token: 0x060003FF RID: 1023 RVA: 0x000143CE File Offset: 0x000125CE
	public static void Ready(Packet packet)
	{
		packet.ReadInt(true);
		packet.ReadBool(true);
	}

	// Token: 0x06000400 RID: 1024 RVA: 0x000143E0 File Offset: 0x000125E0
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

	// Token: 0x06000401 RID: 1025 RVA: 0x00014430 File Offset: 0x00012630
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

	// Token: 0x06000402 RID: 1026 RVA: 0x000144AC File Offset: 0x000126AC
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

	// Token: 0x06000403 RID: 1027 RVA: 0x00014568 File Offset: 0x00012768
	public static void MobSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int mobType = packet.ReadInt(true);
		int mobId = packet.ReadInt(true);
		float multiplier = packet.ReadFloat(true);
		float bossMultiplier = packet.ReadFloat(true);
		MobSpawner.Instance.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier);
	}

	// Token: 0x06000404 RID: 1028 RVA: 0x000145B0 File Offset: 0x000127B0
	public static void MobMove(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 position = packet.ReadVector3(true);
		if (MobManager.Instance.mobs[key])
		{
			MobManager.Instance.mobs[key].SetPosition(position);
		}
	}

	// Token: 0x06000405 RID: 1029 RVA: 0x000145FC File Offset: 0x000127FC
	public static void MobSetDestination(Packet packet)
	{
		int key = packet.ReadInt(true);
		Vector3 destination = packet.ReadVector3(true);
		MobManager.Instance.mobs[key].SetDestination(destination);
	}

	// Token: 0x06000406 RID: 1030 RVA: 0x00014630 File Offset: 0x00012830
	public static void MobAttack(Packet packet)
	{
		int key = packet.ReadInt(true);
		int targetPlayerId = packet.ReadInt(true);
		int attackAnimationIndex = packet.ReadInt(true);
		MobManager.Instance.mobs[key].Attack(targetPlayerId, attackAnimationIndex);
	}

	// Token: 0x06000407 RID: 1031 RVA: 0x0001466C File Offset: 0x0001286C
	public static void MobSpawnProjectile(Packet packet)
	{
		Vector3 spawnPos = packet.ReadVector3(true);
		Vector3 direction = packet.ReadVector3(true);
		float force = packet.ReadFloat(true);
		int itemId = packet.ReadInt(true);
		int mobObjectId = packet.ReadInt(true);
		ProjectileController.Instance.SpawnMobProjectile(spawnPos, direction, force, itemId, mobObjectId);
	}

	// Token: 0x06000408 RID: 1032 RVA: 0x000146B4 File Offset: 0x000128B4
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

	// Token: 0x06000409 RID: 1033 RVA: 0x00014728 File Offset: 0x00012928
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

	// Token: 0x0600040A RID: 1034 RVA: 0x00014770 File Offset: 0x00012970
	public static void MobZoneToggle(Packet packet)
	{
		bool show = packet.ReadBool(true);
		int key = packet.ReadInt(true);
		MobZoneManager.Instance.zones[key].ToggleEntities(show);
	}

	// Token: 0x0600040B RID: 1035 RVA: 0x000147A4 File Offset: 0x000129A4
	public static void MobZoneSpawn(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x0600040C RID: 1036 RVA: 0x000147EC File Offset: 0x000129EC
	public static void PickupSpawnZone(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		int entityType = packet.ReadInt(true);
		int objectId = packet.ReadInt(true);
		int num = packet.ReadInt(true);
		MobZoneManager.Instance.zones[num].LocalSpawnEntity(pos, entityType, objectId, num);
	}

	// Token: 0x0600040D RID: 1037 RVA: 0x00014834 File Offset: 0x00012A34
	public static void ReceiveChatMessage(Packet packet)
	{
		int fromUser = packet.ReadInt(true);
		string fromUsername = packet.ReadString(true);
		string message = packet.ReadString(true);
		ChatBox.Instance.AppendMessage(fromUser, message, fromUsername);
	}

	// Token: 0x0600040E RID: 1038 RVA: 0x00014868 File Offset: 0x00012A68
	public static void ReceivePlayerPing(Packet packet)
	{
		Vector3 pos = packet.ReadVector3(true);
		string name = packet.ReadString(true);
		PingController.Instance.MakePing(pos, name, "");
	}

	// Token: 0x0600040F RID: 1039 RVA: 0x00014898 File Offset: 0x00012A98
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

	// Token: 0x06000410 RID: 1040 RVA: 0x00014904 File Offset: 0x00012B04
	public static void NewDay(Packet packet)
	{
		int day = packet.ReadInt(true);
		GameManager.instance.UpdateDay(day);
		DayCycle.time = 0f;
	}

	// Token: 0x06000411 RID: 1041 RVA: 0x00014930 File Offset: 0x00012B30
	public static void GameOver(Packet packet)
	{
		int winnerId = packet.ReadInt(true);
		GameManager.instance.GameOver(winnerId);
	}
}
