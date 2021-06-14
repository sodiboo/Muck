using System;
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000157 RID: 343
public class UpdateArmor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x06000839 RID: 2105 RVA: 0x000075E9 File Offset: 0x000057E9
	private void Awake()
	{
		this.cell = base.GetComponent<InventoryCell>();
	}

	// Token: 0x0600083A RID: 2106 RVA: 0x0002818C File Offset: 0x0002638C
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

	// Token: 0x04000879 RID: 2169
	private InventoryCell cell;
}
