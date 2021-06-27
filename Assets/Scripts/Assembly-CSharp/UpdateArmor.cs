using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000131 RID: 305
public class UpdateArmor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x060008C1 RID: 2241 RVA: 0x0002B971 File Offset: 0x00029B71
	private void Awake()
	{
		this.cell = base.GetComponent<InventoryCell>();
	}

	// Token: 0x060008C2 RID: 2242 RVA: 0x0002B980 File Offset: 0x00029B80
	public void OnPointerDown(PointerEventData eventData)
	{
		int itemId;
		if (this.cell.currentItem == null)
		{
			itemId = -1;
		}
		else
		{
			itemId = this.cell.currentItem.id;
		}
		PlayerStatus.Instance.UpdateArmor(base.transform.GetSiblingIndex(), itemId);
		UiSfx.Instance.PlayArmor();
	}

	// Token: 0x0400084E RID: 2126
	private InventoryCell cell;
}
