using System;
using UnityEngine;

public class MapDisplay : MonoBehaviour
{
	public void DrawTexture(Texture2D texture)
	{
		this.textureRender.sharedMaterial.mainTexture = texture;
		this.textureRender.transform.localScale = new Vector3((float)texture.width, 1f, (float)texture.height);
	}

	public void DrawMesh(MeshData meshData)
	{
		this.meshFilter.sharedMesh = meshData.CreateMesh();
		this.meshCollider.sharedMesh = this.meshFilter.sharedMesh;
	}

	public Renderer textureRender;

	public MeshFilter meshFilter;

	public MeshRenderer meshRenderer;

	public MeshCollider meshCollider;
}
