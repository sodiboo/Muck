using UnityEngine;

public class GenerateBoat : MonoBehaviour
{
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

    private void Awake()
    {
        mapWidth = MapGenerator.mapChunkSize;
        mapHeight = MapGenerator.mapChunkSize;
        worldScale = MapGenerator.worldScale;
        randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
        int num = 0;
        while (randomPos == Vector3.zero)
        {
            randomPos = FindRandomPointAroundWorld();
            num++;
            if (num > 10000)
            {
                break;
            }
        }
        Object.Instantiate(boatPrefab, randomPos, boatPrefab.transform.rotation).GetComponent<Boat>().waterHeight = waterHeight;
    }

    private Vector3 FindRandomPointAroundWorld()
    {
        float x = (float)(randomGen.NextDouble() - 0.5);
        float z = (float)(randomGen.NextDouble() - 0.5);
        waterHeight = 6f;
        Vector3 vector = new Vector3(x, 0f, z).normalized * worldScale * ((float)mapWidth / 2f);
        if (Physics.Raycast(new Vector3(vector.x, 200f, vector.z), Vector3.down, out var hitInfo, 1000f, whatIsWater))
        {
            waterHeight = hitInfo.point.y;
            vector.y = waterHeight;
            Vector3 normalized = VectorExtensions.XZVector(Vector3.zero - vector).normalized;
            vector += Vector3.up;
            if (Physics.Raycast(vector, normalized, out var hitInfo2, 5000f, whatIsLand))
            {
                return hitInfo2.point;
            }
            return Vector3.zero;
        }
        return Vector3.zero;
    }

    private void OnDrawGizmos()
    {
    }
}
