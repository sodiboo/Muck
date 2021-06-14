using System;

// Token: 0x020000E2 RID: 226
public enum ClientPackets
{
	// Token: 0x04000573 RID: 1395
	welcomeReceived = 1,
	// Token: 0x04000574 RID: 1396
	joinLobby,
	// Token: 0x04000575 RID: 1397
	playerPosition,
	// Token: 0x04000576 RID: 1398
	playerRotation,
	// Token: 0x04000577 RID: 1399
	sendDisconnect,
	// Token: 0x04000578 RID: 1400
	sendPing,
	// Token: 0x04000579 RID: 1401
	playerKilled,
	// Token: 0x0400057A RID: 1402
	ready,
	// Token: 0x0400057B RID: 1403
	requestSpawns,
	// Token: 0x0400057C RID: 1404
	dropItem,
	// Token: 0x0400057D RID: 1405
	dropItemAtPosition,
	// Token: 0x0400057E RID: 1406
	pickupItem,
	// Token: 0x0400057F RID: 1407
	weaponInHand,
	// Token: 0x04000580 RID: 1408
	playerHitObject,
	// Token: 0x04000581 RID: 1409
	animationUpdate,
	// Token: 0x04000582 RID: 1410
	requestBuild,
	// Token: 0x04000583 RID: 1411
	requestChest,
	// Token: 0x04000584 RID: 1412
	updateChest,
	// Token: 0x04000585 RID: 1413
	pickupInteract,
	// Token: 0x04000586 RID: 1414
	playerHit,
	// Token: 0x04000587 RID: 1415
	playerDamageMob,
	// Token: 0x04000588 RID: 1416
	shrineCombatStart,
	// Token: 0x04000589 RID: 1417
	sendChatMessage,
	// Token: 0x0400058A RID: 1418
	playerPing,
	// Token: 0x0400058B RID: 1419
	sendArmor,
	// Token: 0x0400058C RID: 1420
	playerHp,
	// Token: 0x0400058D RID: 1421
	playerDied,
	// Token: 0x0400058E RID: 1422
	shootArrow,
	// Token: 0x0400058F RID: 1423
	finishedLoading,
	// Token: 0x04000590 RID: 1424
	spawnEffect,
	// Token: 0x04000591 RID: 1425
	reviveRequest,
	// Token: 0x04000592 RID: 1426
	interact,
	// Token: 0x04000593 RID: 1427
	startedLoading
}
