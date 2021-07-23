using System.Collections.Generic;
using UnityEngine;

public class GenerateCamp : MonoBehaviour
{
    public GameObject zonePrefab;

    public MobType mobType;

    private MobZone zone;

    private float campRadius = 80f;

    private int min = 6;

    private int max = 10;

    private bool rolesAssigned;

    private ConsistentRandom rand;

    public LayerMask whatIsGround;

    public GameObject chiefChest;

    public GameObject hut;

    public GameObject barrel;

    public GameObject log;

    public GameObject logPile;

    public GameObject rockPile;

    public GameObject fireplace;

    public StructureSpawner houseSpawner;

    public bool testing;

    private void Awake()
    {
    }

    private void GenerateZone(ConsistentRandom rand)
    {
        zone = base.gameObject.AddComponent<MobZone>();
        zone.mobType = mobType;
        zone.respawnTime = -1f;
        zone.roamDistance = campRadius;
        zone.renderDistance = campRadius * 3f;
        zone.entityCap = rand.Next(min, max);
        zone.whatIsGround = whatIsGround;
        int nextId = MobZoneManager.Instance.GetNextId();
        zone.SetId(nextId);
        MobZoneManager.Instance.AddZone(zone, nextId);
    }

    public void MakeCamp(ConsistentRandom rand)
    {
        this.rand = rand;
        GenerateZone(rand);
        GenerateStructures(rand);
    }

    private void GenerateStructures(ConsistentRandom rand)
    {
        int num = 1;
        int num2 = rand.Next(2, 4);
        int amount = rand.Next(2, 3);
        int num3 = rand.Next(2, 4);
        int num4 = rand.Next(2, 7);
        int num5 = rand.Next(2, 8);
        int num6 = rand.Next(2, 5);
        int num7 = rand.Next(2, 5);
        List<GameObject> list = SpawnObjects(chiefChest, num, rand);
        foreach (GameObject item in list)
        {
            item.GetComponentInChildren<ChiefChestInteract>().mobZoneId = zone.id;
        }
        Debug.Log($"spawned {list.Count} / {num}");
        List<GameObject> list2 = SpawnObjects(hut, num2, rand);
        foreach (GameObject item2 in list2)
        {
            item2.GetComponent<SpawnChestsInLocations>().SetChests(rand);
        }
        Debug.Log($"spawned {list2.Count} / {num2}");
        Debug.Log($"spawned {SpawnObjects(fireplace, num3, rand).Count} / {num3}");
        Debug.Log($"spawned {SpawnObjects(barrel, num4, rand).Count} / {num4}");
        Debug.Log($"spawned {SpawnObjects(log, num5, rand).Count} / {num5}");
        Debug.Log($"spawned {SpawnObjects(logPile, num6, rand).Count} / {num6}");
        Debug.Log($"spawned {SpawnObjects(rockPile, num7, rand).Count} / {num7}");
        SpawnObjects(houseSpawner, amount, rand);
    }

    private List<GameObject> SpawnObjects(GameObject obj, int amount, ConsistentRandom rand)
    {
        if (obj == null)
        {
            return new List<GameObject>();
        }
        List<GameObject> list = new List<GameObject>();
        for (int i = 0; i < amount; i++)
        {
            RaycastHit raycastHit = FindPos(rand);
            if (!(raycastHit.collider == null))
            {
                GameObject gameObject = Object.Instantiate(obj, raycastHit.point, Quaternion.LookRotation(raycastHit.normal));
                gameObject.transform.Rotate(gameObject.transform.right, 90f, Space.World);
                Hitable component = gameObject.GetComponent<Hitable>();
                if ((bool)component)
                {
                    int nextId = ResourceManager.Instance.GetNextId();
                    component.SetId(nextId);
                    ResourceManager.Instance.AddObject(nextId, gameObject);
                }
                list.Add(gameObject);
            }
        }
        return list;
    }

    private List<GameObject> SpawnObjects(StructureSpawner houses, int amount, ConsistentRandom rand)
    {
        List<GameObject> list = new List<GameObject>();
        houses.CalculateWeight();
        for (int i = 0; i < amount; i++)
        {
            GameObject original = houses.FindObjectToSpawn(houses.structurePrefabs, houses.totalWeight, rand);
            RaycastHit raycastHit = FindPos(rand);
            if (!(raycastHit.collider == null))
            {
                GameObject gameObject = Object.Instantiate(original, raycastHit.point, Quaternion.LookRotation(raycastHit.normal));
                int nextId = ResourceManager.Instance.GetNextId();
                gameObject.GetComponent<Hitable>().SetId(nextId);
                ResourceManager.Instance.AddObject(nextId, gameObject);
                SpawnChestsInLocations componentInChildren = gameObject.GetComponentInChildren<SpawnChestsInLocations>();
                if ((bool)componentInChildren)
                {
                    componentInChildren.SetChests(rand);
                }
                SpawnPowerupsInLocations componentInChildren2 = gameObject.GetComponentInChildren<SpawnPowerupsInLocations>();
                if ((bool)componentInChildren2)
                {
                    componentInChildren2.SetChests(rand);
                }
                Hitable component = gameObject.GetComponent<Hitable>();
                if ((bool)component)
                {
                    int nextId2 = ResourceManager.Instance.GetNextId();
                    component.SetId(nextId2);
                    ResourceManager.Instance.AddObject(nextId2, gameObject);
                }
                list.Add(gameObject);
            }
        }
        return list;
    }

    private RaycastHit FindPos(ConsistentRandom rand)
    {
        RaycastHit hitInfo = default(RaycastHit);
        Vector3 vector = base.transform.position + Vector3.up * 200f;
        Vector3 vector2 = RandomSpherePos(rand) * campRadius;
        if (Physics.SphereCast(vector + vector2, 1f, Vector3.down, out hitInfo, 400f, whatIsGround))
        {
            if (hitInfo.collider.CompareTag("Camp"))
            {
                hitInfo = default(RaycastHit);
            }
            if (WorldUtility.WorldHeightToBiome(hitInfo.point.y) == TextureData.TerrainType.Water)
            {
                hitInfo = default(RaycastHit);
            }
        }
        return hitInfo;
    }

    private Vector3 RandomSpherePos(ConsistentRandom rand)
    {
        float x = (float)rand.NextDouble() * 2f - 1f;
        float y = (float)rand.NextDouble() * 2f - 1f;
        float z = (float)rand.NextDouble() * 2f - 1f;
        return new Vector3(x, y, z).normalized;
    }

    public void AssignRoles()
    {
        if (rolesAssigned)
        {
            return;
        }
        rolesAssigned = true;
        List<GameObject> entities = zone.entities;
        int num = rand.Next(1, min);
        int num2 = 0;
        foreach (GameObject item in entities)
        {
            item.GetComponent<WoodmanBehaviour>().AssignRole(rand);
            num2++;
            if (num2 >= num)
            {
                break;
            }
        }
        foreach (GameObject item2 in entities)
        {
            item2.GetComponent<hahahayes>().Randomize(rand);
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(base.transform.position, campRadius);
    }
}
