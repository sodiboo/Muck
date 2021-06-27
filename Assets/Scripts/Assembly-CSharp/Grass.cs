using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003E RID: 62
public class Grass : MonoBehaviour
{
	// Token: 0x06000169 RID: 361 RVA: 0x00008C5C File Offset: 0x00006E5C
	private void Awake()
	{
		this.grassPool = new GameObject[this.thicc, this.thicc];
		this.grassPositions = new Dictionary<(float, float), int>();
		for (int i = 0; i < this.thicc; i++)
		{
			for (int j = 0; j < this.thicc; j++)
			{
				this.grassPool[i, j] = Instantiate<GameObject>(this.grass);
			}
		}
		InvokeRepeating(nameof(MakeGrass), 0f, this.updateRate);
	}

	// Token: 0x0600016A RID: 362 RVA: 0x00008CDC File Offset: 0x00006EDC
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
					transform.localScale = Vector3.one * Random.Range(0.85f, 1.4f);
				}
				else
				{
					this.grassPool[i, j].SetActive(false);
				}
			}
		}
	}

	// Token: 0x0600016B RID: 363 RVA: 0x00008E8B File Offset: 0x0000708B
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(base.transform.position, Vector3.one * this.length);
	}

	// Token: 0x04000165 RID: 357
	public float length;

	// Token: 0x04000166 RID: 358
	public int thicc = 10;

	// Token: 0x04000167 RID: 359
	public GameObject grass;

	// Token: 0x04000168 RID: 360
	private GameObject[,] grassPool;

	// Token: 0x04000169 RID: 361
	private Dictionary<(float, float), int> grassPositions;

	// Token: 0x0400016A RID: 362
	public LayerMask whatIsGround;

	// Token: 0x0400016B RID: 363
	private float updateRate = 0.02f;
}
