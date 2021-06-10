using System;
using UnityEngine;

// Token: 0x02000074 RID: 116
public class CraftingInteract : MonoBehaviour, Interactable
{
	// Token: 0x060002D8 RID: 728 RVA: 0x0000F31B File Offset: 0x0000D51B
	public void Interact()
	{
		OtherInput.Instance.ToggleInventory(this.state);
	}

	// Token: 0x060002D9 RID: 729 RVA: 0x0000F32D File Offset: 0x0000D52D
	public void LocalExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060002DA RID: 730 RVA: 0x0000F32D File Offset: 0x0000D52D
	public void AllExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060002DB RID: 731 RVA: 0x0000F32D File Offset: 0x0000D52D
	public void ServerExecute()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060002DC RID: 732 RVA: 0x0000F32D File Offset: 0x0000D52D
	public void RemoveObject()
	{
		throw new NotImplementedException();
	}

	// Token: 0x060002DD RID: 733 RVA: 0x0000F334 File Offset: 0x0000D534
	public string GetName()
	{
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to use)", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x040002A6 RID: 678
	public OtherInput.CraftingState state;
}
