using System;
using UnityEngine;

// Token: 0x0200009B RID: 155
public class DoorInteractable : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060003BA RID: 954 RVA: 0x00013B7B File Offset: 0x00011D7B
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x060003BB RID: 955 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060003BC RID: 956 RVA: 0x00013B88 File Offset: 0x00011D88
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

	// Token: 0x060003BD RID: 957 RVA: 0x00013BB8 File Offset: 0x00011DB8
	private void Update()
	{
		this.pivot.rotation = Quaternion.Lerp(this.pivot.rotation, Quaternion.Euler(0f, this.desiredYRotation, 0f), Time.deltaTime * 5f);
	}

	// Token: 0x060003BE RID: 958 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x060003BF RID: 959 RVA: 0x000030D7 File Offset: 0x000012D7
	public void RemoveObject()
	{
	}

	// Token: 0x060003C0 RID: 960 RVA: 0x00013BF5 File Offset: 0x00011DF5
	private void OnDestroy()
	{
		MonoBehaviour.print("door destroyed");
		ResourceManager.Instance.RemoveItem(this.id);
	}

	// Token: 0x060003C1 RID: 961 RVA: 0x00013C11 File Offset: 0x00011E11
	public string GetName()
	{
		if (this.opened)
		{
			return "Close Door";
		}
		return "Open Door";
	}

	// Token: 0x060003C2 RID: 962 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x060003C3 RID: 963 RVA: 0x00013C26 File Offset: 0x00011E26
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060003C4 RID: 964 RVA: 0x00013C2F File Offset: 0x00011E2F
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400039F RID: 927
	private int id;

	// Token: 0x040003A0 RID: 928
	private bool opened;

	// Token: 0x040003A1 RID: 929
	private float desiredYRotation;

	// Token: 0x040003A2 RID: 930
	public Transform pivot;
}
