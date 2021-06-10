
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000010 RID: 16
public class Chest : MonoBehaviour
{
	// Token: 0x17000004 RID: 4
	// (get) Token: 0x06000058 RID: 88 RVA: 0x000041D0 File Offset: 0x000023D0
	// (set) Token: 0x06000059 RID: 89 RVA: 0x000041D8 File Offset: 0x000023D8
	public int id { get; set; }

	// Token: 0x0600005A RID: 90 RVA: 0x000041E4 File Offset: 0x000023E4
	private void Start()
	{
		this.locked = new bool[this.chestSize];
		this.animator = base.GetComponent<Animator>();
		if (this.cells == null || this.cells.Length == 0)
		{
			this.cells = new InventoryItem[this.chestSize];
		}
	}

	// Token: 0x0600005B RID: 91 RVA: 0x00004230 File Offset: 0x00002430
	public void Use(bool b)
	{
		if (this.animator)
		{
			this.animator.SetBool("Use", b);
		}
		this.inUse = b;
	}

	// Token: 0x0600005C RID: 92 RVA: 0x00004257 File Offset: 0x00002457
	public bool IsUsed()
	{
		return this.inUse;
	}

	// Token: 0x0600005D RID: 93 RVA: 0x0000276E File Offset: 0x0000096E
	public virtual void UpdateCraftables()
	{
	}

	// Token: 0x0600005E RID: 94 RVA: 0x00004260 File Offset: 0x00002460
	public void InitChest(List<InventoryItem> items, ConsistentRandom rand)
	{
		this.cells = new InventoryItem[this.chestSize];
		List<int> list = new List<int>();
		for (int i = 0; i < this.chestSize; i++)
		{
			list.Add(i);
		}
		foreach (InventoryItem inventoryItem in items)
		{
			int num = rand.Next(0, list.Count);
			list.Remove(num);
			this.cells[num] = inventoryItem;
		}
	}

	// Token: 0x04000058 RID: 88
	public InventoryItem[] cells;

	// Token: 0x0400005A RID: 90
	public int chestSize = 21;

	// Token: 0x0400005B RID: 91
	public bool inUse;

	// Token: 0x0400005C RID: 92
	public bool[] locked;

	// Token: 0x0400005D RID: 93
	private Animator animator;
}
