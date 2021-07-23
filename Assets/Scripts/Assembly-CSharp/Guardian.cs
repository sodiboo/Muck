using UnityEngine;

public class Guardian : MonoBehaviour
{
	public enum GuardianType
	{
		Basic = 0,
		Red = 1,
		Yellow = 2,
		Green = 3,
		Blue = 4,
		Pink = 5,
	}

	public GuardianType type;
	public Material[] guardianMaterial;
	public Material[] fxMaterial;
	public InventoryItem[] gems;
	public SkinnedMeshRenderer rend;
	public ParticleSystem[] particles;
	public LineRenderer[] lines;
	public TrailRenderer[] trails;
	public Hitable hitable;
	public GameObject[] destroyOnDeath;
}
