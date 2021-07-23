using UnityEngine;

[CreateAssetMenu]
public class Powerup : ScriptableObject
{
    public enum PowerTier
    {
        White,
        Blue,
        Orange
    }

    public new string name;

    public string description;

    public int id;

    public PowerTier tier;

    public Mesh mesh;

    public Material material;

    public Sprite sprite;

    public Color GetOutlineColor()
    {
        switch (tier)
        {
        case PowerTier.White:
            return Color.white;
        case PowerTier.Blue:
            return Color.cyan;
        case PowerTier.Orange:
            return Color.yellow;
        default:
            return Color.white;
        }
    }

    public string GetColorName()
    {
        switch (tier)
        {
        case PowerTier.White:
            return "white";
        case PowerTier.Blue:
            return "#00C0FF";
        case PowerTier.Orange:
            return "orange";
        default:
            return "white";
        }
    }
}
