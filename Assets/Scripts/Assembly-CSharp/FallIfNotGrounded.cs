using System;
using UnityEngine;

public class FallIfNotGrounded : MonoBehaviour
{
	private void Start()
	{
		this.x = base.transform.position.x;
		this.z = base.transform.position.z;
		MeshFilter componentInChildren = base.GetComponentInChildren<MeshFilter>();
		if (componentInChildren)
		{
			this.mesh = componentInChildren.mesh;
		}
		else
		{
			SkinnedMeshRenderer componentInChildren2 = base.GetComponentInChildren<SkinnedMeshRenderer>();
			if (componentInChildren2)
			{
				this.mesh = componentInChildren2.sharedMesh;
			}
		}
		this.c = base.GetComponent<Collider>();
		if (this.c)
		{
			this.bottomOffset = new Vector3(0f, this.c.bounds.extents.y, 0f);
		}
		InvokeRepeating(nameof(CheckFalling), 1f, 1f);
	}

	private void CheckFalling()
	{
		if (this.falling)
		{
			return;
		}
		bool flag = false;
		foreach (RaycastHit raycastHit in Physics.RaycastAll(base.transform.position, Vector3.down, 2f, this.whatIsLandable))
		{
			if (raycastHit.collider.gameObject.layer != LayerMask.NameToLayer("Pickup"))
			{
				flag = true;
			}
		}
		if (!flag)
		{
			this.StartFalling();
		}
	}

	private void StartFalling()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.maxHp, 0f, 0, base.transform.position);
		this.falling = true;
		this.rb = base.gameObject.AddComponent<Rigidbody>();
		this.rb.isKinematic = false;
		this.rb.constraints = (RigidbodyConstraints)122;
	}

	private void Land()
	{
		Destroy(this.rb);
		this.falling = false;
	}

	private Rigidbody rb;

	public float x;

	public float z;

	private bool falling;

	private Vector3 bottomOffset;

	public LayerMask whatIsLandable;

	private Mesh mesh;

	private Collider c;
}
