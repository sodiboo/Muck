using System;
using UnityEngine;

// Token: 0x0200008F RID: 143
public class LootContainerInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x0600032E RID: 814 RVA: 0x00004450 File Offset: 0x00002650
	private void Start()
	{
		if (this.testPowerup)
		{
			this.TestSpawn();
		}
		this.ready = true;
		this.basePrice = this.price;
	}

	// Token: 0x0600032F RID: 815 RVA: 0x00004473 File Offset: 0x00002673
	private void OnEnable()
	{
		if (this.opened)
		{
			this.OpenContainer();
		}
	}

	// Token: 0x06000330 RID: 816 RVA: 0x00004483 File Offset: 0x00002683
	private void TestSpawn()
	{
		this.id = LootContainerInteract.totalId++;
		ResourceManager.Instance.AddObject(this.id, base.gameObject);
	}

	// Token: 0x06000331 RID: 817 RVA: 0x000044AE File Offset: 0x000026AE
	public void Interact()
	{
		if (InventoryUI.Instance.GetMoney() < this.price)
		{
			return;
		}
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		InventoryUI.Instance.UseMoney(this.price);
		ClientSend.PickupInteract(this.id);
	}

	// Token: 0x06000332 RID: 818 RVA: 0x000044EE File Offset: 0x000026EE
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000333 RID: 819 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x06000334 RID: 820 RVA: 0x000044F7 File Offset: 0x000026F7
	public void AllExecute()
	{
		this.OpenContainer();
	}

	// Token: 0x06000335 RID: 821 RVA: 0x00013304 File Offset: 0x00011504
	public void ServerExecute(int fromClient)
	{
		if (LocalClient.serverOwner)
		{
			Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(this.white, this.blue, this.gold);
			if (this.testPowerup && this.powerupToTest != null)
			{
				randomPowerup = this.powerupToTest;
			}
			int nextId = ItemManager.Instance.GetNextId();
			ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
			ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
		}
	}

	// Token: 0x06000336 RID: 822 RVA: 0x00002147 File Offset: 0x00000347
	public void RemoveObject()
	{
	}

	// Token: 0x06000337 RID: 823 RVA: 0x000044FF File Offset: 0x000026FF
	public void OpenContainer()
	{
		this.opened = true;
		if (base.gameObject.activeInHierarchy)
		{
			this.animator.Play("OpenChest");
		Destroy(base.gameObject);
		}
	}

	// Token: 0x06000338 RID: 824 RVA: 0x00004530 File Offset: 0x00002730
	public string GetName()
	{
		this.price = (int)((float)this.basePrice * GameManager.instance.ChestPriceMultiplier());
		if (this.price < 1)
		{
			return "Open chest";
		}
		return string.Format("{0} Gold\n<size=75%>open chest", this.price);
	}

	// Token: 0x06000339 RID: 825 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0600033A RID: 826 RVA: 0x0000456F File Offset: 0x0000276F
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600033B RID: 827 RVA: 0x00004578 File Offset: 0x00002778
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400030F RID: 783
	public LootDrop lootTable;

	// Token: 0x04000310 RID: 784
	public int price;

	// Token: 0x04000311 RID: 785
	private int basePrice;

	// Token: 0x04000312 RID: 786
	private int id;

	// Token: 0x04000313 RID: 787
	private static int totalId = 69420;

	// Token: 0x04000314 RID: 788
	private bool ready = true;

	// Token: 0x04000315 RID: 789
	private bool opened;

	// Token: 0x04000316 RID: 790
	public Animator animator;

	// Token: 0x04000317 RID: 791
	public float white;

	// Token: 0x04000318 RID: 792
	public float blue;

	// Token: 0x04000319 RID: 793
	public float gold;

	// Token: 0x0400031A RID: 794
	public bool testPowerup;

	// Token: 0x0400031B RID: 795
	public Powerup powerupToTest;
}
