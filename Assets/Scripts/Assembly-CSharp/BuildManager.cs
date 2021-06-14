using System;
using UnityEngine;

// Token: 0x0200000A RID: 10
public class BuildManager : MonoBehaviour
{
	// Token: 0x06000024 RID: 36 RVA: 0x000021D0 File Offset: 0x000003D0
	private void Awake()
	{
		BuildManager.Instance = this;
		this.filter = this.ghostItem.GetComponent<MeshFilter>();
		this.renderer = this.ghostItem.GetComponent<Renderer>();
	}

	// Token: 0x06000025 RID: 37 RVA: 0x00007FA4 File Offset: 0x000061A4
	private void SetNewItem()
	{
		this.filter.mesh = this.currentItem.mesh;
		Material material = this.renderer.material;
		material.mainTexture = this.currentItem.material.mainTexture;
		this.renderer.material = material;
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

	// Token: 0x06000026 RID: 38 RVA: 0x000021FA File Offset: 0x000003FA
	private void Update()
	{
		this.NewestBuild();
	}

	// Token: 0x06000027 RID: 39 RVA: 0x0000808C File Offset: 0x0000628C
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
		this.SetNewItem();
		Vector3 vector = this.filter.mesh.bounds.extents;
		if (this.currentItem.grid)
		{
			vector *= (float)this.gridSize;
		}
		this.ghostItem.transform.rotation = Quaternion.Euler(0f, (float)this.yRotation, 0f);
		RaycastHit raycastHit;
		if (Physics.Raycast(new Ray(this.playerCam.position, this.playerCam.forward), out raycastHit, 12f, this.whatIsGround))
		{
			Vector3 vector2 = raycastHit.point + Vector3.up * (vector.y - this.filter.mesh.bounds.center.y);
			Vector3 center = this.filter.mesh.bounds.center;
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
			return;
		}
		this.ghostItem.SetActive(false);
		this.canBuild = false;
	}

	// Token: 0x06000028 RID: 40 RVA: 0x0000851C File Offset: 0x0000671C
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

	// Token: 0x06000029 RID: 41 RVA: 0x000085B8 File Offset: 0x000067B8
	private Vector3 RotateAroundPivot(Vector3 point, Vector3 pivot, Vector3 angles)
	{
		Vector3 vector = point - pivot;
		vector = Quaternion.Euler(angles) * vector;
		point = vector + pivot;
		return point;
	}

	// Token: 0x0600002A RID: 42 RVA: 0x00002202 File Offset: 0x00000402
	public void RotateBuild(int dir)
	{
		this.yRotation -= dir * this.rotationAngle;
	}

	// Token: 0x0600002B RID: 43 RVA: 0x000085E4 File Offset: 0x000067E4
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

	// Token: 0x0600002C RID: 44 RVA: 0x00002219 File Offset: 0x00000419
	public bool CanBuild()
	{
		return this.currentItem && this.currentItem.buildable && this.currentItem.amount > 0;
	}

	// Token: 0x0600002D RID: 45 RVA: 0x00008634 File Offset: 0x00006834
	public GameObject BuildItem(int buildOwner, int itemID, int objectId, Vector3 position, int yRotation)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemID];
		GameObject gameObject =Instantiate<GameObject>(inventoryItem.prefab);
		gameObject.transform.position = position;
		gameObject.transform.rotation = Quaternion.Euler(0f, (float)yRotation, 0f);
		if (this.buildFx)
		{
		Instantiate<GameObject>(this.buildFx, position, Quaternion.identity);
		}
		if (inventoryItem.grid)
		{
			HitableTree component = gameObject.GetComponent<HitableTree>();
			component.SetDefaultScale(Vector3.one * (float)this.gridSize);
			component.PopIn();
		}
		gameObject.GetComponent<Hitable>().SetId(objectId);
		ResourceManager.Instance.AddObject(objectId, gameObject);
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

	// Token: 0x0600002E RID: 46 RVA: 0x0000224A File Offset: 0x0000044A
	public int GetNextBuildId()
	{
		return ResourceManager.Instance.GetNextId();
	}

	// Token: 0x04000024 RID: 36
	public int gridSize = 2;

	// Token: 0x04000025 RID: 37
	private int gridWidth = 10;

	// Token: 0x04000026 RID: 38
	public LayerMask whatIsGround;

	// Token: 0x04000027 RID: 39
	private Transform playerCam;

	// Token: 0x04000028 RID: 40
	private InventoryItem currentItem;

	// Token: 0x04000029 RID: 41
	public GameObject buildFx;

	// Token: 0x0400002A RID: 42
	public GameObject ghostItem;

	// Token: 0x0400002B RID: 43
	private Renderer renderer;

	// Token: 0x0400002C RID: 44
	private MeshFilter filter;

	// Token: 0x0400002D RID: 45
	public int yRotation;

	// Token: 0x0400002E RID: 46
	public GameObject rotateText;

	// Token: 0x0400002F RID: 47
	public static BuildManager Instance;

	// Token: 0x04000030 RID: 48
	private Vector3 lastPosition;

	// Token: 0x04000031 RID: 49
	private bool canBuild;

	// Token: 0x04000032 RID: 50
	private Vector3[] ghostExtents;

	// Token: 0x04000033 RID: 51
	private Collider ghostCollider;

	// Token: 0x04000034 RID: 52
	private string debugInfo;

	// Token: 0x04000035 RID: 53
	private int rotationAngle = 45;

	// Token: 0x04000036 RID: 54
	private int id;
}
