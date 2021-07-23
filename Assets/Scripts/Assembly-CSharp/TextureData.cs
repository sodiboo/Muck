using System;
using System.Linq;
using UnityEngine;

[CreateAssetMenu]
public class TextureData : UpdatableData
{
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

        public TerrainType type;
    }

    public enum TerrainType
    {
        Water,
        Sand,
        Grass
    }

    private const int textureSize = 512;

    private const TextureFormat textureFormat = TextureFormat.RGB565;

    public Layer[] layers;

    private float savedMinHeight;

    private float savedMaxHeight;

    public void ApplyToMaterial(Material material)
    {
        material.SetInt("layerCount", layers.Length);
        material.SetColorArray("baseColours", layers.Select((Layer x) => x.tint).ToArray());
        material.SetFloatArray("baseStartHeights", layers.Select((Layer x) => x.startHeight).ToArray());
        material.SetFloatArray("baseBlends", layers.Select((Layer x) => x.blendStrength).ToArray());
        material.SetFloatArray("baseColourStrength", layers.Select((Layer x) => x.tintStrength).ToArray());
        material.SetFloatArray("baseTextureScales", layers.Select((Layer x) => x.textureScale).ToArray());
        Texture2DArray value = GenerateTextureArray(layers.Select((Layer x) => x.texture).ToArray());
        material.SetTexture("baseTextures", value);
        UpdateMeshHeights(material, savedMinHeight, savedMaxHeight);
    }

    public void UpdateMeshHeights(Material material, float minHeight, float maxHeight)
    {
        savedMinHeight = minHeight;
        savedMaxHeight = maxHeight;
        material.SetFloat("minHeight", minHeight);
        material.SetFloat("maxHeight", maxHeight);
    }

    private Texture2DArray GenerateTextureArray(Texture2D[] textures)
    {
        Texture2DArray texture2DArray = new Texture2DArray(512, 512, textures.Length, TextureFormat.RGB565, mipChain: true);
        for (int i = 0; i < textures.Length; i++)
        {
            if ((bool)textures[i])
            {
                texture2DArray.SetPixels(textures[i].GetPixels(), i);
            }
        }
        texture2DArray.Apply();
        return texture2DArray;
    }
}
