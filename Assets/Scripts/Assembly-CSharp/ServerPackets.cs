using System;

// Token: 0x020000E1 RID: 225
public enum ServerPackets
{
	// Token: 0x0400053C RID: 1340
	welcome = 1,
	// Token: 0x0400053D RID: 1341
	spawnPlayer,
	// Token: 0x0400053E RID: 1342
	playerPosition,
	// Token: 0x0400053F RID: 1343
	playerRotation,
	// Token: 0x04000540 RID: 1344
	playerDisconnect,
	// Token: 0x04000541 RID: 1345
	playerDied,
	// Token: 0x04000542 RID: 1346
	pingPlayer,
	// Token: 0x04000543 RID: 1347
	connectionSuccessful,
	// Token: 0x04000544 RID: 1348
	sendLevel,
	// Token: 0x04000545 RID: 1349
	sendStatus,
	// Token: 0x04000546 RID: 1350
	gameOver,
	// Token: 0x04000547 RID: 1351
	startGame,
	// Token: 0x04000548 RID: 1352
	clock,
	// Token: 0x04000549 RID: 1353
	openDoor,
	// Token: 0x0400054A RID: 1354
	ready,
	// Token: 0x0400054B RID: 1355
	taskProgress,
	// Token: 0x0400054C RID: 1356
	dropItem,
	// Token: 0x0400054D RID: 1357
	pickupItem,
	// Token: 0x0400054E RID: 1358
	weaponInHand,
	// Token: 0x0400054F RID: 1359
	playerHitObject,
	// Token: 0x04000550 RID: 1360
	dropResources,
	// Token: 0x04000551 RID: 1361
	animationUpdate,
	// Token: 0x04000552 RID: 1362
	finalizeBuild,
	// Token: 0x04000553 RID: 1363
	openChest,
	// Token: 0x04000554 RID: 1364
	updateChest,
	// Token: 0x04000555 RID: 1365
	pickupInteract,
	// Token: 0x04000556 RID: 1366
	dropItemAtPosition,
	// Token: 0x04000557 RID: 1367
	playerHit,
	// Token: 0x04000558 RID: 1368
	mobSpawn,
	// Token: 0x04000559 RID: 1369
	mobMove,
	// Token: 0x0400055A RID: 1370
	mobSetDestination,
	// Token: 0x0400055B RID: 1371
	mobAttack,
	// Token: 0x0400055C RID: 1372
	playerDamageMob,
	// Token: 0x0400055D RID: 1373
	shrineCombatStart,
	// Token: 0x0400055E RID: 1374
	dropPowerupAtPosition,
	// Token: 0x0400055F RID: 1375
	MobZoneSpawn,
	// Token: 0x04000560 RID: 1376
	MobZoneToggle,
	// Token: 0x04000561 RID: 1377
	PickupZoneSpawn,
	// Token: 0x04000562 RID: 1378
	SendMessage,
	// Token: 0x04000563 RID: 1379
	playerPing,
	// Token: 0x04000564 RID: 1380
	sendArmor,
	// Token: 0x04000565 RID: 1381
	playerHp,
	// Token: 0x04000566 RID: 1382
	respawnPlayer,
	// Token: 0x04000567 RID: 1383
	shootArrow,
	// Token: 0x04000568 RID: 1384
	removeResource,
	// Token: 0x04000569 RID: 1385
	mobProjectile,
	// Token: 0x0400056A RID: 1386
	newDay,
	// Token: 0x0400056B RID: 1387
	knockbackMob,
	// Token: 0x0400056C RID: 1388
	spawnEffect,
	// Token: 0x0400056D RID: 1389
	playerFinishedLoading,
	// Token: 0x0400056E RID: 1390
	revivePlayer,
	// Token: 0x0400056F RID: 1391
	spawnGrave,
	// Token: 0x04000570 RID: 1392
	interact,
	// Token: 0x04000571 RID: 1393
	setTarget
}
