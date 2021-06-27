using System;
using UnityEngine;

[CreateAssetMenu]
public class Powerup : ScriptableObject
{
	public Color GetOutlineColor()
	{
		switch (this.tier)
		{
		case Powerup.PowerTier.White:
			return Color.white;
		case Powerup.PowerTier.Blue:
			return Color.cyan;
		case Powerup.PowerTier.Orange:
			return Color.yellow;
		default:
			return Color.white;
		}
	}

	public string GetColorName()
	{
		switch (this.tier)
		{
		case Powerup.PowerTier.White:
			return "white";
		case Powerup.PowerTier.Blue:
			return "#00C0FF";
		case Powerup.PowerTier.Orange:
			return "orange";
		default:
			return "white";
		}
	}

	public new string name;

	public string description;

	public int id;

	public Powerup.PowerTier tier;

	public Mesh mesh;

	public Material material;

	public Sprite sprite;

	public enum PowerTier
	{
		White,
		Blue,
		Orange
	}
}
