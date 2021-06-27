using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000016 RID: 22
public class Chest : MonoBehaviour
{
	// Token: 0x1700000A RID: 10
	// (get) Token: 0x0600008C RID: 140 RVA: 0x00004E1C File Offset: 0x0000301C
	// (set) Token: 0x0600008D RID: 141 RVA: 0x00004E24 File Offset: 0x00003024
	public int id { get; set; }

	// Token: 0x0600008E RID: 142 RVA: 0x00004E30 File Offset: 0x00003030
	private void Start()
	{
		this.locked = new bool[this.chestSize];
		this.animator = base.GetComponent<Animator>();
		if (this.cells == null || this.cells.Length == 0)
		{
			this.cells = new InventoryItem[this.chestSize];
		}
	}

	// Token: 0x0600008F RID: 143 RVA: 0x00004E7C File Offset: 0x0000307C
	public void Use(bool b)
	{
		if (this.animator)
		{
			this.animator.SetBool("Use", b);
		}
		this.inUse = b;
	}

	// Token: 0x06000090 RID: 144 RVA: 0x00004EA3 File Offset: 0x000030A3
	public bool IsUsed()
	{
		return this.inUse;
	}

	// Token: 0x06000091 RID: 145 RVA: 0x000030D7 File Offset: 0x000012D7
	public virtual void UpdateCraftables()
	{
	}

	// Token: 0x06000092 RID: 146 RVA: 0x00004EAC File Offset: 0x000030AC
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

	// Token: 0x04000091 RID: 145
	public InventoryItem[] cells;

	// Token: 0x04000093 RID: 147
	public int chestSize = 21;

	// Token: 0x04000094 RID: 148
	public bool inUse;

	// Token: 0x04000095 RID: 149
	public bool[] locked;

	// Token: 0x04000096 RID: 150
	private Animator animator;
}
