using System;
using UnityEngine;

// Token: 0x0200003C RID: 60
public class GenerateBoat : MonoBehaviour
{
	// Token: 0x06000163 RID: 355 RVA: 0x00008A88 File Offset: 0x00006C88
	private void Awake()
	{
		this.mapWidth = MapGenerator.mapChunkSize;
		this.mapHeight = MapGenerator.mapChunkSize;
		this.worldScale = (float)MapGenerator.worldScale;
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
		int num = 0;
		while (this.randomPos == Vector3.zero)
		{
			this.randomPos = this.FindRandomPointAroundWorld();
			num++;
			if (num > 10000)
			{
				break;
			}
		}
		Instantiate<GameObject>(this.boatPrefab, this.randomPos, this.boatPrefab.transform.rotation).GetComponent<Boat>().waterHeight = this.waterHeight;
	}

	// Token: 0x06000164 RID: 356 RVA: 0x00008B2C File Offset: 0x00006D2C
	private Vector3 FindRandomPointAroundWorld()
	{
		float x = (float)(this.randomGen.NextDouble() - 0.5);
		float z = (float)(this.randomGen.NextDouble() - 0.5);
		this.waterHeight = 6f;
		Vector3 vector = new Vector3(x, 0f, z).normalized * this.worldScale * ((float)this.mapWidth / 2f);
		RaycastHit raycastHit;
		if (!Physics.Raycast(new Vector3(vector.x, 200f, vector.z), Vector3.down, out raycastHit, 1000f, this.whatIsWater))
		{
			return Vector3.zero;
		}
		this.waterHeight = raycastHit.point.y;
		vector.y = this.waterHeight;
		Vector3 normalized = VectorExtensions.XZVector(Vector3.zero - vector).normalized;
		vector += Vector3.up;
		RaycastHit raycastHit2;
		if (Physics.Raycast(vector, normalized, out raycastHit2, 5000f, this.whatIsLand))
		{
			return raycastHit2.point;
		}
		return Vector3.zero;
	}

	// Token: 0x06000165 RID: 357 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0400015A RID: 346
	public int mapWidth;

	// Token: 0x0400015B RID: 347
	public int mapHeight;

	// Token: 0x0400015C RID: 348
	public float worldScale;

	// Token: 0x0400015D RID: 349
	public LayerMask whatIsWater;

	// Token: 0x0400015E RID: 350
	public LayerMask whatIsLand;

	// Token: 0x0400015F RID: 351
	private Vector3 randomPos;

	// Token: 0x04000160 RID: 352
	private ConsistentRandom randomGen;

	// Token: 0x04000161 RID: 353
	public GameObject boatPrefab;

	// Token: 0x04000162 RID: 354
	private float waterHeight;

	// Token: 0x04000163 RID: 355
	public int seed;
}
