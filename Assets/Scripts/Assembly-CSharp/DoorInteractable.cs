
using UnityEngine;

// Token: 0x02000075 RID: 117
public class DoorInteractable : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060002DF RID: 735 RVA: 0x0000F35B File Offset: 0x0000D55B
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x060002E0 RID: 736 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x060002E1 RID: 737 RVA: 0x0000F368 File Offset: 0x0000D568
	public void AllExecute()
	{
		this.opened = !this.opened;
		if (this.opened)
		{
			this.desiredYRotation = 90f;
			return;
		}
		this.desiredYRotation = 0f;
	}

	// Token: 0x060002E2 RID: 738 RVA: 0x0000F398 File Offset: 0x0000D598
	private void Update()
	{
		this.pivot.rotation = Quaternion.Lerp(this.pivot.rotation, Quaternion.Euler(0f, this.desiredYRotation, 0f), Time.deltaTime * 5f);
	}

	// Token: 0x060002E3 RID: 739 RVA: 0x0000276E File Offset: 0x0000096E
	public void ServerExecute()
	{
	}

	// Token: 0x060002E4 RID: 740 RVA: 0x0000276E File Offset: 0x0000096E
	public void RemoveObject()
	{
	}

	// Token: 0x060002E5 RID: 741 RVA: 0x0000F3D5 File Offset: 0x0000D5D5
	private void OnDestroy()
	{
		MonoBehaviour.print("door destroyed");
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x060002E6 RID: 742 RVA: 0x0000F3F1 File Offset: 0x0000D5F1
	public string GetName()
	{
		if (this.opened)
		{
			return "Close Door";
		}
		return "Open Door";
	}

	// Token: 0x060002E7 RID: 743 RVA: 0x0000F406 File Offset: 0x0000D606
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060002E8 RID: 744 RVA: 0x0000F40F File Offset: 0x0000D60F
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040002A7 RID: 679
	private int id;

	// Token: 0x040002A8 RID: 680
	private bool opened;

	// Token: 0x040002A9 RID: 681
	private float desiredYRotation;

	// Token: 0x040002AA RID: 682
	public Transform pivot;
}
