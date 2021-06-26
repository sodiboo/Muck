using UnityEngine;
using UnityEngine.UI;

public class Map : MonoBehaviour
{
	public Transform playerIcon;
	public Transform mapParent;
	public RectTransform map;
	public RawImage mapRender;
	public Material mapTextureMaterial;
	public Transform markerParent;
	public Transform playerMarkerParent;
	public GameObject mapMarkerPrefab;
	public Texture[] markerTextures;
}
