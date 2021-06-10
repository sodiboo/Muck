
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000BC RID: 188
public class Map : MonoBehaviour
{
	// Token: 0x17000044 RID: 68
	// (get) Token: 0x06000601 RID: 1537 RVA: 0x0001E832 File Offset: 0x0001CA32
	// (set) Token: 0x06000602 RID: 1538 RVA: 0x0001E83A File Offset: 0x0001CA3A
	public bool active { get; set; } = true;

	// Token: 0x06000603 RID: 1539 RVA: 0x0001E843 File Offset: 0x0001CA43
	private void Awake()
	{
		Map.Instance = this;
		this.active = false;
	}

	// Token: 0x06000604 RID: 1540 RVA: 0x0001E854 File Offset: 0x0001CA54
	public void GenerateMap()
	{
		this.mapSize = this.map.sizeDelta.x;
		int mapChunkSize = MapGenerator.mapChunkSize;
		float num = (float)MapGenerator.worldScale;
		this.mapRatio = this.mapSize / ((float)mapChunkSize * num);
		Texture2D texture2D = TextureGenerator.ColorTextureFromHeightMap(MapGenerator.Instance.heightMap, MapGenerator.Instance.textureData);
		texture2D.minimumMipmapLevel = 0;
		this.mapTextureMaterial.mainTexture = texture2D;
		this.mapRender.material = this.mapTextureMaterial;
		this.maxPos = new Vector3(this.mapSize / 2f, this.mapSize / 2f);
	}

	// Token: 0x06000605 RID: 1541 RVA: 0x0001E8F6 File Offset: 0x0001CAF6
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		this.ShowPlayers();
		this.PlayerInput();
	}

	// Token: 0x06000606 RID: 1542 RVA: 0x0001E910 File Offset: 0x0001CB10
	private void PlayerInput()
	{
		float y = Input.mouseScrollDelta.y;
		Vector2 b = Input.mousePosition;
		if (Input.GetMouseButtonDown(0))
		{
			this.startHoldPos = b;
			this.startMapPos = this.map.transform.position;
		}
		if (Input.GetMouseButton(0))
		{
			Vector2 b2 = this.startHoldPos - b;
			Vector2 v = this.startMapPos - b2;
			this.map.transform.position = v;
			Vector3 vector = this.map.transform.localPosition;
			Vector3 v2 = this.maxPos * this.map.transform.localScale.x;
			vector = this.ClampVector(vector, v2);
			this.map.transform.localPosition = vector;
		}
		if (y > 0f)
		{
			float num = this.map.transform.localScale.x + 0.3f;
			if (num > 6f)
			{
				num = 6f;
			}
			this.map.transform.localScale = new Vector3(num, num, num);
			return;
		}
		if (y < 0f)
		{
			float num2 = this.map.transform.localScale.x - 0.3f;
			if ((double)num2 < 0.2)
			{
				num2 = 0.2f;
			}
			this.map.transform.localScale = new Vector3(num2, num2, num2);
		}
	}

	// Token: 0x06000607 RID: 1543 RVA: 0x0001EAA0 File Offset: 0x0001CCA0
	private Vector2 ClampVector(Vector2 v, Vector2 max)
	{
		if (v.x > max.x)
		{
			v.x = max.x;
		}
		else if (v.x < -max.x)
		{
			v.x = -max.x;
		}
		if (v.y > max.y)
		{
			v.y = max.y;
		}
		else if (v.y < -max.y)
		{
			v.y = -max.y;
		}
		return v;
	}

	// Token: 0x06000608 RID: 1544 RVA: 0x0001EB24 File Offset: 0x0001CD24
	public void ToggleMap()
	{
		this.active = !this.active;
		this.mapParent.gameObject.SetActive(this.active);
		if (this.active)
		{
			Cursor.visible = true;
			Cursor.lockState = CursorLockMode.None;
			return;
		}
		Cursor.visible = false;
		Cursor.lockState = CursorLockMode.Locked;
	}

	// Token: 0x06000609 RID: 1545 RVA: 0x0001EB78 File Offset: 0x0001CD78
	private void ShowPlayers()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		Vector3 position = PlayerMovement.Instance.transform.position;
		Vector3 a = new Vector3(position.x, position.z, 0f);
		this.playerIcon.transform.localPosition = a * this.mapRatio;
		float y = PlayerMovement.Instance.orientation.eulerAngles.y;
		this.playerIcon.transform.localRotation = Quaternion.Euler(0f, 0f, -y);
	}

	// Token: 0x04000573 RID: 1395
	public Transform playerIcon;

	// Token: 0x04000574 RID: 1396
	public Transform mapParent;

	// Token: 0x04000575 RID: 1397
	public RectTransform map;

	// Token: 0x04000576 RID: 1398
	public RawImage mapRender;

	// Token: 0x04000577 RID: 1399
	private float mapSize;

	// Token: 0x04000578 RID: 1400
	private float mapRatio;

	// Token: 0x04000579 RID: 1401
	private Vector3 maxPos;

	// Token: 0x0400057A RID: 1402
	public Material mapTextureMaterial;

	// Token: 0x0400057C RID: 1404
	public static Map Instance;

	// Token: 0x0400057D RID: 1405
	private Vector2 startHoldPos;

	// Token: 0x0400057E RID: 1406
	private Vector2 startMapPos;
}
