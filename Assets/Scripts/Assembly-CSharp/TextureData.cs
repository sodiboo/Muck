using System;
using UnityEngine;

public class TextureData : UpdatableData
{
	[Serializable]
	public class Layer
	{
		public Texture2D texture;
		public Color tint;
		public float tintStrength;
		public float startHeight;
		public float blendStrength;
		public float textureScale;
		public TextureData.TerrainType type;
	}

	public enum TerrainType
	{
		Water = 0,
		Sand = 1,
		Grass = 2,
	}

	public Layer[] layers;
}
