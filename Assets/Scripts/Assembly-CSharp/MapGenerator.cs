using UnityEngine;

public class MapGenerator : MonoBehaviour
{
	public enum DrawMode
	{
		NoiseMap = 0,
		Mesh = 1,
		FalloffMap = 2,
		ColorMap = 3,
	}

	public DrawMode drawMode;
	public TerrainData terrainData;
	public NoiseData noiseData;
	public TextureData textureData;
	public Material terrainMaterial;
	public int levelOfDetail;
	public bool autoUpdate;
}
