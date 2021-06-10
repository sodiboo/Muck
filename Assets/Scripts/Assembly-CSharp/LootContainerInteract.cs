
using UnityEngine;

// Token: 0x02000077 RID: 119
public class LootContainerInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x060002F0 RID: 752 RVA: 0x0000F417 File Offset: 0x0000D617
	private void Start()
	{
		if (this.testPowerup)
		{
			this.TestSpawn();
		}
		this.ready = true;
		this.basePrice = this.price;
	}

	// Token: 0x060002F1 RID: 753 RVA: 0x0000F43A File Offset: 0x0000D63A
	private void OnEnable()
	{
		if (this.opened)
		{
			this.OpenContainer();
		}
	}

	// Token: 0x060002F2 RID: 754 RVA: 0x0000F44A File Offset: 0x0000D64A
	private void TestSpawn()
	{
		this.id = LootContainerInteract.totalId++;
		ResourceManager.Instance.AddObject(this.id, base.gameObject);
	}

	// Token: 0x060002F3 RID: 755 RVA: 0x0000F475 File Offset: 0x0000D675
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

	// Token: 0x060002F4 RID: 756 RVA: 0x0000F4B5 File Offset: 0x0000D6B5
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x060002F5 RID: 757 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x060002F6 RID: 758 RVA: 0x0000F4BE File Offset: 0x0000D6BE
	public void AllExecute()
	{
		this.OpenContainer();
	}

	// Token: 0x060002F7 RID: 759 RVA: 0x0000F4C8 File Offset: 0x0000D6C8
	public void ServerExecute()
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

	// Token: 0x060002F8 RID: 760 RVA: 0x0000276E File Offset: 0x0000096E
	public void RemoveObject()
	{
	}

	// Token: 0x060002F9 RID: 761 RVA: 0x0000F554 File Offset: 0x0000D754
	public void OpenContainer()
	{
		this.opened = true;
		if (base.gameObject.activeInHierarchy)
		{
			this.animator.Play("OpenChest");
		Destroy(base.gameObject);
		}
	}

	// Token: 0x060002FA RID: 762 RVA: 0x0000F585 File Offset: 0x0000D785
	public string GetName()
	{
		this.price = (int)((float)this.basePrice * GameManager.instance.ChestPriceMultiplier());
		if (this.price < 1)
		{
			return "Open chest";
		}
		return string.Format("{0} Gold\n<size=75%>open chest", this.price);
	}

	// Token: 0x060002FB RID: 763 RVA: 0x0000F5C4 File Offset: 0x0000D7C4
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060002FC RID: 764 RVA: 0x0000F5CD File Offset: 0x0000D7CD
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040002AB RID: 683
	public LootDrop lootTable;

	// Token: 0x040002AC RID: 684
	public int price;

	// Token: 0x040002AD RID: 685
	private int basePrice;

	// Token: 0x040002AE RID: 686
	private int id;

	// Token: 0x040002AF RID: 687
	private static int totalId = 69420;

	// Token: 0x040002B0 RID: 688
	private bool ready = true;

	// Token: 0x040002B1 RID: 689
	private bool opened;

	// Token: 0x040002B2 RID: 690
	public Animator animator;

	// Token: 0x040002B3 RID: 691
	public float white;

	// Token: 0x040002B4 RID: 692
	public float blue;

	// Token: 0x040002B5 RID: 693
	public float gold;

	// Token: 0x040002B6 RID: 694
	public bool testPowerup;

	// Token: 0x040002B7 RID: 695
	public Powerup powerupToTest;
}
