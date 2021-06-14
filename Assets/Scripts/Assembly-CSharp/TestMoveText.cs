using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000145 RID: 325
public class TestMoveText : MonoBehaviour
{
	// Token: 0x060007D0 RID: 2000 RVA: 0x00026914 File Offset: 0x00024B14
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
		base.InvokeRepeating(nameof(SlowUpdate), num2, num);
		base.InvokeRepeating(nameof(AddMaterial), num * (float)base.transform.childCount + num2 + 2f, 0.05f);
	}

	// Token: 0x060007D1 RID: 2001 RVA: 0x00026A00 File Offset: 0x00024C00
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
				Transform transform =Instantiate<GameObject>(gameObject, raycastHit.point, gameObject.transform.rotation).transform;
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

	// Token: 0x060007D2 RID: 2002 RVA: 0x00026BB4 File Offset: 0x00024DB4
	private void SlowUpdate()
	{
		int index = Random.Range(0, this.notSurfacing.Count);
		int item = this.notSurfacing[index];
		this.toSurface.Add(item);
		this.notSurfacing.Remove(item);
		if (this.notSurfacing.Count <= 0)
		{
			base.CancelInvoke(nameof(SlowUpdate));
		}
	}

	// Token: 0x060007D3 RID: 2003 RVA: 0x00026C14 File Offset: 0x00024E14
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

	// Token: 0x04000802 RID: 2050
	private List<int> toSurface;

	// Token: 0x04000803 RID: 2051
	private List<int> notSurfacing;

	// Token: 0x04000804 RID: 2052
	private Transform[] children;

	// Token: 0x04000805 RID: 2053
	private Vector3 startHeight;

	// Token: 0x04000806 RID: 2054
	public Material[] mats;

	// Token: 0x04000807 RID: 2055
	public GameObject[] trees;

	// Token: 0x04000808 RID: 2056
	private int a;

	// Token: 0x04000809 RID: 2057
	public LayerMask whatIsGround;

	// Token: 0x0400080A RID: 2058
	public Vector3 drawArea;
}
