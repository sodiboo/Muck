using UnityEngine;

public class BuildManager : MonoBehaviour
{
    public int gridSize = 2;

    private int gridWidth = 10;

    public LayerMask whatIsGround;

    private Transform playerCam;

    private InventoryItem currentItem;

    public GameObject buildFx;

    public GameObject ghostItem;

    private Renderer renderer;

    private MeshFilter filter;

    public int yRotation;

    public GameObject rotateText;

    public static BuildManager Instance;

    private Vector3 lastPosition;

    private bool canBuild;

    private Vector3[] ghostExtents;

    private Collider ghostCollider;

    private string debugInfo;

    private int rotationAngle = 45;

    private int id;

    private void Awake()
    {
        Instance = this;
        filter = ghostItem.GetComponent<MeshFilter>();
        renderer = ghostItem.GetComponent<Renderer>();
    }

    private void SetNewItem()
    {
        filter.mesh = currentItem.mesh;
        Material material = renderer.material;
        material.mainTexture = currentItem.material.mainTexture;
        renderer.material = material;
        Object.Destroy(ghostItem.GetComponent<BoxCollider>());
        ghostCollider = ghostItem.AddComponent<BoxCollider>();
        BuildSnappingInfo component = currentItem.prefab.GetComponent<BuildSnappingInfo>();
        if ((bool)component)
        {
            ghostExtents = component.position;
        }
        else
        {
            ghostExtents = new Vector3[0];
        }
        ghostItem.transform.localScale = Vector3.one * gridSize;
        if (!currentItem.grid)
        {
            ghostItem.transform.localScale = Vector3.one;
        }
    }

    private void Update()
    {
        NewestBuild();
    }

    private void NewestBuild()
    {
        debugInfo = "";
        if (!currentItem || currentItem != Hotbar.Instance.currentItem)
        {
            currentItem = Hotbar.Instance.currentItem;
            if (!currentItem || !canBuild)
            {
                if (ghostItem.activeInHierarchy)
                {
                    ghostItem.SetActive(value: false);
                    rotateText.SetActive(value: false);
                }
                return;
            }
        }
        if (!currentItem.buildable)
        {
            ghostItem.SetActive(value: false);
            rotateText.SetActive(value: false);
            canBuild = false;
            return;
        }
        if (!playerCam)
        {
            if (!PlayerMovement.Instance)
            {
                return;
            }
            playerCam = PlayerMovement.Instance.playerCam;
        }
        if (!ghostItem.activeInHierarchy)
        {
            ghostItem.SetActive(value: true);
            rotateText.SetActive(value: true);
        }
        SetNewItem();
        Vector3 extents = filter.mesh.bounds.extents;
        if (currentItem.grid)
        {
            extents *= (float)gridSize;
        }
        ghostItem.transform.rotation = Quaternion.Euler(0f, yRotation, 0f);
        if (Physics.Raycast(new Ray(playerCam.position, playerCam.forward), out var hitInfo, 12f, whatIsGround))
        {
            if (hitInfo.collider.CompareTag("Ignore"))
            {
                canBuild = false;
                ghostItem.SetActive(value: false);
                return;
            }
            Vector3 position = hitInfo.point + Vector3.up * (extents.y - filter.mesh.bounds.center.y);
            _ = filter.mesh.bounds.center;
            BuildSnappingInfo component = hitInfo.collider.GetComponent<BuildSnappingInfo>();
            if (hitInfo.collider.gameObject.CompareTag("Build") && currentItem.grid && component != null)
            {
                position = hitInfo.point;
                float num = 3f;
                float num2 = float.PositiveInfinity;
                Vector3 vector = Vector3.zero;
                Vector3[] position2 = component.position;
                foreach (Vector3 vector2 in position2)
                {
                    Vector3 point = hitInfo.collider.transform.position + vector2 * gridSize;
                    point = RotateAroundPivot(point, hitInfo.collider.transform.position, new Vector3(0f, hitInfo.collider.transform.eulerAngles.y, 0f));
                    Vector3 normalized = (point - hitInfo.collider.transform.position).normalized;
                    Vector3 zero = Vector3.zero;
                    if (zero.y > 0f)
                    {
                        zero.y = 1f;
                    }
                    else if (zero.y < 0f)
                    {
                        zero.y = -1f;
                    }
                    normalized = (normalized + hitInfo.normal).normalized * gridSize / 2f;
                    if (!(Vector3.Distance(hitInfo.point, point) < num))
                    {
                        continue;
                    }
                    ghostItem.transform.position = point;
                    Vector3[] array = ghostExtents;
                    foreach (Vector3 vector3 in array)
                    {
                        Vector3 point2 = ghostItem.transform.position + vector3 * gridSize;
                        point2 = RotateAroundPivot(point2, ghostCollider.transform.position, new Vector3(0f, yRotation, 0f));
                        float num3 = Vector3.Distance(point2 - normalized, point);
                        if (num3 < num2)
                        {
                            num2 = num3;
                            vector = point2 - ghostItem.transform.position;
                            position = point;
                        }
                    }
                }
                position += vector;
            }
            canBuild = true;
            lastPosition = position;
            ghostItem.transform.position = position;
        }
        else
        {
            ghostItem.SetActive(value: false);
            canBuild = false;
        }
    }

    private void OnDrawGizmos()
    {
        if (ghostExtents != null)
        {
            Vector3[] array = ghostExtents;
            foreach (Vector3 vector in array)
            {
                Gizmos.color = Color.blue;
                Vector3 point = ghostItem.transform.position + vector * gridSize;
                point = RotateAroundPivot(point, ghostCollider.transform.position, new Vector3(0f, yRotation, 0f));
                Gizmos.DrawCube(point, Vector3.one);
            }
        }
    }

    private Vector3 RotateAroundPivot(Vector3 point, Vector3 pivot, Vector3 angles)
    {
        Vector3 vector = point - pivot;
        vector = Quaternion.Euler(angles) * vector;
        point = vector + pivot;
        return point;
    }

    public void RotateBuild(int dir)
    {
        yRotation -= dir * rotationAngle;
    }

    public void RequestBuildItem()
    {
        if (CanBuild() && canBuild)
        {
            Hotbar.Instance.UseItem(1);
            Gun.Instance.Build();
            ClientSend.RequestBuild(currentItem.id, lastPosition, yRotation);
        }
    }

    public bool CanBuild()
    {
        if (!currentItem)
        {
            return false;
        }
        if (!currentItem.buildable)
        {
            return false;
        }
        if (currentItem.amount <= 0)
        {
            return false;
        }
        return true;
    }

    public GameObject BuildItem(int buildOwner, int itemID, int objectId, Vector3 position, int yRotation)
    {
        InventoryItem inventoryItem = ItemManager.Instance.allItems[itemID];
        GameObject gameObject = Object.Instantiate(inventoryItem.prefab);
        gameObject.transform.position = position;
        gameObject.transform.rotation = Quaternion.Euler(0f, yRotation, 0f);
        gameObject.AddComponent<BuildInfo>().ownerId = buildOwner;
        if ((bool)buildFx)
        {
            Object.Instantiate(buildFx, position, Quaternion.identity);
        }
        if (inventoryItem.grid)
        {
            HitableTree component = gameObject.GetComponent<HitableTree>();
            component.SetDefaultScale(Vector3.one * gridSize);
            component.PopIn();
        }
        gameObject.GetComponent<Hitable>().SetId(objectId);
        ResourceManager.Instance.AddObject(objectId, gameObject);
        ResourceManager.Instance.AddBuild(objectId, gameObject);
        BuildDoor component2 = gameObject.GetComponent<BuildDoor>();
        if (component2 != null)
        {
            BuildDoor.Door[] doors = component2.doors;
            foreach (BuildDoor.Door door in doors)
            {
                if (LocalClient.serverOwner)
                {
                    door.SetId(ResourceManager.Instance.GetNextId());
                }
                else
                {
                    door.SetId(objectId++);
                }
            }
        }
        if (inventoryItem.type == InventoryItem.ItemType.Storage)
        {
            Chest componentInChildren = gameObject.GetComponentInChildren<Chest>();
            ChestManager.Instance.AddChest(componentInChildren, objectId);
        }
        if (buildOwner == LocalClient.instance.myId)
        {
            MonoBehaviour.print("i built something");
            if (inventoryItem.type == InventoryItem.ItemType.Station)
            {
                UiEvents.Instance.StationUnlock(itemID);
                if ((bool)Tutorial.Instance && inventoryItem.name == "Workbench")
                {
                    Tutorial.Instance.stationPlaced = true;
                }
            }
        }
        if (buildOwner == LocalClient.instance.myId)
        {
            AchievementManager.Instance.BuildItem(itemID);
        }
        return gameObject;
    }

    public int GetNextBuildId()
    {
        return ResourceManager.Instance.GetNextId();
    }
}
