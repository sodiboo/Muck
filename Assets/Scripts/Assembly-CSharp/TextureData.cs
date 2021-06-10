using System;
using System.Linq;
using UnityEngine;

// Token: 0x020000C9 RID: 201
[CreateAssetMenu]
public class TextureData : UpdatableData
{
	// Token: 0x06000631 RID: 1585 RVA: 0x0001F30C File Offset: 0x0001D50C
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

	// Token: 0x06000632 RID: 1586 RVA: 0x0001F4A3 File Offset: 0x0001D6A3
	public void UpdateMeshHeights(Material material, float minHeight, float maxHeight)
	{
		this.savedMinHeight = minHeight;
		this.savedMaxHeight = maxHeight;
		material.SetFloat("minHeight", minHeight);
		material.SetFloat("maxHeight", maxHeight);
	}

	// Token: 0x06000633 RID: 1587 RVA: 0x0001F4CC File Offset: 0x0001D6CC
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

	// Token: 0x040005AF RID: 1455
	private const int textureSize = 512;

	// Token: 0x040005B0 RID: 1456
	private const TextureFormat textureFormat = TextureFormat.RGB565;

	// Token: 0x040005B1 RID: 1457
	public TextureData.Layer[] layers;

	// Token: 0x040005B2 RID: 1458
	private float savedMinHeight;

	// Token: 0x040005B3 RID: 1459
	private float savedMaxHeight;

	// Token: 0x02000130 RID: 304
	[Serializable]
	public class Layer
	{
		// Token: 0x040007BF RID: 1983
		public Texture2D texture;

		// Token: 0x040007C0 RID: 1984
		public Color tint;

		// Token: 0x040007C1 RID: 1985
		[Range(0f, 1f)]
		public float tintStrength;

		// Token: 0x040007C2 RID: 1986
		[Range(0f, 1f)]
		public float startHeight;

		// Token: 0x040007C3 RID: 1987
		[Range(0f, 1f)]
		public float blendStrength;

		// Token: 0x040007C4 RID: 1988
		public float textureScale;

		// Token: 0x040007C5 RID: 1989
		public TextureData.TerrainType type;
	}

	// Token: 0x02000131 RID: 305
	public enum TerrainType
	{
		// Token: 0x040007C7 RID: 1991
		Water,
		// Token: 0x040007C8 RID: 1992
		Sand,
		// Token: 0x040007C9 RID: 1993
		Grass
	}
}
