using UnityEngine;

public class MapDisplay : MonoBehaviour
{
    public Renderer textureRender;

    public MeshFilter meshFilter;

    public MeshRenderer meshRenderer;

    public MeshCollider meshCollider;

    public void DrawTexture(Texture2D texture)
    {
        textureRender.sharedMaterial.mainTexture = texture;
        textureRender.transform.localScale = new Vector3(texture.width, 1f, texture.height);
    }

    public void DrawMesh(MeshData meshData)
    {
        meshFilter.sharedMesh = meshData.CreateMesh();
        meshCollider.sharedMesh = meshFilter.sharedMesh;
    }
}
