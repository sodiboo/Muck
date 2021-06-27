using System;
using UnityEngine;

// Token: 0x02000122 RID: 290
public class TestRagdoll : MonoBehaviour
{
	// Token: 0x06000868 RID: 2152 RVA: 0x0002A30A File Offset: 0x0002850A
	private void Awake()
	{
		this.cow = base.transform.GetChild(0);
	}

	// Token: 0x06000869 RID: 2153 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x0600086A RID: 2154 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Test()
	{
	}

	// Token: 0x0600086B RID: 2155 RVA: 0x0002A320 File Offset: 0x00028520
	public void MakeRagdoll(Vector3 dir)
	{
		Animator component = base.GetComponent<Animator>();
		if (component)
		{
			component.enabled = false;
		}
		this.cow.SetParent(null);
		Transform child = this.cow.GetChild(0);
		this.AddComponents(child, null, dir);
		this.Ragdoll(child, dir);
		this.cow.gameObject.AddComponent<DestroyObject>().time = 10f;
		this.cow.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
		child.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
	}

	// Token: 0x0600086C RID: 2156 RVA: 0x0002A3B8 File Offset: 0x000285B8
	private void Ragdoll(Transform part, Vector3 dir)
	{
		part.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
		for (int i = 0; i < part.childCount; i++)
		{
			Transform child = part.GetChild(i);
			if (!child.CompareTag("Ignore"))
			{
				this.AddComponents(child, part.GetComponent<Rigidbody>(), dir);
				this.Ragdoll(child, dir);
			}
		}
	}

	// Token: 0x0600086D RID: 2157 RVA: 0x0002A418 File Offset: 0x00028618
	private void AddComponents(Transform p, Rigidbody parent, Vector3 dir)
	{
		p.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
		Rigidbody rigidbody = p.gameObject.AddComponent<Rigidbody>();
		if (!rigidbody)
		{
			rigidbody = p.GetComponent<Rigidbody>();
			rigidbody.isKinematic = false;
			rigidbody.useGravity = true;
		}
		rigidbody.velocity = -dir.normalized * 8f;
		rigidbody.interpolation = RigidbodyInterpolation.Interpolate;
		rigidbody.angularDrag = 1f;
		rigidbody.drag = 0.2f;
		p.gameObject.AddComponent<SphereCollider>().material = this.mat;
		if (parent != null)
		{
			CharacterJoint characterJoint = p.gameObject.AddComponent<CharacterJoint>();
			characterJoint.connectedBody = parent;
			characterJoint.enableProjection = true;
		}
	}

	// Token: 0x04000801 RID: 2049
	private Transform cow;

	// Token: 0x04000802 RID: 2050
	public PhysicMaterial mat;
}
