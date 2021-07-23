using UnityEngine;

public class Cave : MonoBehaviour
{
    public TextureData textureData;

    public SpawnChestsInLocations chestSpawner;

    private MeshRenderer rend;

    private ConsistentRandom rand;

    public void SetCave(ConsistentRandom rand)
    {
        this.rand = rand;
        rend = GetComponent<MeshRenderer>();
        Color color = rend.material.color;
        Color tint = textureData.layers[2].tint;
        Color color2 = (color + tint) / 2f;
        rend.material.color = color2;
        chestSpawner.SetChests(rand);
        SpawnResourcesInLocations[] componentsInChildren = GetComponentsInChildren<SpawnResourcesInLocations>();
        for (int i = 0; i < componentsInChildren.Length; i++)
        {
            componentsInChildren[i].SetResources(rand);
        }
    }
}
