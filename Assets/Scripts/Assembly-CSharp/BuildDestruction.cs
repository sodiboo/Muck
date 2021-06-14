using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000007 RID: 7
public class BuildDestruction : MonoBehaviour
{
	// Token: 0x06000017 RID: 23 RVA: 0x00002135 File Offset: 0x00000335
	private void Awake()
	{
		base.Invoke(nameof(CheckDirectlyGrounded), 2f);
	}

	// Token: 0x06000018 RID: 24 RVA: 0x00007DD0 File Offset: 0x00005FD0
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

	// Token: 0x06000019 RID: 25 RVA: 0x00002147 File Offset: 0x00000347
	private void Update()
	{
	}

	// Token: 0x0600001A RID: 26 RVA: 0x00007E24 File Offset: 0x00006024
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

	// Token: 0x0600001B RID: 27 RVA: 0x00002149 File Offset: 0x00000349
	private void DestroyBuild()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.hp, 1f, 1, base.transform.position);
	}

	// Token: 0x0600001C RID: 28 RVA: 0x00007E98 File Offset: 0x00006098
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

	// Token: 0x0600001D RID: 29 RVA: 0x0000216D File Offset: 0x0000036D
	private void CheckDirectlyGrounded()
	{
	Destroy(this.trigger);
	Destroy(GetComponent<Rigidbody>());
	}

	// Token: 0x0600001E RID: 30 RVA: 0x00007F18 File Offset: 0x00006118
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

	// Token: 0x0600001F RID: 31 RVA: 0x00007F94 File Offset: 0x00006194
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0400001B RID: 27
	public bool connectedToGround;

	// Token: 0x0400001C RID: 28
	public bool directlyGrounded;

	// Token: 0x0400001D RID: 29
	public bool started;

	// Token: 0x0400001E RID: 30
	public bool destroyed;

	// Token: 0x0400001F RID: 31
	private List<BuildDestruction> otherBuilds = new List<BuildDestruction>();

	// Token: 0x04000020 RID: 32
	private BoxCollider trigger;
}
