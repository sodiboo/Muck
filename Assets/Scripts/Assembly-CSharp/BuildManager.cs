
using UnityEngine;

// Token: 0x02000009 RID: 9
public class BuildManager : MonoBehaviour
{
	// Token: 0x06000020 RID: 32 RVA: 0x0000293C File Offset: 0x00000B3C
	private void Awake()
	{
		BuildManager.Instance = this;
		this.filter = this.ghostItem.GetComponent<MeshFilter>();
		this.renderer = this.ghostItem.GetComponent<Renderer>();
	}

	// Token: 0x06000021 RID: 33 RVA: 0x00002968 File Offset: 0x00000B68
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

	// Token: 0x06000022 RID: 34 RVA: 0x00002A50 File Offset: 0x00000C50
	private void Update()
	{
		this.NewestBuild();
	}

	// Token: 0x06000023 RID: 35 RVA: 0x00002A58 File Offset: 0x00000C58
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

	// Token: 0x06000024 RID: 36 RVA: 0x00002EE8 File Offset: 0x000010E8
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

	// Token: 0x06000025 RID: 37 RVA: 0x00002F84 File Offset: 0x00001184
	private void NewerBuild()
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
				}
				return;
			}
		}
		if (!this.currentItem.buildable)
		{
			this.ghostItem.SetActive(false);
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
		}
		this.SetNewItem();
		Vector3 center = this.filter.mesh.bounds.center;
		Vector3 vector = this.filter.mesh.bounds.extents * (float)this.gridSize;
		new Vector3(0f, vector.y, 0f);
		float num = -this.filter.mesh.bounds.extents.y;
		float num2 = vector.y * 2f / (float)this.gridSize;
		float num3 = vector.x * 2f / (float)this.gridSize;
		this.debugInfo = string.Concat(new object[]
		{
			this.debugInfo,
			"Height units: ",
			num2,
			"\nWidth units: ",
			num3,
			"\n"
		});
		float d = 0.1f * (float)this.gridSize;
		this.ghostItem.transform.rotation = Quaternion.Euler(0f, (float)this.yRotation, 0f);
		RaycastHit raycastHit;
		if (Physics.Raycast(new Ray(this.playerCam.position, this.playerCam.forward), out raycastHit, 12f, this.whatIsGround))
		{
			Vector3 vector2 = raycastHit.point + Vector3.up * vector.y;
			if (raycastHit.collider.gameObject.CompareTag("Build") && this.currentItem.grid)
			{
				MeshFilter component = raycastHit.transform.GetComponent<MeshFilter>();
				Vector3 position = raycastHit.transform.position;
				Vector3 vector3 = component.mesh.bounds.extents * (float)this.gridSize;
				BuildSnappingInfo component2 = raycastHit.collider.GetComponent<BuildSnappingInfo>();
				float num4 = position.y - vector3.y;
				float num5 = vector3.y * 2f / (float)this.gridSize;
				vector2 = raycastHit.point;
				this.debugInfo = string.Concat(new object[]
				{
					this.debugInfo,
					"Other height units: ",
					num5,
					"\n"
				});
				int num6 = Mathf.CeilToInt(num5 / num2);
				float num7 = vector3.y * 2f / (float)num6;
				this.debugInfo = string.Concat(new object[]
				{
					this.debugInfo,
					"height steps: ",
					num6,
					"\n"
				});
				Vector3 zero = Vector3.zero;
				float num8 = 2f;
				foreach (Vector3 a in component2.position)
				{
					Vector3 vector4 = raycastHit.collider.transform.position + a * (float)this.gridSize;
					vector4 = this.RotateAroundPivot(vector4, raycastHit.collider.transform.position, new Vector3(0f, raycastHit.collider.transform.eulerAngles.y, 0f));
					if (Vector3.Distance(raycastHit.point, vector4) < num8)
					{
						vector2.x = vector4.x;
						vector2.z = vector4.z;
						Vector3 b = (vector4 - position).normalized * d * 0.5f;
						vector2 -= b;
						break;
					}
				}
				Vector3 b2 = this.ghostItem.GetComponent<Collider>().bounds.ClosestPoint(this.ghostItem.transform.position - raycastHit.normal * 5f * (float)this.gridSize);
				Vector3 a2 = this.ghostItem.transform.position - b2;
				Vector3 b3 = Vector3.Project(raycastHit.point - vector2, raycastHit.normal);
				vector2 += a2 + b3;
				if (raycastHit.normal != Vector3.up && raycastHit.normal != Vector3.down)
				{
					for (int j = num6; j >= 0; j--)
					{
						float num9 = num4 + num7 * (float)j;
						if (raycastHit.point.y > num9)
						{
							vector2.y = num9 + vector.y;
							break;
						}
					}
				}
				vector2 += -raycastHit.normal * d;
			}
			this.canBuild = true;
			this.lastPosition = vector2;
			this.ghostItem.transform.position = vector2;
			return;
		}
		this.ghostItem.SetActive(false);
		this.canBuild = false;
	}

	// Token: 0x06000026 RID: 38 RVA: 0x00003558 File Offset: 0x00001758
	private Vector3 RotateAroundPivot(Vector3 point, Vector3 pivot, Vector3 angles)
	{
		Vector3 vector = point - pivot;
		vector = Quaternion.Euler(angles) * vector;
		point = vector + pivot;
		return point;
	}

	// Token: 0x06000027 RID: 39 RVA: 0x00003584 File Offset: 0x00001784
	private void OnGUI()
	{
		if (this.ghostItem == null || !this.ghostItem.activeInHierarchy)
		{
			return;
		}
		Vector3 vector = Camera.main.WorldToScreenPoint(this.ghostItem.transform.position);
		Vector2 vector2 = GUI.skin.label.CalcSize(new GUIContent(this.debugInfo));
		GUI.Label(new Rect(vector.x, (float)Screen.height - vector.y, vector2.x, vector2.y), this.debugInfo);
	}

	// Token: 0x06000028 RID: 40 RVA: 0x00003612 File Offset: 0x00001812
	public void RotateBuild(int dir)
	{
		this.yRotation -= dir * this.rotationAngle;
	}

	// Token: 0x06000029 RID: 41 RVA: 0x0000362C File Offset: 0x0000182C
	public Vector3 posToGridPos(Vector3 point, int steps)
	{
		int num = this.gridSize / steps;
		float num2 = point.x;
		float num3 = point.z;
		if (num2 < 0f)
		{
			num2 -= (float)num;
		}
		if (num3 < 0f)
		{
			num3 -= (float)num;
		}
		float num4 = num2 - num2 % (float)num;
		float num5 = num3 - num3 % (float)num;
		float x = num4 + (float)num / 2f;
		num5 += (float)num / 2f;
		return new Vector3(x, point.y, num5);
	}

	// Token: 0x0600002A RID: 42 RVA: 0x00003697 File Offset: 0x00001897
	public void RequestBuildItem()
	{
		if (!this.CanBuild())
		{
			return;
		}
		Hotbar.Instance.UseItem(1);
		ClientSend.RequestBuild(this.currentItem.id, this.lastPosition, this.yRotation);
	}

	// Token: 0x0600002B RID: 43 RVA: 0x000036C9 File Offset: 0x000018C9
	public bool CanBuild()
	{
		return this.currentItem && this.currentItem.buildable && this.currentItem.amount > 0;
	}

	// Token: 0x0600002C RID: 44 RVA: 0x000036FC File Offset: 0x000018FC
	public GameObject BuildItem(int buildOwner, int itemID, int objectId, Vector3 position, int yRotation)
	{
		InventoryItem inventoryItem = ItemManager.Instance.allItems[itemID];
		GameObject gameObject =Instantiate(inventoryItem.prefab);
		gameObject.transform.position = position;
		gameObject.transform.rotation = Quaternion.Euler(0f, (float)yRotation, 0f);
		if (this.buildFx)
		{
		Instantiate(this.buildFx, position, Quaternion.identity);
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

	// Token: 0x0600002D RID: 45 RVA: 0x00003887 File Offset: 0x00001A87
	public int GetNextBuildId()
	{
		return ResourceManager.Instance.GetNextId();
	}

	// Token: 0x04000021 RID: 33
	public int gridSize = 2;

	// Token: 0x04000022 RID: 34
	private int gridWidth = 10;

	// Token: 0x04000023 RID: 35
	public LayerMask whatIsGround;

	// Token: 0x04000024 RID: 36
	private Transform playerCam;

	// Token: 0x04000025 RID: 37
	private InventoryItem currentItem;

	// Token: 0x04000026 RID: 38
	public GameObject buildFx;

	// Token: 0x04000027 RID: 39
	public GameObject ghostItem;

	// Token: 0x04000028 RID: 40
	private Renderer renderer;

	// Token: 0x04000029 RID: 41
	private MeshFilter filter;

	// Token: 0x0400002A RID: 42
	public int yRotation;

	// Token: 0x0400002B RID: 43
	public GameObject rotateText;

	// Token: 0x0400002C RID: 44
	public static BuildManager Instance;

	// Token: 0x0400002D RID: 45
	private Vector3 lastPosition;

	// Token: 0x0400002E RID: 46
	private bool canBuild;

	// Token: 0x0400002F RID: 47
	private Vector3[] ghostExtents;

	// Token: 0x04000030 RID: 48
	private Collider ghostCollider;

	// Token: 0x04000031 RID: 49
	private string debugInfo;

	// Token: 0x04000032 RID: 50
	private int rotationAngle = 45;

	// Token: 0x04000033 RID: 51
	private int id;
}
