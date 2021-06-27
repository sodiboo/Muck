using System;
using UnityEngine;
using UnityEngine.Rendering;

// Token: 0x02000084 RID: 132
public class RepairInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x06000320 RID: 800 RVA: 0x00011414 File Offset: 0x0000F614
	private void Start()
	{
		float num = 1f;
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		num += (float)playersInLobby * 0.15f;
		num = Mathf.Clamp(num, 1f, 2f);
		for (int i = 0; i < this.requirements.Length; i++)
		{
			this.requirements[i] = Instantiate<InventoryItem>(this.requirements[i]);
			this.requirements[i].amount = (int)((float)this.amounts[i] * num);
		}
		this.render = base.GetComponent<MeshRenderer>();
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	// Token: 0x06000321 RID: 801 RVA: 0x000114B0 File Offset: 0x0000F6B0
	private void SlowUpdate()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
	}

	// Token: 0x06000322 RID: 802 RVA: 0x000114DF File Offset: 0x0000F6DF
	public void Interact()
	{
		if (!InventoryUI.Instance.CanRepair(this.requirements))
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	// Token: 0x06000323 RID: 803 RVA: 0x000114FF File Offset: 0x0000F6FF
	public void LocalExecute()
	{
		InventoryUI.Instance.Repair(this.requirements);
	}

	// Token: 0x06000324 RID: 804 RVA: 0x00011514 File Offset: 0x0000F714
	public void AllExecute()
	{
		Instantiate<GameObject>(this.repairFx, base.transform.position, Quaternion.identity);
		if (this.replace)
		{
			if (this.fixedObject)
			{
				this.fixedObject.SetActive(true);
			}
			base.gameObject.SetActive(false);
		}
		else
		{
			this.render = base.GetComponent<MeshRenderer>();
			this.render.material = this.fixedMaterial;
			this.render.shadowCastingMode = ShadowCastingMode.On;
			base.gameObject.layer = LayerMask.NameToLayer("Object");
			Collider[] components = base.GetComponents<Collider>();
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].isTrigger)
				{
					Destroy(components[i]);
				}
				else
				{
					components[i].enabled = true;
				}
			}
		}
		GameObject[] array = this.toActive;
		for (int j = 0; j < array.Length; j++)
		{
			array[j].SetActive(true);
		}
		array = this.toInactive;
		for (int j = 0; j < array.Length; j++)
		{
			array[j].SetActive(false);
		}
		Destroy(this);
	}

	// Token: 0x06000325 RID: 805 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient = -1)
	{
	}

	// Token: 0x06000326 RID: 806 RVA: 0x000030D7 File Offset: 0x000012D7
	public void RemoveObject()
	{
	}

	// Token: 0x06000327 RID: 807 RVA: 0x00011620 File Offset: 0x0000F820
	public string GetName()
	{
		string text = this.name;
		text += "<size=75%>";
		foreach (InventoryItem inventoryItem in this.requirements)
		{
			text += string.Format("\n{0} ({1})", inventoryItem.name, inventoryItem.amount);
		}
		return text;
	}

	// Token: 0x06000328 RID: 808 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x06000329 RID: 809 RVA: 0x0001167C File Offset: 0x0000F87C
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600032A RID: 810 RVA: 0x00011685 File Offset: 0x0000F885
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400031B RID: 795
	public new string name;

	// Token: 0x0400031C RID: 796
	private int id;

	// Token: 0x0400031D RID: 797
	public bool replace;

	// Token: 0x0400031E RID: 798
	public GameObject fixedObject;

	// Token: 0x0400031F RID: 799
	public GameObject repairFx;

	// Token: 0x04000320 RID: 800
	public Material outlineMat;

	// Token: 0x04000321 RID: 801
	private Material defaultMat;

	// Token: 0x04000322 RID: 802
	private MeshRenderer render;

	// Token: 0x04000323 RID: 803
	public GameObject[] toActive;

	// Token: 0x04000324 RID: 804
	public GameObject[] toInactive;

	// Token: 0x04000325 RID: 805
	public Material fixedMaterial;

	// Token: 0x04000326 RID: 806
	public InventoryItem[] requirements;

	// Token: 0x04000327 RID: 807
	public int[] amounts;
}
