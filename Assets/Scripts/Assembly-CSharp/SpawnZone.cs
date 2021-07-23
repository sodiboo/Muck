using UnityEngine;
using System.Collections.Generic;

public class SpawnZone : MonoBehaviour
{
	public int id;
	public List<GameObject> entities;
	public float roamDistance;
	public float renderDistance;
	public bool despawn;
	public int entityCap;
	public float respawnTime;
	public float updateRate;
	public LayerMask whatIsGround;
}
