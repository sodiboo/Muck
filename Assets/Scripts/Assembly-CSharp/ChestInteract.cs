using System;
using UnityEngine;

// Token: 0x0200008B RID: 139
public class ChestInteract : MonoBehaviour, Interactable
{
	// Token: 0x06000309 RID: 777 RVA: 0x000042EF File Offset: 0x000024EF
	private void Awake()
	{
		this.chest = base.GetComponent<Chest>();
		this.ready = true;
	}

	// Token: 0x0600030A RID: 778 RVA: 0x00004304 File Offset: 0x00002504
	public void Interact()
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		base.Invoke(nameof(GetReady), this.cooldownTime);
		ClientSend.RequestChest(this.chest.id, true);
	}

	// Token: 0x0600030B RID: 779 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x0600030C RID: 780 RVA: 0x00002147 File Offset: 0x00000347
	public void AllExecute()
	{
	}

	// Token: 0x0600030D RID: 781 RVA: 0x00002147 File Offset: 0x00000347
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x0600030E RID: 782 RVA: 0x00002147 File Offset: 0x00000347
	public void RemoveObject()
	{
	}

	// Token: 0x0600030F RID: 783 RVA: 0x000132A8 File Offset: 0x000114A8
	public string GetName()
	{
		if (this.chest.inUse)
		{
			return this.state.ToString() + "\n<size=50%>(Someone is already using it..)";
		}
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to open", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x06000310 RID: 784 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x06000311 RID: 785 RVA: 0x00004338 File Offset: 0x00002538
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x04000306 RID: 774
	public OtherInput.CraftingState state;

	// Token: 0x04000307 RID: 775
	private Chest chest;

	// Token: 0x04000308 RID: 776
	private float cooldownTime = 0.5f;

	// Token: 0x04000309 RID: 777
	private bool ready;
}
