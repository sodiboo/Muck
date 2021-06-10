
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000F1 RID: 241
public class TestMoveText : MonoBehaviour
{
	// Token: 0x06000714 RID: 1812 RVA: 0x000233CC File Offset: 0x000215CC
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
		base.InvokeRepeating("SlowUpdate", num2, num);
		base.InvokeRepeating("AddMaterial", num * (float)base.transform.childCount + num2 + 2f, 0.05f);
	}

	// Token: 0x06000715 RID: 1813 RVA: 0x000234B8 File Offset: 0x000216B8
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
				Transform transform =Instantiate(gameObject, raycastHit.point, gameObject.transform.rotation).transform;
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

	// Token: 0x06000716 RID: 1814 RVA: 0x0002366C File Offset: 0x0002186C
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

	// Token: 0x06000717 RID: 1815 RVA: 0x000236CC File Offset: 0x000218CC
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

	// Token: 0x0400069C RID: 1692
	private List<int> toSurface;

	// Token: 0x0400069D RID: 1693
	private List<int> notSurfacing;

	// Token: 0x0400069E RID: 1694
	private Transform[] children;

	// Token: 0x0400069F RID: 1695
	private Vector3 startHeight;

	// Token: 0x040006A0 RID: 1696
	public Material[] mats;

	// Token: 0x040006A1 RID: 1697
	public GameObject[] trees;

	// Token: 0x040006A2 RID: 1698
	private int a;

	// Token: 0x040006A3 RID: 1699
	public LayerMask whatIsGround;

	// Token: 0x040006A4 RID: 1700
	public Vector3 drawArea;
}
