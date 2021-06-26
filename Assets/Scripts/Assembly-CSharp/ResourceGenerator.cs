using UnityEngine;

public class ResourceGenerator : MonoBehaviour
{
	public enum SpawnType
	{
		Static = 0,
		Pickup = 1,
	}

	public DrawChunks drawChunks;
	public StructureSpawner.WeightedSpawn[] resourcePrefabs;
	public MapGenerator mapGenerator;
	public float spawnThreshold;
	public AnimationCurve noiseDistribution;
	public AnimationCurve heightDistribution;
	public NoiseData noiseData;
	public Vector3 randomRotation;
	public Vector2 randomScale;
	public int randPos;
	public int forceSeedOffset;
	public float minSpawnHeight;
	public float maxSpawnHeight;
	public int width;
	public int height;
	public bool useFalloffMap;
	public int minSpawnAmount;
	public SpawnType type;
}
