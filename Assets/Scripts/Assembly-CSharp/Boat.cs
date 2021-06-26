using UnityEngine;
using System.Collections.Generic;

public class Boat : MonoBehaviour
{
	public enum BoatStatus
	{
		Hidden = 0,
		Marked = 1,
		Found = 2,
		LeftIsland = 3,
	}

	public BoatStatus status;
	public InventoryItem mapItem;
	public InventoryItem gemMap;
	public GameObject objectivePing;
	public ObjectivePing boatPing;
	public SpawnChestsInLocations chestSpawner;
	public GameObject[] holes;
	public Texture gemTexture;
	public Texture boatTexture;
	public List<ShrineGuardian> guardians;
	public CountPlayersOnBoat countPlayers;
	public Transform dragonSpawnPos;
	public Camera cinematicCamera;
	public MobType dragonBoss;
	public Transform rbTransform;
	public GameObject waterSfx;
	public Transform dragonLandingPosition;
	public Transform[] landingNodes;
	public GameObject wheel;
	public ObjectivePing wheelPing;
}
