﻿public enum ServerPackets
{
    welcome = 1,
    spawnPlayer,
    playerPosition,
    playerRotation,
    playerDisconnect,
    playerDied,
    pingPlayer,
    connectionSuccessful,
    sendLevel,
    sendStatus,
    gameOver,
    startGame,
    clock,
    openDoor,
    ready,
    taskProgress,
    dropItem,
    pickupItem,
    weaponInHand,
    playerHitObject,
    dropResources,
    animationUpdate,
    finalizeBuild,
    openChest,
    updateChest,
    pickupInteract,
    dropItemAtPosition,
    playerHit,
    mobSpawn,
    mobMove,
    mobSetDestination,
    mobAttack,
    playerDamageMob,
    shrineCombatStart,
    dropPowerupAtPosition,
    MobZoneSpawn,
    MobZoneToggle,
    PickupZoneSpawn,
    SendMessage,
    playerPing,
    sendArmor,
    playerHp,
    respawnPlayer,
    shootArrow,
    removeResource,
    mobProjectile,
    newDay,
    knockbackMob,
    spawnEffect,
    playerFinishedLoading,
    revivePlayer,
    spawnGrave,
	interact,
	setTarget,

    _vehicleOffset = 2360,
    moveVehicle,
    enterVehicle,
    exitVehicle,
}
