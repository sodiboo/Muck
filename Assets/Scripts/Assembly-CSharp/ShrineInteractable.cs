using UnityEngine;

// Token: 0x02000091 RID: 145
public class ShrineInteractable : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x0600034A RID: 842 RVA: 0x00002147 File Offset: 0x00000347
	private void Start()
	{
	}

	// Token: 0x0600034B RID: 843 RVA: 0x00013438 File Offset: 0x00011638
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
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
			base.Invoke("DestroyShrine", 1.33f);
		}
	}

	// Token: 0x0600034C RID: 844 RVA: 0x00004615 File Offset: 0x00002815
	private void DestroyShrine()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x0600034D RID: 845 RVA: 0x000134F8 File Offset: 0x000116F8
	private void DropPowerup()
	{
		Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(0.3f, 0.2f, 0.1f);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
		ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
	}

	// Token: 0x0600034E RID: 846 RVA: 0x00004628 File Offset: 0x00002828
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.StartCombatShrine(this.id);
	}

	// Token: 0x0600034F RID: 847 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x06000350 RID: 848 RVA: 0x00002147 File Offset: 0x00000347
	public void AllExecute()
	{
	}

	// Token: 0x06000351 RID: 849 RVA: 0x0000463E File Offset: 0x0000283E
	public void StartShrine(int[] mobIds)
	{
		this.mobIds = mobIds;
		this.started = true;
		base.InvokeRepeating("CheckLights", 0.5f, 0.5f);
	Destroy(base.GetComponent<Collider>());
	}

	// Token: 0x06000352 RID: 850 RVA: 0x00013560 File Offset: 0x00011760
	public void ServerExecute(int fromClient)
	{
		if (this.started)
		{
			return;
		}
		this.mobIds = new int[3];
		MobType mobType = GameLoop.Instance.SelectMobToSpawn(true);
		int num = 3;
		if (mobType.boss)
		{
			num = 2;
		}
		for (int i = 0; i < num; i++)
		{
			int nextId = MobManager.Instance.GetNextId();
			int mobType2 = mobType.id;
			RaycastHit raycastHit;
			if (Physics.Raycast(base.transform.position + new Vector3(Random.Range(-1f, 1f) * 10f, 100f, Random.Range(-1f, 1f) * 10f), Vector3.down, out raycastHit, 200f, this.whatIsGround))
			{
				MobSpawner.Instance.ServerSpawnNewMob(nextId, mobType2, raycastHit.point, 1.75f, 1f, Mob.BossType.None);
				this.mobIds[i] = nextId;
			}
		}
		this.StartShrine(this.mobIds);
		ServerSend.ShrineStart(this.mobIds, this.id);
	}

	// Token: 0x06000353 RID: 851 RVA: 0x0000466E File Offset: 0x0000286E
	public void RemoveObject()
	{
	Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x06000354 RID: 852 RVA: 0x0000468A File Offset: 0x0000288A
	public string GetName()
	{
		return "Start battle";
	}

	// Token: 0x06000355 RID: 853 RVA: 0x00004691 File Offset: 0x00002891
	public bool IsStarted()
	{
		return this.started;
	}

	// Token: 0x06000356 RID: 854 RVA: 0x00004699 File Offset: 0x00002899
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000357 RID: 855 RVA: 0x000046A2 File Offset: 0x000028A2
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000321 RID: 801
	private int id;

	// Token: 0x04000322 RID: 802
	public MeshRenderer[] lights;

	// Token: 0x04000323 RID: 803
	public Material lightMat;

	// Token: 0x04000324 RID: 804
	private int[] mobIds;

	// Token: 0x04000325 RID: 805
	public bool started;

	// Token: 0x04000326 RID: 806
	public LayerMask whatIsGround;

	// Token: 0x04000327 RID: 807
	public GameObject destroyShrineFx;
}
