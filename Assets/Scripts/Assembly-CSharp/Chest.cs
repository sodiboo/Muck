using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000012 RID: 18
public class Chest : MonoBehaviour
{
	// Token: 0x17000005 RID: 5
	// (get) Token: 0x0600005C RID: 92 RVA: 0x0000238E File Offset: 0x0000058E
	// (set) Token: 0x0600005D RID: 93 RVA: 0x00002396 File Offset: 0x00000596
	public int id { get; set; }

	// Token: 0x0600005E RID: 94 RVA: 0x00008FC8 File Offset: 0x000071C8
	private void Start()
	{
		this.locked = new bool[this.chestSize];
		this.animator = base.GetComponent<Animator>();
		if (this.cells == null || this.cells.Length == 0)
		{
			this.cells = new InventoryItem[this.chestSize];
		}
	}

	// Token: 0x0600005F RID: 95 RVA: 0x0000239F File Offset: 0x0000059F
	public void Use(bool b)
	{
		if (this.animator)
		{
			this.animator.SetBool("Use", b);
		}
		this.inUse = b;
	}

	// Token: 0x06000060 RID: 96 RVA: 0x000023C6 File Offset: 0x000005C6
	public bool IsUsed()
	{
		return this.inUse;
	}

	// Token: 0x06000061 RID: 97 RVA: 0x00002147 File Offset: 0x00000347
	public virtual void UpdateCraftables()
	{
	}

	// Token: 0x06000062 RID: 98 RVA: 0x00009014 File Offset: 0x00007214
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

	// Token: 0x0400005D RID: 93
	public InventoryItem[] cells;

	// Token: 0x0400005F RID: 95
	public int chestSize = 21;

	// Token: 0x04000060 RID: 96
	public bool inUse;

	// Token: 0x04000061 RID: 97
	public bool[] locked;

	// Token: 0x04000062 RID: 98
	private Animator animator;
}
