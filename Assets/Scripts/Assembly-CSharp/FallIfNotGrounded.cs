using System;
using UnityEngine;

// Token: 0x0200002B RID: 43
public class FallIfNotGrounded : MonoBehaviour
{
	// Token: 0x060000E7 RID: 231 RVA: 0x0000ABF0 File Offset: 0x00008DF0
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
		base.InvokeRepeating(nameof(CheckFalling), 1f, 1f);
	}

	// Token: 0x060000E8 RID: 232 RVA: 0x0000ACBC File Offset: 0x00008EBC
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

	// Token: 0x060000E9 RID: 233 RVA: 0x0000AD38 File Offset: 0x00008F38
	private void StartFalling()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.maxHp, 0f, 0, base.transform.position);
		this.falling = true;
		this.rb = base.gameObject.AddComponent<Rigidbody>();
		this.rb.isKinematic = false;
		this.rb.constraints = (RigidbodyConstraints)122;
	}

	// Token: 0x060000EA RID: 234 RVA: 0x00002C87 File Offset: 0x00000E87
	private void Land()
	{
	Destroy(this.rb);
		this.falling = false;
	}

	// Token: 0x040000EB RID: 235
	private Rigidbody rb;

	// Token: 0x040000EC RID: 236
	public float x;

	// Token: 0x040000ED RID: 237
	public float z;

	// Token: 0x040000EE RID: 238
	private bool falling;

	// Token: 0x040000EF RID: 239
	private Vector3 bottomOffset;

	// Token: 0x040000F0 RID: 240
	public LayerMask whatIsLandable;

	// Token: 0x040000F1 RID: 241
	private Mesh mesh;

	// Token: 0x040000F2 RID: 242
	private Collider c;
}
