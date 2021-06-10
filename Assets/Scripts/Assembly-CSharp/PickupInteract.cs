
using UnityEngine;

// Token: 0x02000078 RID: 120
public class PickupInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060002FF RID: 767 RVA: 0x0000F5F0 File Offset: 0x0000D7F0
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
		this.desiredScale = this.defaultScale;
	}

	// Token: 0x06000300 RID: 768 RVA: 0x0000F60F File Offset: 0x0000D80F
	public void Interact()
	{
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x06000301 RID: 769 RVA: 0x0000F61C File Offset: 0x0000D81C
	public void LocalExecute()
	{
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(this.item, this.amount);
		InventoryUI.Instance.AddItemToInventory(inventoryItem);
	}

	// Token: 0x06000302 RID: 770 RVA: 0x0000F64D File Offset: 0x0000D84D
	public void AllExecute()
	{
		this.RemoveObject();
	}

	// Token: 0x06000303 RID: 771 RVA: 0x0000276E File Offset: 0x0000096E
	public void ServerExecute()
	{
	}

	// Token: 0x06000304 RID: 772 RVA: 0x0000F655 File Offset: 0x0000D855
	public void RemoveObject()
	{
	Destroy(base.gameObject);
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x06000305 RID: 773 RVA: 0x0000F673 File Offset: 0x0000D873
	public string GetName()
	{
		return this.item.name + "\n<size=50%>(Press \"E\" to pickup";
	}

	// Token: 0x06000306 RID: 774 RVA: 0x0000F68A File Offset: 0x0000D88A
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000307 RID: 775 RVA: 0x0000F694 File Offset: 0x0000D894
	private void Update()
	{
		this.desiredScale = Vector3.Lerp(this.desiredScale, this.defaultScale, Time.deltaTime * 15f);
		this.desiredScale.y = this.defaultScale.y;
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 15f);
	}

	// Token: 0x06000308 RID: 776 RVA: 0x0000F705 File Offset: 0x0000D905
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040002B8 RID: 696
	public InventoryItem item;

	// Token: 0x040002B9 RID: 697
	public int amount;

	// Token: 0x040002BA RID: 698
	public int id;

	// Token: 0x040002BB RID: 699
	private Vector3 defaultScale;

	// Token: 0x040002BC RID: 700
	private Vector3 desiredScale;
}
