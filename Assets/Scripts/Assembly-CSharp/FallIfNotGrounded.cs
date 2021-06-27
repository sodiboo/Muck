using System;
using UnityEngine;

// Token: 0x02000034 RID: 52
public class FallIfNotGrounded : MonoBehaviour
{
	// Token: 0x06000130 RID: 304 RVA: 0x000079C0 File Offset: 0x00005BC0
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

	// Token: 0x06000131 RID: 305 RVA: 0x00007A8C File Offset: 0x00005C8C
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

	// Token: 0x06000132 RID: 306 RVA: 0x00007B08 File Offset: 0x00005D08
	private void StartFalling()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.maxHp, 0f, 0, base.transform.position);
		this.falling = true;
		this.rb = base.gameObject.AddComponent<Rigidbody>();
		this.rb.isKinematic = false;
		this.rb.constraints = (RigidbodyConstraints)122;
	}

	// Token: 0x06000133 RID: 307 RVA: 0x00007B68 File Offset: 0x00005D68
	private void Land()
	{
		Destroy(this.rb);
		this.falling = false;
	}

	// Token: 0x04000133 RID: 307
	private Rigidbody rb;

	// Token: 0x04000134 RID: 308
	public float x;

	// Token: 0x04000135 RID: 309
	public float z;

	// Token: 0x04000136 RID: 310
	private bool falling;

	// Token: 0x04000137 RID: 311
	private Vector3 bottomOffset;

	// Token: 0x04000138 RID: 312
	public LayerMask whatIsLandable;

	// Token: 0x04000139 RID: 313
	private Mesh mesh;

	// Token: 0x0400013A RID: 314
	private Collider c;
}
