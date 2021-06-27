using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Map : MonoBehaviour
{
	public bool active { get; set; } = true;

	private void Awake()
	{
		Map.Instance = this;
		this.active = false;
		this.mapMarkers = new List<Map.MapMarker>();
	}

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

	private Vector3 WorldPositionToMap(Vector3 worldPos)
	{
		return new Vector3(worldPos.x, worldPos.z, 0f) * this.mapRatio;
	}

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

	public void RemoveMarker(Map.MapMarker marker)
	{
		if (marker.marker)
		{
			Destroy(marker.marker.gameObject);
		}
		this.mapMarkers.Remove(marker);
	}

	public Transform playerIcon;

	public Transform mapParent;

	public RectTransform map;

	public RawImage mapRender;

	private float mapSize;

	private float mapRatio;

	private Vector3 maxPos;

	public Material mapTextureMaterial;

	public List<Map.MapMarker> mapMarkers;

	public static Map Instance;

	private Vector2 startHoldPos;

	private Vector2 startMapPos;

	public Transform markerParent;

	public Transform playerMarkerParent;

	public GameObject mapMarkerPrefab;

	public Texture[] markerTextures;

	public enum MarkerType
	{
		Player,
		Ping,
		Gem,
		Other
	}

	public class MapMarker
	{
		public MapMarker(Map.MarkerType type, Transform marker, Transform worldObject)
		{
			this.type = type;
			this.marker = marker;
			this.worldObject = worldObject;
		}

		public Map.MarkerType type;

		public Transform marker;

		public Transform worldObject;
	}
}
