
using UnityEngine;

// Token: 0x02000073 RID: 115
public class ChestInteract : MonoBehaviour, Interactable
{
	// Token: 0x060002CF RID: 719 RVA: 0x0000F258 File Offset: 0x0000D458
	private void Awake()
	{
		this.chest = base.GetComponent<Chest>();
		this.ready = true;
	}

	// Token: 0x060002D0 RID: 720 RVA: 0x0000F26D File Offset: 0x0000D46D
	public void Interact()
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		base.Invoke("GetReady", this.cooldownTime);
		ClientSend.RequestChest(this.chest.id, true);
	}

	// Token: 0x060002D1 RID: 721 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x060002D2 RID: 722 RVA: 0x0000276E File Offset: 0x0000096E
	public void AllExecute()
	{
	}

	// Token: 0x060002D3 RID: 723 RVA: 0x0000276E File Offset: 0x0000096E
	public void ServerExecute()
	{
	}

	// Token: 0x060002D4 RID: 724 RVA: 0x0000276E File Offset: 0x0000096E
	public void RemoveObject()
	{
	}

	// Token: 0x060002D5 RID: 725 RVA: 0x0000F2A4 File Offset: 0x0000D4A4
	public string GetName()
	{
		if (this.chest.inUse)
		{
			return this.state.ToString() + "\n<size=50%>(Someone is already using it..)";
		}
		return string.Format("{0}\n<size=50%>(Press \"{1}\" to open", this.state.ToString(), InputManager.interact);
	}

	// Token: 0x060002D6 RID: 726 RVA: 0x0000F2FF File Offset: 0x0000D4FF
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x040002A2 RID: 674
	public OtherInput.CraftingState state;

	// Token: 0x040002A3 RID: 675
	private Chest chest;

	// Token: 0x040002A4 RID: 676
	private float cooldownTime = 0.5f;

	// Token: 0x040002A5 RID: 677
	private bool ready;
}
