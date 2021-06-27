using System;
using UnityEngine;

// Token: 0x0200009D RID: 157
public class LootContainerInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060003CD RID: 973 RVA: 0x00013C37 File Offset: 0x00011E37
	private void Start()
	{
		if (this.testPowerup)
		{
			this.TestSpawn();
		}
		this.ready = true;
		this.basePrice = this.price;
	}

	// Token: 0x060003CE RID: 974 RVA: 0x00013C5A File Offset: 0x00011E5A
	private void OnEnable()
	{
		if (this.opened)
		{
			this.OpenContainer();
		}
	}

	// Token: 0x060003CF RID: 975 RVA: 0x00013C6A File Offset: 0x00011E6A
	private void TestSpawn()
	{
		this.id = LootContainerInteract.totalId++;
		ResourceManager.Instance.AddObject(this.id, base.gameObject);
	}

	// Token: 0x060003D0 RID: 976 RVA: 0x00013C95 File Offset: 0x00011E95
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

	// Token: 0x060003D1 RID: 977 RVA: 0x00013CD5 File Offset: 0x00011ED5
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x060003D2 RID: 978 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060003D3 RID: 979 RVA: 0x00013CDE File Offset: 0x00011EDE
	public void AllExecute()
	{
		this.OpenContainer();
	}

	// Token: 0x060003D4 RID: 980 RVA: 0x00013CE8 File Offset: 0x00011EE8
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

	// Token: 0x060003D5 RID: 981 RVA: 0x000030D7 File Offset: 0x000012D7
	public void RemoveObject()
	{
	}

	// Token: 0x060003D6 RID: 982 RVA: 0x00013D74 File Offset: 0x00011F74
	public void OpenContainer()
	{
		this.opened = true;
		if (base.gameObject.activeInHierarchy)
		{
			this.animator.Play("OpenChest");
			Destroy(base.gameObject);
		}
	}

	// Token: 0x060003D7 RID: 983 RVA: 0x00013DA5 File Offset: 0x00011FA5
	public string GetName()
	{
		this.price = (int)((float)this.basePrice * GameManager.instance.ChestPriceMultiplier());
		if (this.price < 1)
		{
			return "Open chest";
		}
		return string.Format("{0} Gold\n<size=75%>open chest", this.price);
	}

	// Token: 0x060003D8 RID: 984 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x060003D9 RID: 985 RVA: 0x00013DE4 File Offset: 0x00011FE4
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060003DA RID: 986 RVA: 0x00013DED File Offset: 0x00011FED
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040003A3 RID: 931
	public LootDrop lootTable;

	// Token: 0x040003A4 RID: 932
	public int price;

	// Token: 0x040003A5 RID: 933
	private int basePrice;

	// Token: 0x040003A6 RID: 934
	private int id;

	// Token: 0x040003A7 RID: 935
	private static int totalId = 69420;

	// Token: 0x040003A8 RID: 936
	private bool ready = true;

	// Token: 0x040003A9 RID: 937
	private bool opened;

	// Token: 0x040003AA RID: 938
	public Animator animator;

	// Token: 0x040003AB RID: 939
	public float white;

	// Token: 0x040003AC RID: 940
	public float blue;

	// Token: 0x040003AD RID: 941
	public float gold;

	// Token: 0x040003AE RID: 942
	public bool testPowerup;

	// Token: 0x040003AF RID: 943
	public Powerup powerupToTest;
}
