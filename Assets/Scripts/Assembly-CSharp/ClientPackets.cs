using System;

// Token: 0x020000CF RID: 207
public enum ClientPackets
{
	// Token: 0x04000593 RID: 1427
	welcomeReceived = 1,
	// Token: 0x04000594 RID: 1428
	joinLobby,
	// Token: 0x04000595 RID: 1429
	playerPosition,
	// Token: 0x04000596 RID: 1430
	playerRotation,
	// Token: 0x04000597 RID: 1431
	sendDisconnect,
	// Token: 0x04000598 RID: 1432
	sendPing,
	// Token: 0x04000599 RID: 1433
	playerKilled,
	// Token: 0x0400059A RID: 1434
	ready,
	// Token: 0x0400059B RID: 1435
	requestSpawns,
	// Token: 0x0400059C RID: 1436
	dropItem,
	// Token: 0x0400059D RID: 1437
	dropItemAtPosition,
	// Token: 0x0400059E RID: 1438
	pickupItem,
	// Token: 0x0400059F RID: 1439
	weaponInHand,
	// Token: 0x040005A0 RID: 1440
	playerHitObject,
	// Token: 0x040005A1 RID: 1441
	animationUpdate,
	// Token: 0x040005A2 RID: 1442
	requestBuild,
	// Token: 0x040005A3 RID: 1443
	requestChest,
	// Token: 0x040005A4 RID: 1444
	updateChest,
	// Token: 0x040005A5 RID: 1445
	pickupInteract,
	// Token: 0x040005A6 RID: 1446
	playerHit,
	// Token: 0x040005A7 RID: 1447
	playerDamageMob,
	// Token: 0x040005A8 RID: 1448
	shrineCombatStart,
	// Token: 0x040005A9 RID: 1449
	sendChatMessage,
	// Token: 0x040005AA RID: 1450
	playerPing,
	// Token: 0x040005AB RID: 1451
	sendArmor,
	// Token: 0x040005AC RID: 1452
	playerHp,
	// Token: 0x040005AD RID: 1453
	playerDied,
	// Token: 0x040005AE RID: 1454
	shootArrow,
	// Token: 0x040005AF RID: 1455
	finishedLoading,
	// Token: 0x040005B0 RID: 1456
	spawnEffect,
	// Token: 0x040005B1 RID: 1457
	reviveRequest,
	// Token: 0x040005B2 RID: 1458
	interact,
	// Token: 0x040005B3 RID: 1459
	startedLoading,
	// Token: 0x040005B4 RID: 1460
	shipUpdate
}
