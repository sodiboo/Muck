
using UnityEngine;

// Token: 0x02000079 RID: 121
public class ShrineInteractable : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x0600030A RID: 778 RVA: 0x0000276E File Offset: 0x0000096E
	private void Start()
	{
	}

	// Token: 0x0600030B RID: 779 RVA: 0x0000F710 File Offset: 0x0000D910
	private void CheckLights()
	{
		int num = 0;
		foreach (int key in this.mobIds)
		{
			if (!MobManager.Instance.mobs.ContainsKey(key))
			{
				num++;
			}
		}
		for (int j = 0; j < num; j++)
		{
			this.lights[j].material = this.lightMat;
		}
		if (num >= 3)
		{
			base.CancelInvoke("CheckLights");
			if (LocalClient.serverOwner)
			{
				base.Invoke("DropPowerup", 1.33f);
			}
		Instantiate(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
			base.Invoke("DestroyShrine", 1.33f);
		}
	}

	// Token: 0x0600030C RID: 780 RVA: 0x0000F7CF File Offset: 0x0000D9CF
	private void DestroyShrine()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x0600030D RID: 781 RVA: 0x0000F7E4 File Offset: 0x0000D9E4
	private void DropPowerup()
	{
		Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(0.3f, 0.2f, 0.1f);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
		ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
	}

	// Token: 0x0600030E RID: 782 RVA: 0x0000F849 File Offset: 0x0000DA49
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.StartCombatShrine(this.id);
	}

	// Token: 0x0600030F RID: 783 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x06000310 RID: 784 RVA: 0x0000276E File Offset: 0x0000096E
	public void AllExecute()
	{
	}

	// Token: 0x06000311 RID: 785 RVA: 0x0000F85F File Offset: 0x0000DA5F
	public void StartShrine(int[] mobIds)
	{
		this.mobIds = mobIds;
		this.started = true;
		base.InvokeRepeating("CheckLights", 0.5f, 0.5f);
	Destroy(base.GetComponent<Collider>());
	}

	// Token: 0x06000312 RID: 786 RVA: 0x0000F890 File Offset: 0x0000DA90
	public void ServerExecute()
	{
		if (this.started)
		{
			return;
		}
		this.mobIds = new int[3];
		MobType mobType = GameLoop.Instance.SelectMobToSpawn(true);
		for (int i = 0; i < 3; i++)
		{
			int nextId = MobManager.Instance.GetNextId();
			int mobType2 = mobType.id;
			RaycastHit raycastHit;
			if (Physics.Raycast(base.transform.position + new Vector3(Random.Range(-1f, 1f) * 10f, 100f, Random.Range(-1f, 1f) * 10f), Vector3.down, out raycastHit, 200f, this.whatIsGround))
			{
				MobSpawner.Instance.ServerSpawnNewMob(nextId, mobType2, raycastHit.point, 1.75f, 1f);
				this.mobIds[i] = nextId;
			}
		}
		this.StartShrine(this.mobIds);
		ServerSend.ShrineStart(this.mobIds, this.id);
	}

	// Token: 0x06000313 RID: 787 RVA: 0x0000F987 File Offset: 0x0000DB87
	public void RemoveObject()
	{
	Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x06000314 RID: 788 RVA: 0x0000F9A3 File Offset: 0x0000DBA3
	public string GetName()
	{
		return "Start battle";
	}

	// Token: 0x06000315 RID: 789 RVA: 0x0000F9AA File Offset: 0x0000DBAA
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000316 RID: 790 RVA: 0x0000F9B3 File Offset: 0x0000DBB3
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040002BD RID: 701
	private int id;

	// Token: 0x040002BE RID: 702
	public MeshRenderer[] lights;

	// Token: 0x040002BF RID: 703
	public Material lightMat;

	// Token: 0x040002C0 RID: 704
	private int[] mobIds;

	// Token: 0x040002C1 RID: 705
	public bool started;

	// Token: 0x040002C2 RID: 706
	public LayerMask whatIsGround;

	// Token: 0x040002C3 RID: 707
	public GameObject destroyShrineFx;
}
