using System;

// Token: 0x020000CE RID: 206
public enum ServerPackets
{
	// Token: 0x0400055A RID: 1370
	welcome = 1,
	// Token: 0x0400055B RID: 1371
	spawnPlayer,
	// Token: 0x0400055C RID: 1372
	playerPosition,
	// Token: 0x0400055D RID: 1373
	playerRotation,
	// Token: 0x0400055E RID: 1374
	playerDisconnect,
	// Token: 0x0400055F RID: 1375
	playerDied,
	// Token: 0x04000560 RID: 1376
	pingPlayer,
	// Token: 0x04000561 RID: 1377
	connectionSuccessful,
	// Token: 0x04000562 RID: 1378
	sendLevel,
	// Token: 0x04000563 RID: 1379
	sendStatus,
	// Token: 0x04000564 RID: 1380
	gameOver,
	// Token: 0x04000565 RID: 1381
	startGame,
	// Token: 0x04000566 RID: 1382
	clock,
	// Token: 0x04000567 RID: 1383
	openDoor,
	// Token: 0x04000568 RID: 1384
	ready,
	// Token: 0x04000569 RID: 1385
	taskProgress,
	// Token: 0x0400056A RID: 1386
	dropItem,
	// Token: 0x0400056B RID: 1387
	pickupItem,
	// Token: 0x0400056C RID: 1388
	weaponInHand,
	// Token: 0x0400056D RID: 1389
	playerHitObject,
	// Token: 0x0400056E RID: 1390
	dropResources,
	// Token: 0x0400056F RID: 1391
	animationUpdate,
	// Token: 0x04000570 RID: 1392
	finalizeBuild,
	// Token: 0x04000571 RID: 1393
	openChest,
	// Token: 0x04000572 RID: 1394
	updateChest,
	// Token: 0x04000573 RID: 1395
	pickupInteract,
	// Token: 0x04000574 RID: 1396
	dropItemAtPosition,
	// Token: 0x04000575 RID: 1397
	playerHit,
	// Token: 0x04000576 RID: 1398
	mobSpawn,
	// Token: 0x04000577 RID: 1399
	mobMove,
	// Token: 0x04000578 RID: 1400
	mobSetDestination,
	// Token: 0x04000579 RID: 1401
	mobAttack,
	// Token: 0x0400057A RID: 1402
	playerDamageMob,
	// Token: 0x0400057B RID: 1403
	shrineCombatStart,
	// Token: 0x0400057C RID: 1404
	dropPowerupAtPosition,
	// Token: 0x0400057D RID: 1405
	MobZoneSpawn,
	// Token: 0x0400057E RID: 1406
	MobZoneToggle,
	// Token: 0x0400057F RID: 1407
	PickupZoneSpawn,
	// Token: 0x04000580 RID: 1408
	SendMessage,
	// Token: 0x04000581 RID: 1409
	playerPing,
	// Token: 0x04000582 RID: 1410
	sendArmor,
	// Token: 0x04000583 RID: 1411
	playerHp,
	// Token: 0x04000584 RID: 1412
	respawnPlayer,
	// Token: 0x04000585 RID: 1413
	shootArrow,
	// Token: 0x04000586 RID: 1414
	removeResource,
	// Token: 0x04000587 RID: 1415
	mobProjectile,
	// Token: 0x04000588 RID: 1416
	newDay,
	// Token: 0x04000589 RID: 1417
	knockbackMob,
	// Token: 0x0400058A RID: 1418
	spawnEffect,
	// Token: 0x0400058B RID: 1419
	playerFinishedLoading,
	// Token: 0x0400058C RID: 1420
	revivePlayer,
	// Token: 0x0400058D RID: 1421
	spawnGrave,
	// Token: 0x0400058E RID: 1422
	interact,
	// Token: 0x0400058F RID: 1423
	setTarget,
	// Token: 0x04000590 RID: 1424
	shipUpdate,
	// Token: 0x04000591 RID: 1425
	dragonUpdate
}
