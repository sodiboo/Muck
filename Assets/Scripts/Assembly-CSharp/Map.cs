using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000F9 RID: 249
public class Map : MonoBehaviour
{
	// Token: 0x1700004D RID: 77
	// (get) Token: 0x06000694 RID: 1684 RVA: 0x000062B8 File Offset: 0x000044B8
	// (set) Token: 0x06000695 RID: 1685 RVA: 0x000062C0 File Offset: 0x000044C0
	public bool active { get; set; } = true;

	// Token: 0x06000696 RID: 1686 RVA: 0x000062C9 File Offset: 0x000044C9
	private void Awake()
	{
		Map.Instance = this;
		this.active = false;
	}

	// Token: 0x06000697 RID: 1687 RVA: 0x00022370 File Offset: 0x00020570
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

	// Token: 0x06000698 RID: 1688 RVA: 0x000062D8 File Offset: 0x000044D8
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		this.ShowPlayers();
		this.PlayerInput();
	}

	// Token: 0x06000699 RID: 1689 RVA: 0x00022414 File Offset: 0x00020614
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

	// Token: 0x0600069A RID: 1690 RVA: 0x000225A4 File Offset: 0x000207A4
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

	// Token: 0x0600069B RID: 1691 RVA: 0x00022628 File Offset: 0x00020828
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

	// Token: 0x0600069C RID: 1692 RVA: 0x0002267C File Offset: 0x0002087C
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

	// Token: 0x0400067A RID: 1658
	public Transform playerIcon;

	// Token: 0x0400067B RID: 1659
	public Transform mapParent;

	// Token: 0x0400067C RID: 1660
	public RectTransform map;

	// Token: 0x0400067D RID: 1661
	public RawImage mapRender;

	// Token: 0x0400067E RID: 1662
	private float mapSize;

	// Token: 0x0400067F RID: 1663
	private float mapRatio;

	// Token: 0x04000680 RID: 1664
	private Vector3 maxPos;

	// Token: 0x04000681 RID: 1665
	public Material mapTextureMaterial;

	// Token: 0x04000683 RID: 1667
	public static Map Instance;

	// Token: 0x04000684 RID: 1668
	private Vector2 startHoldPos;

	// Token: 0x04000685 RID: 1669
	private Vector2 startMapPos;
}
