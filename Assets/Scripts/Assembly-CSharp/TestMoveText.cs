using System.Collections.Generic;
using UnityEngine;

public class TestMoveText : MonoBehaviour
{
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

	private List<int> toSurface;

	private List<int> notSurfacing;

	private Transform[] children;

	private Vector3 startHeight;

	public Material[] mats;

	public GameObject[] trees;

	private int a;

	public LayerMask whatIsGround;

	public Vector3 drawArea;
}
