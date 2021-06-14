using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000033 RID: 51
public class Grass : MonoBehaviour
{
	// Token: 0x0600010F RID: 271 RVA: 0x0000B928 File Offset: 0x00009B28
	private void Awake()
	{
		this.grassPool = new GameObject[this.thicc, this.thicc];
		this.grassPositions = new Dictionary<ValueTuple<float, float>, int>();
		for (int i = 0; i < this.thicc; i++)
		{
			for (int j = 0; j < this.thicc; j++)
			{
				this.grassPool[i, j] =Instantiate<GameObject>(this.grass);
			}
		}
		base.InvokeRepeating("MakeGrass", 0f, this.updateRate);
	}

	// Token: 0x06000110 RID: 272 RVA: 0x0000B9A8 File Offset: 0x00009BA8
	private void MakeGrass()
	{
		float num = this.length / (float)this.thicc;
		for (int i = 0; i < this.thicc; i++)
		{
			for (int j = 0; j < this.thicc; j++)
			{
				float num2 = base.transform.position.x - base.transform.position.x % num;
				float num3 = base.transform.position.z - base.transform.position.z % num;
				float x = num2 + (float)(i - this.thicc / 2) / (float)this.thicc * this.length;
				float z = num3 + (float)(j - this.thicc / 2) / (float)this.thicc * this.length;
				Vector3 vector = new Vector3(x, base.transform.position.y + 50f, z);
				RaycastHit raycastHit;
				if (Physics.Raycast(vector, Vector3.down, out raycastHit, 60f, this.whatIsGround))
				{
					Debug.DrawLine(vector, raycastHit.point, Color.blue);
					vector.y = raycastHit.point.y;
					Quaternion rotation = Quaternion.LookRotation(Vector3.Cross(Vector3.up, raycastHit.normal));
					Transform transform = this.grassPool[i, j].transform;
					transform.gameObject.SetActive(true);
					transform.position = vector;
					transform.rotation = rotation;
					transform.localScale = Vector3.one * UnityEngine.Random.Range(0.85f, 1.4f);
				}
				else
				{
					this.grassPool[i, j].SetActive(false);
				}
			}
		}
	}

	// Token: 0x06000111 RID: 273 RVA: 0x00002D6B File Offset: 0x00000F6B
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(base.transform.position, Vector3.one * this.length);
	}

	// Token: 0x04000113 RID: 275
	public float length;

	// Token: 0x04000114 RID: 276
	public int thicc = 10;

	// Token: 0x04000115 RID: 277
	public GameObject grass;

	// Token: 0x04000116 RID: 278
	private GameObject[,] grassPool;

	// Token: 0x04000117 RID: 279
	private Dictionary<ValueTuple<float, float>, int> grassPositions;

	// Token: 0x04000118 RID: 280
	public LayerMask whatIsGround;

	// Token: 0x04000119 RID: 281
	private float updateRate = 0.02f;
}
