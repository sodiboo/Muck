
using UnityEngine;

// Token: 0x020000DE RID: 222
public class ShrineRespawn : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x06000697 RID: 1687 RVA: 0x0000276E File Offset: 0x0000096E
	private void Start()
	{
	}

	// Token: 0x06000698 RID: 1688 RVA: 0x00021721 File Offset: 0x0001F921
	public void Interact()
	{
		RespawnTotemUI.Instance.Show();
	}

	// Token: 0x06000699 RID: 1689 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x0600069A RID: 1690 RVA: 0x0000276E File Offset: 0x0000096E
	public void AllExecute()
	{
	}

	// Token: 0x0600069B RID: 1691 RVA: 0x0000276E File Offset: 0x0000096E
	public void ServerExecute()
	{
	}

	// Token: 0x0600069C RID: 1692 RVA: 0x000057CD File Offset: 0x000039CD
	public void RemoveObject()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x0600069D RID: 1693 RVA: 0x0002172D File Offset: 0x0001F92D
	public string GetName()
	{
		return "Revive the homies";
	}

	// Token: 0x0600069E RID: 1694 RVA: 0x00021734 File Offset: 0x0001F934
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600069F RID: 1695 RVA: 0x0002173D File Offset: 0x0001F93D
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000643 RID: 1603
	private int id;
}
