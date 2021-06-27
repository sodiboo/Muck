using System.Collections.Generic;
using UnityEngine;

public class Grass : MonoBehaviour
{
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

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(base.transform.position, Vector3.one * this.length);
	}

	public float length;

	public int thicc = 10;

	public GameObject grass;

	private GameObject[,] grassPool;

	private Dictionary<(float, float), int> grassPositions;

	public LayerMask whatIsGround;

	private float updateRate = 0.02f;
}
