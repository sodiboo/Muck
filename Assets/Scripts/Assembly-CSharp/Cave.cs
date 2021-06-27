using System;
using UnityEngine;

public class Cave : MonoBehaviour
{
	public void SetCave(ConsistentRandom rand)
	{
		this.rand = rand;
		this.rend = base.GetComponent<MeshRenderer>();
		Color color = this.rend.material.color;
		Color tint = this.textureData.layers[2].tint;
		Color color2 = (color + tint) / 2f;
		this.rend.material.color = color2;
		this.chestSpawner.SetChests(rand);
		SpawnResourcesInLocations[] componentsInChildren = base.GetComponentsInChildren<SpawnResourcesInLocations>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].SetResources(rand);
		}
	}

	public TextureData textureData;

	public SpawnChestsInLocations chestSpawner;

	private MeshRenderer rend;

	private ConsistentRandom rand;
}
