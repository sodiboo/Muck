using UnityEngine;

public class Powerup : ScriptableObject
{
	public enum PowerTier
	{
		White = 0,
		Blue = 1,
		Orange = 2,
	}

	public new string name;
	public string description;
	public int id;
	public PowerTier tier;
	public Mesh mesh;
	public Material material;
	public Sprite sprite;
}
