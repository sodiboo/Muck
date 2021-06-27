using System;
using UnityEngine;

// Token: 0x0200010A RID: 266
public class ShrineRespawn : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x060007D1 RID: 2001 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Start()
	{
	}

	// Token: 0x060007D2 RID: 2002 RVA: 0x00027D63 File Offset: 0x00025F63
	public void Interact()
	{
		RespawnTotemUI.Instance.Show();
	}

	// Token: 0x060007D3 RID: 2003 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060007D4 RID: 2004 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AllExecute()
	{
	}

	// Token: 0x060007D5 RID: 2005 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x060007D6 RID: 2006 RVA: 0x00006759 File Offset: 0x00004959
	public void RemoveObject()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x060007D7 RID: 2007 RVA: 0x00027D6F File Offset: 0x00025F6F
	public string GetName()
	{
		return "Revive the homies";
	}

	// Token: 0x060007D8 RID: 2008 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x060007D9 RID: 2009 RVA: 0x00027D76 File Offset: 0x00025F76
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060007DA RID: 2010 RVA: 0x00027D7F File Offset: 0x00025F7F
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400077E RID: 1918
	private int id;
}
