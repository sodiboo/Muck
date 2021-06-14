using System;
using UnityEngine;

// Token: 0x0200008C RID: 140
public class CraftingInteract : MonoBehaviour, Interactable
{
	// Token: 0x06000313 RID: 787 RVA: 0x00004354 File Offset: 0x00002554
	public void Interact()
	{
		OtherInput.Instance.ToggleInventory(this.state);
	}

	// Token: 0x06000314 RID: 788 RVA: 0x00004366 File Offset: 0x00002566
	public void LocalExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x06000315 RID: 789 RVA: 0x00004366 File Offset: 0x00002566
	public void AllExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x06000316 RID: 790 RVA: 0x00004366 File Offset: 0x00002566
	public void ServerExecute(int fromClient)
	{
		throw new NotImplementedException();
	}

	// Token: 0x06000317 RID: 791 RVA: 0x00004366 File Offset: 0x00002566
	public void RemoveObject()
	{
		throw new NotImplementedException();
	}

	// Token: 0x06000318 RID: 792 RVA: 0x0000436D File Offset: 0x0000256D
	public string GetName()
	{
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to use)", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x06000319 RID: 793 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0400030A RID: 778
	public OtherInput.CraftingState state;
}
