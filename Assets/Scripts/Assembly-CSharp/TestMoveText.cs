using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000120 RID: 288
public class TestMoveText : MonoBehaviour
{
	// Token: 0x06000856 RID: 2134 RVA: 0x00029CA4 File Offset: 0x00027EA4
	private void Awake()
	{
		this.toSurface = new List<int>();
		this.notSurfacing = new List<int>();
		this.children = base.GetComponentsInChildren<Transform>();
		this.startHeight = new Vector3(1f, base.transform.GetChild(0).position.y, 1f);
		foreach (Transform transform in this.children)
		{
			transform.transform.position += Vector3.down * 50f;
			this.notSurfacing.Add(transform.GetSiblingIndex());
		}
		float num = 0.08f;
		float num2 = 2f;
		InvokeRepeating(nameof(SlowUpdate), num2, num);
		InvokeRepeating(nameof(AddMaterial), num * (float)base.transform.childCount + num2 + 2f, 0.05f);
	}

	// Token: 0x06000857 RID: 2135 RVA: 0x00029D90 File Offset: 0x00027F90
	private void AddMaterial()
	{
		this.a++;
		if (this.a > 50)
		{
			base.CancelInvoke();
		}
		for (int i = 0; i < 100; i++)
		{
			GameObject gameObject = this.trees[Random.Range(0, this.trees.Length)];
			Vector3 b = new Vector3(Random.Range(-this.drawArea.x / 2f, this.drawArea.x / 2f), 80f, Random.Range(-this.drawArea.z / 2f, this.drawArea.z / 2f));
			Vector3 vector = base.transform.position + b;
			Debug.DrawLine(vector, vector + Vector3.down * 120f, Color.red, 10f);
			Debug.DrawLine(Vector3.zero, vector * 50f, Color.black, 10f);
			RaycastHit raycastHit;
			if (Physics.Raycast(vector, Vector3.down, out raycastHit, 120f, this.whatIsGround) && Vector3.Angle(raycastHit.normal, Vector3.up) <= 5f)
			{
				Transform transform = Instantiate<GameObject>(gameObject, raycastHit.point, gameObject.transform.rotation).transform;
				HitableResource component = transform.GetComponent<HitableResource>();
				if (component)
				{
					float d = 1f;
					if (transform.CompareTag("Count"))
					{
						d = 3f;
					}
					component.SetDefaultScale(Vector3.one * 0.2f * d);
					component.PopIn();
				}
			}
		}
	}

	// Token: 0x06000858 RID: 2136 RVA: 0x00029F44 File Offset: 0x00028144
	private void SlowUpdate()
	{
		int index = Random.Range(0, this.notSurfacing.Count);
		int item = this.notSurfacing[index];
		this.toSurface.Add(item);
		this.notSurfacing.Remove(item);
		if (this.notSurfacing.Count <= 0)
		{
			base.CancelInvoke("SlowUpdate");
		}
	}

	// Token: 0x06000859 RID: 2137 RVA: 0x00029FA4 File Offset: 0x000281A4
	private void Update()
	{
		int num = 0;
		foreach (int index in this.toSurface)
		{
			num++;
			Transform child = base.transform.GetChild(index);
			child.position = Vector3.Lerp(child.position, new Vector3(child.position.x, this.startHeight.y, child.position.z), Time.deltaTime * 5f);
		}
	}

	// Token: 0x040007E1 RID: 2017
	private List<int> toSurface;

	// Token: 0x040007E2 RID: 2018
	private List<int> notSurfacing;

	// Token: 0x040007E3 RID: 2019
	private Transform[] children;

	// Token: 0x040007E4 RID: 2020
	private Vector3 startHeight;

	// Token: 0x040007E5 RID: 2021
	public Material[] mats;

	// Token: 0x040007E6 RID: 2022
	public GameObject[] trees;

	// Token: 0x040007E7 RID: 2023
	private int a;

	// Token: 0x040007E8 RID: 2024
	public LayerMask whatIsGround;

	// Token: 0x040007E9 RID: 2025
	public Vector3 drawArea;
}
