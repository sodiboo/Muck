using System;
using UnityEngine;

// Token: 0x02000099 RID: 153
public class ChestInteract : MonoBehaviour, Interactable
{
	// Token: 0x060003A8 RID: 936 RVA: 0x00013A78 File Offset: 0x00011C78
	private void Awake()
	{
		this.chest = base.GetComponent<Chest>();
		this.ready = true;
	}

	// Token: 0x060003A9 RID: 937 RVA: 0x00013A8D File Offset: 0x00011C8D
	public void Interact()
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		Invoke(nameof(GetReady), this.cooldownTime);
		ClientSend.RequestChest(this.chest.id, true);
	}

	// Token: 0x060003AA RID: 938 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060003AB RID: 939 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AllExecute()
	{
	}

	// Token: 0x060003AC RID: 940 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x060003AD RID: 941 RVA: 0x000030D7 File Offset: 0x000012D7
	public void RemoveObject()
	{
	}

	// Token: 0x060003AE RID: 942 RVA: 0x00013AC4 File Offset: 0x00011CC4
	public string GetName()
	{
		if (this.chest.inUse)
		{
			return this.state.ToString() + "\n<size=50%>(Someone is already using it..)";
		}
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to open", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x060003AF RID: 943 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x060003B0 RID: 944 RVA: 0x00013B1F File Offset: 0x00011D1F
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x0400039A RID: 922
	public OtherInput.CraftingState state;

	// Token: 0x0400039B RID: 923
	private Chest chest;

	// Token: 0x0400039C RID: 924
	private float cooldownTime = 0.5f;

	// Token: 0x0400039D RID: 925
	private bool ready;
}
