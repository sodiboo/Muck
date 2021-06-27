using System;
using UnityEngine;

// Token: 0x02000013 RID: 19
public class Cave : MonoBehaviour
{
	// Token: 0x06000075 RID: 117 RVA: 0x00004448 File Offset: 0x00002648
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

	// Token: 0x04000073 RID: 115
	public TextureData textureData;

	// Token: 0x04000074 RID: 116
	public SpawnChestsInLocations chestSpawner;

	// Token: 0x04000075 RID: 117
	private MeshRenderer rend;

	// Token: 0x04000076 RID: 118
	private ConsistentRandom rand;
}
