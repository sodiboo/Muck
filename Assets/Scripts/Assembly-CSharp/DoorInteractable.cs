using System;
using UnityEngine;

// Token: 0x0200008D RID: 141
public class DoorInteractable : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x0600031B RID: 795 RVA: 0x00004394 File Offset: 0x00002594
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x0600031C RID: 796 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x0600031D RID: 797 RVA: 0x000043A1 File Offset: 0x000025A1
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

	// Token: 0x0600031E RID: 798 RVA: 0x000043D1 File Offset: 0x000025D1
	private void Update()
	{
		this.pivot.rotation = Quaternion.Lerp(this.pivot.rotation, Quaternion.Euler(0f, this.desiredYRotation, 0f), Time.deltaTime * 5f);
	}

	// Token: 0x0600031F RID: 799 RVA: 0x00002147 File Offset: 0x00000347
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x06000320 RID: 800 RVA: 0x00002147 File Offset: 0x00000347
	public void RemoveObject()
	{
	}

	// Token: 0x06000321 RID: 801 RVA: 0x0000440E File Offset: 0x0000260E
	private void OnDestroy()
	{
		MonoBehaviour.print("door destroyed");
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x06000322 RID: 802 RVA: 0x0000442A File Offset: 0x0000262A
	public string GetName()
	{
		if (this.opened)
		{
			return "Close Door";
		}
		return "Open Door";
	}

	// Token: 0x06000323 RID: 803 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x06000324 RID: 804 RVA: 0x0000443F File Offset: 0x0000263F
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000325 RID: 805 RVA: 0x00004448 File Offset: 0x00002648
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400030B RID: 779
	private int id;

	// Token: 0x0400030C RID: 780
	private bool opened;

	// Token: 0x0400030D RID: 781
	private float desiredYRotation;

	// Token: 0x0400030E RID: 782
	public Transform pivot;
}
