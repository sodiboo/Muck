
using UnityEngine;
using UnityEngine.EventSystems;

// Token: 0x02000100 RID: 256
public class UpdateArmor : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	// Token: 0x0600077A RID: 1914 RVA: 0x00025051 File Offset: 0x00023251
	private void Awake()
	{
		this.cell = base.GetComponent<InventoryCell>();
	}

	// Token: 0x0600077B RID: 1915 RVA: 0x00025060 File Offset: 0x00023260
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

	// Token: 0x04000706 RID: 1798
	private InventoryCell cell;
}
