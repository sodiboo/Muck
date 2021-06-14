using System;
using System.Linq;
using UnityEngine;

// Token: 0x02000106 RID: 262
[CreateAssetMenu]
public class TextureData : UpdatableData
{
	// Token: 0x060006C4 RID: 1732 RVA: 0x00022CD0 File Offset: 0x00020ED0
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

	// Token: 0x060006C5 RID: 1733 RVA: 0x0000645A File Offset: 0x0000465A
	public void UpdateMeshHeights(Material material, float minHeight, float maxHeight)
	{
		this.savedMinHeight = minHeight;
		this.savedMaxHeight = maxHeight;
		material.SetFloat("minHeight", minHeight);
		material.SetFloat("maxHeight", maxHeight);
	}

	// Token: 0x060006C6 RID: 1734 RVA: 0x00022E68 File Offset: 0x00021068
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

	// Token: 0x040006B6 RID: 1718
	private const int textureSize = 512;

	// Token: 0x040006B7 RID: 1719
	private const TextureFormat textureFormat = TextureFormat.RGB565;

	// Token: 0x040006B8 RID: 1720
	public TextureData.Layer[] layers;

	// Token: 0x040006B9 RID: 1721
	private float savedMinHeight;

	// Token: 0x040006BA RID: 1722
	private float savedMaxHeight;

	// Token: 0x02000107 RID: 263
	[Serializable]
	public class Layer
	{
		// Token: 0x040006BB RID: 1723
		public Texture2D texture;

		// Token: 0x040006BC RID: 1724
		public Color tint;

		// Token: 0x040006BD RID: 1725
		[Range(0f, 1f)]
		public float tintStrength;

		// Token: 0x040006BE RID: 1726
		[Range(0f, 1f)]
		public float startHeight;

		// Token: 0x040006BF RID: 1727
		[Range(0f, 1f)]
		public float blendStrength;

		// Token: 0x040006C0 RID: 1728
		public float textureScale;

		// Token: 0x040006C1 RID: 1729
		public TextureData.TerrainType type;
	}

	// Token: 0x02000108 RID: 264
	public enum TerrainType
	{
		// Token: 0x040006C3 RID: 1731
		Water,
		// Token: 0x040006C4 RID: 1732
		Sand,
		// Token: 0x040006C5 RID: 1733
		Grass
	}
}
