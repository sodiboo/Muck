using System;
using UnityEngine;

public class GenerateBoat : MonoBehaviour
{
	private void Awake()
	{
		this.mapWidth = MapGenerator.mapChunkSize;
		this.mapHeight = MapGenerator.mapChunkSize;
		this.worldScale = (float)MapGenerator.worldScale;
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
		int num = 0;
		while (this.randomPos == Vector3.zero)
		{
			this.randomPos = this.FindRandomPointAroundWorld();
			num++;
			if (num > 10000)
			{
				break;
			}
		}
		Instantiate<GameObject>(this.boatPrefab, this.randomPos, this.boatPrefab.transform.rotation).GetComponent<Boat>().waterHeight = this.waterHeight;
	}

	private Vector3 FindRandomPointAroundWorld()
	{
		float x = (float)(this.randomGen.NextDouble() - 0.5);
		float z = (float)(this.randomGen.NextDouble() - 0.5);
		this.waterHeight = 6f;
		Vector3 vector = new Vector3(x, 0f, z).normalized * this.worldScale * ((float)this.mapWidth / 2f);
		RaycastHit raycastHit;
		if (!Physics.Raycast(new Vector3(vector.x, 200f, vector.z), Vector3.down, out raycastHit, 1000f, this.whatIsWater))
		{
			return Vector3.zero;
		}
		this.waterHeight = raycastHit.point.y;
		vector.y = this.waterHeight;
		Vector3 normalized = VectorExtensions.XZVector(Vector3.zero - vector).normalized;
		vector += Vector3.up;
		RaycastHit raycastHit2;
		if (Physics.Raycast(vector, normalized, out raycastHit2, 5000f, this.whatIsLand))
		{
			return raycastHit2.point;
		}
		return Vector3.zero;
	}

	private void OnDrawGizmos()
	{
	}

	public int mapWidth;

	public int mapHeight;

	public float worldScale;

	public LayerMask whatIsWater;

	public LayerMask whatIsLand;

	private Vector3 randomPos;

	private ConsistentRandom randomGen;

	public GameObject boatPrefab;

	private float waterHeight;

	public int seed;
}
