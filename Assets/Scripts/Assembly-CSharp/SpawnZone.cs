using UnityEngine;

public class SpawnZone : MonoBehaviour
{
	public int id;
	public float roamDistance;
	public float renderDistance;
	public bool despawn;
	public int entityCap;
	public float respawnTime;
	public float updateRate;
	public LayerMask whatIsGround;
}
