using UnityEngine;

public class SpawnZoneGenerator<T> : MonoBehaviour
{
	public GameObject spawnZone;
	public int nZones;
	public LayerMask whatIsTerrain;
	public int seedOffset;
	public T[] entities;
	public float[] weights;
}
