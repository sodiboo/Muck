using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;


public class BuildManager : MonoBehaviour
{

    private void Awake()
    {
        BuildManager.Instance = this;
        this.filter = this.ghostItem.GetComponent<MeshFilter>();
        this.renderer = this.ghostItem.GetComponent<Renderer>();
    }


    private void SetNewItem(MeshRenderer prefabRenderer)
    {
        this.filter.mesh = this.currentItem.mesh;
        this.renderer.materials = prefabRenderer.sharedMaterials.Select(oldMat =>
        {
            var newMat = new Material(ghostMat);
            newMat.color = new Color(oldMat.color.r, oldMat.color.g, oldMat.color.b, 0.6f);
            newMat.mainTexture = oldMat.mainTexture;
            return newMat;
        }).ToArray();
        Destroy(this.ghostItem.GetComponent<BoxCollider>());
        this.ghostCollider = this.ghostItem.AddComponent<BoxCollider>();
        BuildSnappingInfo component = this.currentItem.prefab.GetComponent<BuildSnappingInfo>();
        if (component)
        {
            this.ghostExtents = component.position;
        }
        else
        {
            this.ghostExtents = new Vector3[0];
        }
        this.ghostItem.transform.localScale = Vector3.one * (float)this.gridSize;
        if (!this.currentItem.grid)
        {
            this.ghostItem.transform.localScale = Vector3.one;
        }
    }


    private void Update()
    {
        this.NewestBuild();
    }


    private void NewestBuild()
    {
        this.debugInfo = "";
        if (!this.currentItem || this.currentItem != Hotbar.Instance.currentItem)
        {
            this.currentItem = Hotbar.Instance.currentItem;
            if (!this.currentItem || !this.canBuild)
            {
                if (this.ghostItem.activeInHierarchy)
                {
                    this.ghostItem.SetActive(false);
                    this.rotateText.SetActive(false);
                }
                return;
            }
        }
        if (!this.currentItem.buildable)
        {
            this.ghostItem.SetActive(false);
            this.rotateText.SetActive(false);
            this.canBuild = false;
            return;
        }
        if (!this.playerCam)
        {
            if (!PlayerMovement.Instance)
            {
                return;
            }
            this.playerCam = PlayerMovement.Instance.playerCam;
        }
        if (!this.ghostItem.activeInHierarchy)
        {
            this.ghostItem.SetActive(true);
            this.rotateText.SetActive(true);
        }
        var prefabRenderer = currentItem.prefab.GetComponentsInChildren<MeshFilter>().First(filter => filter.sharedMesh == currentItem.mesh).GetComponent<MeshRenderer>();
        var prefabTransform = prefabRenderer.transform;
        var transforms = new List<Transform>();
        while (prefabTransform != currentItem.prefab.transform)
        {
            transforms.Add(prefabTransform);
            prefabTransform = prefabTransform.parent;
        }
        transforms.Add(prefabTransform);
        transforms.Reverse();
        var rot = Quaternion.Euler(currentItem.buildRotation);
        var scale = Vector3.one;
        foreach (var transform in transforms)
        {
            rot *= transform.rotation;
            scale.Scale(transform.localScale);
        }
        if (currentItem.type == InventoryItem.ItemType.Car)
        {
            scale *= Car.Scale;
        }
        if (this.currentItem.grid)
        {
            scale *= (float)this.gridSize;
        }
        this.SetNewItem(prefabRenderer);
        var bounds = this.filter.mesh.bounds;
        Vector3 vector = bounds.extents;
        vector.Scale(scale);
        vector = rot * vector;
        this.ghostItem.transform.rotation = Quaternion.Euler(0, (float)this.yRotation, 0) * rot;
        RaycastHit raycastHit;
        if (Physics.Raycast(new Ray(this.playerCam.position, this.playerCam.forward), out raycastHit, 12f, this.whatIsGround))
        {
            Vector3 center = bounds.center;
            center.Scale(scale);
            center = rot * center;
            Vector3 vector2 = raycastHit.point + Vector3.up * (vector.y - center.y);
            vector2 += ghostItem.transform.TransformDirection(new Vector3(currentItem.buildOffset.x, currentItem.buildOffset.z));
            vector2.y += currentItem.buildOffset.y;
            BuildSnappingInfo component = raycastHit.collider.GetComponent<BuildSnappingInfo>();
            if (raycastHit.collider.gameObject.CompareTag("Build") && this.currentItem.grid && component != null)
            {
                vector2 = raycastHit.point;
                float num = 3f;
                float num2 = float.PositiveInfinity;
                Vector3 b = Vector3.zero;
                foreach (Vector3 a in component.position)
                {
                    Vector3 vector3 = raycastHit.collider.transform.position + a * (float)this.gridSize;
                    vector3 = this.RotateAroundPivot(vector3, raycastHit.collider.transform.position, new Vector3(0f, raycastHit.collider.transform.eulerAngles.y, 0f));
                    Vector3 vector4 = (vector3 - raycastHit.collider.transform.position).normalized;
                    Vector3 zero = Vector3.zero;
                    if (zero.y > 0f)
                    {
                        zero.y = 1f;
                    }
                    else if (zero.y < 0f)
                    {
                        zero.y = -1f;
                    }
                    vector4 = (vector4 + raycastHit.normal).normalized * (float)this.gridSize / 2f;
                    if (Vector3.Distance(raycastHit.point, vector3) < num)
                    {
                        this.ghostItem.transform.position = vector3;
                        foreach (Vector3 a2 in this.ghostExtents)
                        {
                            Vector3 vector5 = this.ghostItem.transform.position + a2 * (float)this.gridSize;
                            vector5 = this.RotateAroundPivot(vector5, this.ghostCollider.transform.position, new Vector3(0f, (float)this.yRotation, 0f));
                            float num3 = Vector3.Distance(vector5 - vector4, vector3);
                            if (num3 < num2)
                            {
                                num2 = num3;
                                b = vector5 - this.ghostItem.transform.position;
                                vector2 = vector3;
                            }
                        }
                    }
                }
                vector2 += b;
            }
            this.canBuild = true;
            this.lastPosition = vector2;
            this.ghostItem.transform.position = vector2;
            ghostItem.transform.localScale = scale;
            return;
        }
        this.ghostItem.SetActive(false);
        this.canBuild = false;
    }


    private void OnDrawGizmos()
    {
        if (this.ghostExtents == null)
        {
            return;
        }
        foreach (Vector3 a in this.ghostExtents)
        {
            Gizmos.color = Color.blue;
            Vector3 vector = this.ghostItem.transform.position + a * (float)this.gridSize;
            vector = this.RotateAroundPivot(vector, this.ghostCollider.transform.position, new Vector3(0f, (float)this.yRotation, 0f));
            Gizmos.DrawCube(vector, Vector3.one);
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
        this.yRotation -= dir * this.rotationAngle;
    }


    public void RequestBuildItem()
    {
        if (!this.CanBuild() || !this.canBuild)
        {
            return;
        }
        Hotbar.Instance.UseItem(1);
        Gun.Instance.Build();
        ClientSend.RequestBuild(this.currentItem.id, this.lastPosition, this.yRotation);
    }


    public bool CanBuild()
    {
        return this.currentItem && this.currentItem.buildable && this.currentItem.amount > 0;
    }


    public GameObject BuildItem(int buildOwner, int itemID, int objectId, Vector3 position, int yRotation)
    {
        if (!SaveData.isExecuting) SaveData.Instance.save.Add(new SaveData.AddItem
        {
            itemId = itemID,
            objectId = objectId,
            position = position,
            yRot = yRotation,
        });
        InventoryItem inventoryItem = ItemManager.Instance.allItems[itemID];
        GameObject gameObject = Instantiate<GameObject>(inventoryItem.prefab);
        gameObject.transform.position = position;
        gameObject.transform.rotation = Quaternion.Euler(0f, (float)yRotation, 0f);
        if (inventoryItem.type == InventoryItem.ItemType.Car) gameObject.transform.localScale *= Car.Scale;
        if (this.buildFx)
        {
            Destroy(Instantiate<GameObject>(this.buildFx, position, Quaternion.identity), 5f);
        }
        if (inventoryItem.grid)
        {
            HitableTree component = gameObject.GetComponent<HitableTree>();
            component.SetDefaultScale(Vector3.one * (float)this.gridSize);
            component.PopIn();
        }
        gameObject.GetComponent<Hitable>().SetId(objectId);
        ResourceManager.Instance.AddObject(objectId, gameObject);
        if (inventoryItem.type == InventoryItem.ItemType.Car)
            ResourceManager.Instance.AddCar(objectId, gameObject);
        else
            ResourceManager.Instance.AddBuild(objectId, gameObject);
        BuildDoor component2 = gameObject.GetComponent<BuildDoor>();
        if (component2 != null)
        {
            foreach (BuildDoor.Door door in component2.doors)
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
                if (Tutorial.Instance && inventoryItem.name == "Workbench")
                {
                    Tutorial.Instance.stationPlaced = true;
                }
            }
        }
        return gameObject;
    }


    public int GetNextBuildId()
    {
        return ResourceManager.Instance.GetNextId();
    }


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

    public Material ghostMat;
    private Vector3[] sourcePoints = new Vector3[8];
    private Vector3[] points = new Vector3[8];
}
