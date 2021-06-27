using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000E4 RID: 228
public class Map : MonoBehaviour
{
	// Token: 0x17000054 RID: 84
	// (get) Token: 0x06000717 RID: 1815 RVA: 0x0002470A File Offset: 0x0002290A
	// (set) Token: 0x06000718 RID: 1816 RVA: 0x00024712 File Offset: 0x00022912
	public bool active { get; set; } = true;

	// Token: 0x06000719 RID: 1817 RVA: 0x0002471B File Offset: 0x0002291B
	private void Awake()
	{
		Map.Instance = this;
		this.active = false;
		this.mapMarkers = new List<Map.MapMarker>();
	}

	// Token: 0x0600071A RID: 1818 RVA: 0x00024738 File Offset: 0x00022938
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

	// Token: 0x0600071B RID: 1819 RVA: 0x000247DA File Offset: 0x000229DA
	private void Update()
	{
		if (!this.active)
		{
			return;
		}
		this.ShowPlayers();
		this.PlayerInput();
		this.UpdateMap();
	}

	// Token: 0x0600071C RID: 1820 RVA: 0x000247F8 File Offset: 0x000229F8
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

	// Token: 0x0600071D RID: 1821 RVA: 0x00024988 File Offset: 0x00022B88
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

	// Token: 0x0600071E RID: 1822 RVA: 0x00024A0C File Offset: 0x00022C0C
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

	// Token: 0x0600071F RID: 1823 RVA: 0x00024A60 File Offset: 0x00022C60
	private void UpdateMap()
	{
		foreach (Map.MapMarker mapMarker in this.mapMarkers)
		{
			if (mapMarker != null)
			{
				if (mapMarker.worldObject == null || !mapMarker.worldObject.gameObject.activeInHierarchy)
				{
					mapMarker.marker.gameObject.SetActive(false);
				}
				else
				{
					mapMarker.marker.gameObject.SetActive(true);
					mapMarker.marker.localPosition = this.WorldPositionToMap(mapMarker.worldObject.position);
				}
			}
		}
	}

	// Token: 0x06000720 RID: 1824 RVA: 0x00024B10 File Offset: 0x00022D10
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

	// Token: 0x06000721 RID: 1825 RVA: 0x00024BA4 File Offset: 0x00022DA4
	private Vector3 WorldPositionToMap(Vector3 worldPos)
	{
		return new Vector3(worldPos.x, worldPos.z, 0f) * this.mapRatio;
	}

	// Token: 0x06000722 RID: 1826 RVA: 0x00024BC8 File Offset: 0x00022DC8
	public Map.MapMarker AddMarker(Transform t, Map.MarkerType markerType, Texture texture, Color col, string name = "", float scale = 1f)
	{
		GameObject gameObject = Instantiate<GameObject>(this.mapMarkerPrefab, this.markerParent);
		RawImage component = gameObject.GetComponent<RawImage>();
		component.texture = this.markerTextures[(int)markerType];
		component.color = col;
		gameObject.transform.localPosition = this.WorldPositionToMap(t.position);
		gameObject.transform.localScale *= scale;
		if (texture != null)
		{
			gameObject.GetComponent<RawImage>().texture = texture;
		}
		Map.MapMarker mapMarker = new Map.MapMarker(markerType, gameObject.transform, t);
		this.mapMarkers.Add(mapMarker);
		gameObject.GetComponentInChildren<TextMeshProUGUI>().text = name;
		if (markerType == Map.MarkerType.Player)
		{
			gameObject.transform.SetParent(this.playerMarkerParent);
		}
		return mapMarker;
	}

	// Token: 0x06000723 RID: 1827 RVA: 0x00024C82 File Offset: 0x00022E82
	public void RemoveMarker(Map.MapMarker marker)
	{
		if (marker.marker)
		{
			Destroy(marker.marker.gameObject);
		}
		this.mapMarkers.Remove(marker);
	}

	// Token: 0x04000694 RID: 1684
	public Transform playerIcon;

	// Token: 0x04000695 RID: 1685
	public Transform mapParent;

	// Token: 0x04000696 RID: 1686
	public RectTransform map;

	// Token: 0x04000697 RID: 1687
	public RawImage mapRender;

	// Token: 0x04000698 RID: 1688
	private float mapSize;

	// Token: 0x04000699 RID: 1689
	private float mapRatio;

	// Token: 0x0400069A RID: 1690
	private Vector3 maxPos;

	// Token: 0x0400069B RID: 1691
	public Material mapTextureMaterial;

	// Token: 0x0400069D RID: 1693
	public List<Map.MapMarker> mapMarkers;

	// Token: 0x0400069E RID: 1694
	public static Map Instance;

	// Token: 0x0400069F RID: 1695
	private Vector2 startHoldPos;

	// Token: 0x040006A0 RID: 1696
	private Vector2 startMapPos;

	// Token: 0x040006A1 RID: 1697
	public Transform markerParent;

	// Token: 0x040006A2 RID: 1698
	public Transform playerMarkerParent;

	// Token: 0x040006A3 RID: 1699
	public GameObject mapMarkerPrefab;

	// Token: 0x040006A4 RID: 1700
	public Texture[] markerTextures;

	// Token: 0x0200016F RID: 367
	public enum MarkerType
	{
		// Token: 0x0400093F RID: 2367
		Player,
		// Token: 0x04000940 RID: 2368
		Ping,
		// Token: 0x04000941 RID: 2369
		Gem,
		// Token: 0x04000942 RID: 2370
		Other
	}

	// Token: 0x02000170 RID: 368
	public class MapMarker
	{
		// Token: 0x06000924 RID: 2340 RVA: 0x0002CD88 File Offset: 0x0002AF88
		public MapMarker(Map.MarkerType type, Transform marker, Transform worldObject)
		{
			this.type = type;
			this.marker = marker;
			this.worldObject = worldObject;
		}

		// Token: 0x04000943 RID: 2371
		public Map.MarkerType type;

		// Token: 0x04000944 RID: 2372
		public Transform marker;

		// Token: 0x04000945 RID: 2373
		public Transform worldObject;
	}
}
