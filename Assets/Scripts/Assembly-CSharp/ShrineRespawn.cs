using System;
using UnityEngine;

// Token: 0x0200012A RID: 298
public class ShrineRespawn : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x06000743 RID: 1859 RVA: 0x00002147 File Offset: 0x00000347
	private void Start()
	{
	}

	// Token: 0x06000744 RID: 1860 RVA: 0x00006CC2 File Offset: 0x00004EC2
	public void Interact()
	{
		RespawnTotemUI.Instance.Show();
	}

	// Token: 0x06000745 RID: 1861 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x06000746 RID: 1862 RVA: 0x00002147 File Offset: 0x00000347
	public void AllExecute()
	{
	}

	// Token: 0x06000747 RID: 1863 RVA: 0x00002147 File Offset: 0x00000347
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x06000748 RID: 1864 RVA: 0x00002AC8 File Offset: 0x00000CC8
	public void RemoveObject()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x06000749 RID: 1865 RVA: 0x00006CCE File Offset: 0x00004ECE
	public string GetName()
	{
		return "Revive the homies";
	}

	// Token: 0x0600074A RID: 1866 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0600074B RID: 1867 RVA: 0x00006CD5 File Offset: 0x00004ED5
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600074C RID: 1868 RVA: 0x00006CDE File Offset: 0x00004EDE
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400078E RID: 1934
	private int id;
}
