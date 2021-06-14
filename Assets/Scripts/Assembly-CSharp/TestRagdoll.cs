using System;
using UnityEngine;

// Token: 0x02000147 RID: 327
public class TestRagdoll : MonoBehaviour
{
	// Token: 0x060007E2 RID: 2018 RVA: 0x000072F4 File Offset: 0x000054F4
	private void Awake()
	{
		this.cow = base.transform.GetChild(0);
	}

	// Token: 0x060007E3 RID: 2019 RVA: 0x00002147 File Offset: 0x00000347
	private void Update()
	{
	}

	// Token: 0x060007E4 RID: 2020 RVA: 0x00002147 File Offset: 0x00000347
	private void Test()
	{
	}

	// Token: 0x060007E5 RID: 2021 RVA: 0x00026E68 File Offset: 0x00025068
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

	// Token: 0x060007E6 RID: 2022 RVA: 0x00026F00 File Offset: 0x00025100
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

	// Token: 0x060007E7 RID: 2023 RVA: 0x00026F60 File Offset: 0x00025160
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

	// Token: 0x04000822 RID: 2082
	private Transform cow;

	// Token: 0x04000823 RID: 2083
	public PhysicMaterial mat;
}
