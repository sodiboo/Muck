using System;
using System.Linq;
using UnityEngine;

// Token: 0x020000F1 RID: 241
[CreateAssetMenu]
public class TextureData : UpdatableData
{
	// Token: 0x0600074B RID: 1867 RVA: 0x000253EC File Offset: 0x000235EC
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

	// Token: 0x0600074C RID: 1868 RVA: 0x00025583 File Offset: 0x00023783
	public void UpdateMeshHeights(Material material, float minHeight, float maxHeight)
	{
		this.savedMinHeight = minHeight;
		this.savedMaxHeight = maxHeight;
		material.SetFloat("minHeight", minHeight);
		material.SetFloat("maxHeight", maxHeight);
	}

	// Token: 0x0600074D RID: 1869 RVA: 0x000255AC File Offset: 0x000237AC
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

	// Token: 0x040006D5 RID: 1749
	private const int textureSize = 512;

	// Token: 0x040006D6 RID: 1750
	private const TextureFormat textureFormat = TextureFormat.RGB565;

	// Token: 0x040006D7 RID: 1751
	public TextureData.Layer[] layers;

	// Token: 0x040006D8 RID: 1752
	private float savedMinHeight;

	// Token: 0x040006D9 RID: 1753
	private float savedMaxHeight;

	// Token: 0x02000171 RID: 369
	[Serializable]
	public class Layer
	{
		// Token: 0x04000946 RID: 2374
		public Texture2D texture;

		// Token: 0x04000947 RID: 2375
		public Color tint;

		// Token: 0x04000948 RID: 2376
		[Range(0f, 1f)]
		public float tintStrength;

		// Token: 0x04000949 RID: 2377
		[Range(0f, 1f)]
		public float startHeight;

		// Token: 0x0400094A RID: 2378
		[Range(0f, 1f)]
		public float blendStrength;

		// Token: 0x0400094B RID: 2379
		public float textureScale;

		// Token: 0x0400094C RID: 2380
		public TextureData.TerrainType type;
	}

	// Token: 0x02000172 RID: 370
	public enum TerrainType
	{
		// Token: 0x0400094E RID: 2382
		Water,
		// Token: 0x0400094F RID: 2383
		Sand,
		// Token: 0x04000950 RID: 2384
		Grass
	}
}
