using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200000A RID: 10
public class BuildDestruction : MonoBehaviour
{
	// Token: 0x06000041 RID: 65 RVA: 0x000035CB File Offset: 0x000017CB
	private void Awake()
	{
		Invoke(nameof(CheckDirectlyGrounded), 2f);
	}

	// Token: 0x06000042 RID: 66 RVA: 0x000035E0 File Offset: 0x000017E0
	private void Start()
	{
		foreach (BoxCollider boxCollider in base.GetComponents<BoxCollider>())
		{
			if (boxCollider.isTrigger)
			{
				this.trigger = boxCollider;
				break;
			}
		}
		this.trigger.size *= 1.1f;
	}

	// Token: 0x06000043 RID: 67 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x06000044 RID: 68 RVA: 0x00003634 File Offset: 0x00001834
	private void OnDestroy()
	{
		this.destroyed = true;
		List<BuildDestruction> list = new List<BuildDestruction>();
		list.Add(this);
		for (int i = this.otherBuilds.Count - 1; i >= 0; i--)
		{
			if (!(this.otherBuilds[i] == null) && !this.otherBuilds[i].IsDirectlyGrounded(list))
			{
				this.otherBuilds[i].DestroyBuild();
			}
		}
	}

	// Token: 0x06000045 RID: 69 RVA: 0x000036A6 File Offset: 0x000018A6
	private void DestroyBuild()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.hp, 1f, 1, base.transform.position);
	}

	// Token: 0x06000046 RID: 70 RVA: 0x000036CC File Offset: 0x000018CC
	public bool IsDirectlyGrounded(List<BuildDestruction> alreadyChecked)
	{
		if (this.directlyGrounded)
		{
			return true;
		}
		foreach (BuildDestruction buildDestruction in this.otherBuilds)
		{
			if (!(buildDestruction == null) && !alreadyChecked.Contains(buildDestruction))
			{
				alreadyChecked.Add(buildDestruction);
				if (buildDestruction.IsDirectlyGrounded(alreadyChecked))
				{
					return true;
				}
			}
		}
		return false;
	}

	// Token: 0x06000047 RID: 71 RVA: 0x0000374C File Offset: 0x0000194C
	private void CheckDirectlyGrounded()
	{
		var component = base.GetComponent<Rigidbody>();
		Destroy(this.trigger);
		Destroy(component);
	}

	// Token: 0x06000048 RID: 72 RVA: 0x00003764 File Offset: 0x00001964
	private void OnTriggerEnter(Collider collision)
	{
		if (collision.gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			this.directlyGrounded = true;
			this.connectedToGround = true;
		}
		if (collision.CompareTag("Build"))
		{
			BuildDestruction component = collision.GetComponent<BuildDestruction>();
			if (!this.otherBuilds.Contains(component))
			{
				MonoBehaviour.print("added a build: " + collision.gameObject.name);
				this.otherBuilds.Add(component);
			}
		}
	}

	// Token: 0x06000049 RID: 73 RVA: 0x000037E0 File Offset: 0x000019E0
	private void OnDrawGizmos()
	{
	}

	// Token: 0x04000042 RID: 66
	public bool connectedToGround;

	// Token: 0x04000043 RID: 67
	public bool directlyGrounded;

	// Token: 0x04000044 RID: 68
	public bool started;

	// Token: 0x04000045 RID: 69
	public bool destroyed;

	// Token: 0x04000046 RID: 70
	private List<BuildDestruction> otherBuilds = new List<BuildDestruction>();

	// Token: 0x04000047 RID: 71
	private BoxCollider trigger;
}
