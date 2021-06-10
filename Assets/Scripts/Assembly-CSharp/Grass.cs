using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002B RID: 43
public class Grass : MonoBehaviour
{
	// Token: 0x060000FB RID: 251 RVA: 0x00007014 File Offset: 0x00005214
	private void Awake()
	{
		this.grassPool = new GameObject[this.thicc, this.thicc];
		this.grassPositions = new Dictionary<ValueTuple<float, float>, int>();
		for (int i = 0; i < this.thicc; i++)
		{
			for (int j = 0; j < this.thicc; j++)
			{
				this.grassPool[i, j] = Instantiate<GameObject>(this.grass);
			}
		}
		base.InvokeRepeating("MakeGrass", 0f, this.updateRate);
	}

	// Token: 0x060000FC RID: 252 RVA: 0x00007094 File Offset: 0x00005294
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

	// Token: 0x060000FD RID: 253 RVA: 0x00007243 File Offset: 0x00005443
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(base.transform.position, Vector3.one * this.length);
	}

	// Token: 0x040000F0 RID: 240
	public float length;

	// Token: 0x040000F1 RID: 241
	public int thicc = 10;

	// Token: 0x040000F2 RID: 242
	public GameObject grass;

	// Token: 0x040000F3 RID: 243
	private GameObject[,] grassPool;

	// Token: 0x040000F4 RID: 244
	private Dictionary<ValueTuple<float, float>, int> grassPositions;

	// Token: 0x040000F5 RID: 245
	public LayerMask whatIsGround;

	// Token: 0x040000F6 RID: 246
	private float updateRate = 0.02f;
}
