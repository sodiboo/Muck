using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Map : MonoBehaviour
{
    public enum MarkerType
    {
        Player,
        Ping,
        Gem,
        Other
    }

    public class MapMarker
    {
        public MarkerType type;

        public Transform marker;

        public Transform worldObject;

        public MapMarker(MarkerType type, Transform marker, Transform worldObject)
        {
            this.type = type;
            this.marker = marker;
            this.worldObject = worldObject;
        }
    }

    public Transform playerIcon;

    public Transform mapParent;

    public RectTransform map;

    public RawImage mapRender;

    private float mapSize;

    private float mapRatio;

    private Vector3 maxPos;

    public Material mapTextureMaterial;

    public List<MapMarker> mapMarkers;

    public static Map Instance;

    private Vector2 startHoldPos;

    private Vector2 startMapPos;

    public Transform markerParent;

    public Transform playerMarkerParent;

    public GameObject mapMarkerPrefab;

    public Texture[] markerTextures;

    public bool active { get; set; } = true;


    private void Awake()
    {
        Instance = this;
        active = false;
        mapMarkers = new List<MapMarker>();
    }

    public void GenerateMap()
    {
        mapSize = map.sizeDelta.x;
        int mapChunkSize = MapGenerator.mapChunkSize;
        float num = MapGenerator.worldScale;
        mapRatio = mapSize / ((float)mapChunkSize * num);
        Texture2D texture2D = TextureGenerator.ColorTextureFromHeightMap(MapGenerator.Instance.heightMap, MapGenerator.Instance.textureData);
        texture2D.minimumMipmapLevel = 0;
        mapTextureMaterial.mainTexture = texture2D;
        mapRender.material = mapTextureMaterial;
        maxPos = new Vector3(mapSize / 2f, mapSize / 2f);
    }

    private void Update()
    {
        if (active)
        {
            ShowPlayers();
            PlayerInput();
            UpdateMap();
        }
    }

    private void PlayerInput()
    {
        float y = Input.mouseScrollDelta.y;
        Vector2 vector = Input.mousePosition;
        if (Input.GetMouseButtonDown(0))
        {
            startHoldPos = vector;
            startMapPos = map.transform.position;
        }
        if (Input.GetMouseButton(0))
        {
            Vector2 vector2 = startHoldPos - vector;
            Vector2 vector3 = startMapPos - vector2;
            map.transform.position = vector3;
            Vector3 localPosition = map.transform.localPosition;
            Vector3 vector4 = maxPos * map.transform.localScale.x;
            localPosition = ClampVector(localPosition, vector4);
            map.transform.localPosition = localPosition;
        }
        if (y > 0f)
        {
            float num = map.transform.localScale.x + 0.3f;
            if (num > 6f)
            {
                num = 6f;
            }
            map.transform.localScale = new Vector3(num, num, num);
        }
        else if (y < 0f)
        {
            float num2 = map.transform.localScale.x - 0.3f;
            if ((double)num2 < 0.2)
            {
                num2 = 0.2f;
            }
            map.transform.localScale = new Vector3(num2, num2, num2);
        }
    }

    private Vector2 ClampVector(Vector2 v, Vector2 max)
    {
        if (v.x > max.x)
        {
            v.x = max.x;
        }
        else if (v.x < 0f - max.x)
        {
            v.x = 0f - max.x;
        }
        if (v.y > max.y)
        {
            v.y = max.y;
        }
        else if (v.y < 0f - max.y)
        {
            v.y = 0f - max.y;
        }
        return v;
    }

    public void ToggleMap()
    {
        active = !active;
        mapParent.gameObject.SetActive(active);
        if (active)
        {
            Cursor.visible = true;
            Cursor.lockState = CursorLockMode.None;
        }
        else
        {
            Cursor.visible = false;
            Cursor.lockState = CursorLockMode.Locked;
        }
    }

    private void UpdateMap()
    {
        foreach (MapMarker mapMarker in mapMarkers)
        {
            if (mapMarker != null)
            {
                if (mapMarker.worldObject == null || !mapMarker.worldObject.gameObject.activeInHierarchy)
                {
                    mapMarker.marker.gameObject.SetActive(value: false);
                    continue;
                }
                mapMarker.marker.gameObject.SetActive(value: true);
                mapMarker.marker.localPosition = WorldPositionToMap(mapMarker.worldObject.position);
            }
        }
    }

    private void ShowPlayers()
    {
        if ((bool)PlayerMovement.Instance)
        {
            Vector3 position = PlayerMovement.Instance.transform.position;
            Vector3 vector = new Vector3(position.x, position.z, 0f);
            playerIcon.transform.localPosition = vector * mapRatio;
            float y = PlayerMovement.Instance.orientation.eulerAngles.y;
            playerIcon.transform.localRotation = Quaternion.Euler(0f, 0f, 0f - y);
        }
    }

    private Vector3 WorldPositionToMap(Vector3 worldPos)
    {
        return new Vector3(worldPos.x, worldPos.z, 0f) * mapRatio;
    }

    public MapMarker AddMarker(Transform t, MarkerType markerType, Texture texture, Color col, string name = "", float scale = 1f)
    {
        GameObject gameObject = Object.Instantiate(mapMarkerPrefab, markerParent);
        RawImage component = gameObject.GetComponent<RawImage>();
        component.texture = markerTextures[(int)markerType];
        component.color = col;
        gameObject.transform.localPosition = WorldPositionToMap(t.position);
        gameObject.transform.localScale *= scale;
        if (texture != null)
        {
            gameObject.GetComponent<RawImage>().texture = texture;
        }
        MapMarker mapMarker = new MapMarker(markerType, gameObject.transform, t);
        mapMarkers.Add(mapMarker);
        gameObject.GetComponentInChildren<TextMeshProUGUI>().text = name;
        if (markerType == MarkerType.Player)
        {
            gameObject.transform.SetParent(playerMarkerParent);
        }
        return mapMarker;
    }

    public void RemoveMarker(MapMarker marker)
    {
        if ((bool)marker.marker)
        {
            Object.Destroy(marker.marker.gameObject);
        }
        mapMarkers.Remove(marker);
    }
}
