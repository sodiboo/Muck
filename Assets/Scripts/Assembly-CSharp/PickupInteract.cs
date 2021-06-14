using System;
using UnityEngine;

// Token: 0x02000090 RID: 144
public class PickupInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x0600033E RID: 830 RVA: 0x0000459B File Offset: 0x0000279B
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x0600033F RID: 831 RVA: 0x000045BA File Offset: 0x000027BA
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x06000340 RID: 832 RVA: 0x00013390 File Offset: 0x00011590
	public void LocalExecute()
	{
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.item, this.amount);
		InventoryUI.Instance.AddItemToInventory(inventoryItem);
	}

	// Token: 0x06000341 RID: 833 RVA: 0x000045C7 File Offset: 0x000027C7
	public void AllExecute()
	{
		this.RemoveObject();
	}

	// Token: 0x06000342 RID: 834 RVA: 0x00002147 File Offset: 0x00000347
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x06000343 RID: 835 RVA: 0x000045CF File Offset: 0x000027CF
	public void RemoveObject()
	{
	Destroy(base.gameObject);
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x06000344 RID: 836 RVA: 0x000045ED File Offset: 0x000027ED
	public string GetName()
	{
		return this.item.name + "\n<size=50%>(Press \"E\" to pickup";
	}

	// Token: 0x06000345 RID: 837 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x06000346 RID: 838 RVA: 0x00004604 File Offset: 0x00002804
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000347 RID: 839 RVA: 0x000133C4 File Offset: 0x000115C4
	private void Update()
	{
		this.desiredScale = Vector3.Lerp(this.desiredScale, this.defaultScale, Time.deltaTime * 15f);
		this.desiredScale.y = this.defaultScale.y;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 15f);
	}

	// Token: 0x06000348 RID: 840 RVA: 0x0000460D File Offset: 0x0000280D
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400031C RID: 796
	public InventoryItem item;

	// Token: 0x0400031D RID: 797
	public int amount;

	// Token: 0x0400031E RID: 798
	public int id;

	// Token: 0x0400031F RID: 799
	private Vector3 defaultScale;

	// Token: 0x04000320 RID: 800
	private Vector3 desiredScale;
}
