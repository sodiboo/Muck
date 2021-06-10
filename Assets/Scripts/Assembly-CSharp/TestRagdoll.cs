
using UnityEngine;

// Token: 0x020000F3 RID: 243
public class TestRagdoll : MonoBehaviour
{
	// Token: 0x06000726 RID: 1830 RVA: 0x00023A32 File Offset: 0x00021C32
	private void Awake()
	{
		this.cow = base.transform.GetChild(0);
	}

	// Token: 0x06000727 RID: 1831 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x06000728 RID: 1832 RVA: 0x0000276E File Offset: 0x0000096E
	private void Test()
	{
	}

	// Token: 0x06000729 RID: 1833 RVA: 0x00023A48 File Offset: 0x00021C48
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

	// Token: 0x0600072A RID: 1834 RVA: 0x00023AE0 File Offset: 0x00021CE0
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

	// Token: 0x0600072B RID: 1835 RVA: 0x00023B40 File Offset: 0x00021D40
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
		MonoBehaviour.print("problem is here: " + p.name);
		p.gameObject.AddComponent<SphereCollider>().material = this.mat;
		if (parent != null)
		{
			CharacterJoint characterJoint = p.gameObject.AddComponent<CharacterJoint>();
			characterJoint.connectedBody = parent;
			characterJoint.enableProjection = true;
		}
	}

	// Token: 0x040006BC RID: 1724
	private Transform cow;

	// Token: 0x040006BD RID: 1725
	public PhysicMaterial mat;
}
