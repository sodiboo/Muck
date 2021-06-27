using System;
using UnityEngine;

// Token: 0x0200009E RID: 158
public class PickupInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060003DD RID: 989 RVA: 0x00013E10 File Offset: 0x00012010
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x060003DE RID: 990 RVA: 0x00013E2F File Offset: 0x0001202F
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x060003DF RID: 991 RVA: 0x00013E3C File Offset: 0x0001203C
	public void LocalExecute()
	{
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.item, this.amount);
		InventoryUI.Instance.AddItemToInventory(inventoryItem);
	}

	// Token: 0x060003E0 RID: 992 RVA: 0x00013E6D File Offset: 0x0001206D
	public void AllExecute()
	{
		this.RemoveObject();
	}

	// Token: 0x060003E1 RID: 993 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x060003E2 RID: 994 RVA: 0x00013E75 File Offset: 0x00012075
	public void RemoveObject()
	{
		Destroy(base.gameObject);
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x060003E3 RID: 995 RVA: 0x00013E93 File Offset: 0x00012093
	public string GetName()
	{
		return this.item.name + "\n<size=50%>(Press \"E\" to pickup";
	}

	// Token: 0x060003E4 RID: 996 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x060003E5 RID: 997 RVA: 0x00013EAA File Offset: 0x000120AA
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060003E6 RID: 998 RVA: 0x00013EB4 File Offset: 0x000120B4
	private void Update()
	{
		this.desiredScale = Vector3.Lerp(this.desiredScale, this.defaultScale, Time.deltaTime * 15f);
		this.desiredScale.y = this.defaultScale.y;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 15f);
	}

	// Token: 0x060003E7 RID: 999 RVA: 0x00013F25 File Offset: 0x00012125
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040003B0 RID: 944
	public InventoryItem item;

	// Token: 0x040003B1 RID: 945
	public int amount;

	// Token: 0x040003B2 RID: 946
	public int id;

	// Token: 0x040003B3 RID: 947
	private Vector3 defaultScale;

	// Token: 0x040003B4 RID: 948
	private Vector3 desiredScale;
}
