using System;
using UnityEngine;

// Token: 0x0200009A RID: 154
public class CraftingInteract : MonoBehaviour, Interactable
{
	// Token: 0x060003B2 RID: 946 RVA: 0x00013B3B File Offset: 0x00011D3B
	public void Interact()
	{
		OtherInput.Instance.ToggleInventory(this.state);
	}

	// Token: 0x060003B3 RID: 947 RVA: 0x00013B4D File Offset: 0x00011D4D
	public void LocalExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060003B4 RID: 948 RVA: 0x00013B4D File Offset: 0x00011D4D
	public void AllExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060003B5 RID: 949 RVA: 0x00013B4D File Offset: 0x00011D4D
	public void ServerExecute(int fromClient)
	{
		throw new NotImplementedException();
	}

	// Token: 0x060003B6 RID: 950 RVA: 0x00013B4D File Offset: 0x00011D4D
	public void RemoveObject()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060003B7 RID: 951 RVA: 0x00013B54 File Offset: 0x00011D54
	public string GetName()
	{
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to use)", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x060003B8 RID: 952 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0400039E RID: 926
	public OtherInput.CraftingState state;
}
