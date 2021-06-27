using System;
using System.Linq;
using UnityEngine;

[CreateAssetMenu]
public class TextureData : UpdatableData
{
	public void ApplyToMaterial(Material material)
	{
		material.SetInt("layerCount", this.layers.Length);
		material.SetColorArray("baseColours", (from x in this.layers
		select x.tint).ToArray<Color>());
		material.SetFloatArray("baseStartHeights", (from x in this.layers
		select x.startHeight).ToArray<float>());
		material.SetFloatArray("baseBlends", (from x in this.layers
		select x.blendStrength).ToArray<float>());
		material.SetFloatArray("baseColourStrength", (from x in this.layers
		select x.tintStrength).ToArray<float>());
		material.SetFloatArray("baseTextureScales", (from x in this.layers
		select x.textureScale).ToArray<float>());
		Texture2DArray value = this.GenerateTextureArray((from x in this.layers
		select x.texture).ToArray<Texture2D>());
		material.SetTexture("baseTextures", value);
		this.UpdateMeshHeights(material, this.savedMinHeight, this.savedMaxHeight);
	}

	public void UpdateMeshHeights(Material material, float minHeight, float maxHeight)
	{
		this.savedMinHeight = minHeight;
		this.savedMaxHeight = maxHeight;
		material.SetFloat("minHeight", minHeight);
		material.SetFloat("maxHeight", maxHeight);
	}

	private Texture2DArray GenerateTextureArray(Texture2D[] textures)
	{
		Texture2DArray texture2DArray = new Texture2DArray(512, 512, textures.Length, TextureFormat.RGB565, true);
		for (int i = 0; i < textures.Length; i++)
		{
			if (textures[i])
			{
				texture2DArray.SetPixels(textures[i].GetPixels(), i);
			}
		}
		texture2DArray.Apply();
		return texture2DArray;
	}

	private const int textureSize = 512;

	private const TextureFormat textureFormat = TextureFormat.RGB565;

	public TextureData.Layer[] layers;

	private float savedMinHeight;

	private float savedMaxHeight;

	[Serializable]
	public class Layer
	{
		public Texture2D texture;

		public Color tint;

		[Range(0f, 1f)]
		public float tintStrength;

		[Range(0f, 1f)]
		public float startHeight;

		[Range(0f, 1f)]
		public float blendStrength;

		public float textureScale;

		public TextureData.TerrainType type;
	}

	public enum TerrainType
	{
		Water,
		Sand,
		Grass
	}
}
