
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000007 RID: 7
public class BuildDestruction : MonoBehaviour
{
	// Token: 0x06000015 RID: 21 RVA: 0x0000270A File Offset: 0x0000090A
	private void Awake()
	{
		base.Invoke("CheckDirectlyGrounded", 2f);
	}

	// Token: 0x06000016 RID: 22 RVA: 0x0000271C File Offset: 0x0000091C
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

	// Token: 0x06000017 RID: 23 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x06000018 RID: 24 RVA: 0x00002770 File Offset: 0x00000970
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

	// Token: 0x06000019 RID: 25 RVA: 0x000027E2 File Offset: 0x000009E2
	private void DestroyBuild()
	{
		Hitable component = base.GetComponent<Hitable>();
		component.Hit(component.hp, 1f, 1, base.transform.position);
	}

	// Token: 0x0600001A RID: 26 RVA: 0x00002808 File Offset: 0x00000A08
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

	// Token: 0x0600001B RID: 27 RVA: 0x00002888 File Offset: 0x00000A88
	private void CheckDirectlyGrounded()
	{
		Object component = base.GetComponent<Rigidbody>();
	Destroy(this.trigger);
	Destroy(component);
	}

	// Token: 0x0600001C RID: 28 RVA: 0x000028A0 File Offset: 0x00000AA0
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

	// Token: 0x0600001D RID: 29 RVA: 0x0000291C File Offset: 0x00000B1C
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0400001A RID: 26
	public bool connectedToGround;

	// Token: 0x0400001B RID: 27
	public bool directlyGrounded;

	// Token: 0x0400001C RID: 28
	public bool started;

	// Token: 0x0400001D RID: 29
	public bool destroyed;

	// Token: 0x0400001E RID: 30
	private List<BuildDestruction> otherBuilds = new List<BuildDestruction>();

	// Token: 0x0400001F RID: 31
	private BoxCollider trigger;
}
