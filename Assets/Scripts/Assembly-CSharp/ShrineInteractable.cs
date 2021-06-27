using UnityEngine;

// Token: 0x0200009F RID: 159
public class ShrineInteractable : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x060003E9 RID: 1001 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Start()
	{
	}

	// Token: 0x060003EA RID: 1002 RVA: 0x00013F30 File Offset: 0x00012130
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
				Invoke(nameof(DropPowerup), 1.33f);
			}
			Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
			Invoke(nameof(DestroyShrine), 1.33f);
		}
	}

	// Token: 0x060003EB RID: 1003 RVA: 0x00013FEF File Offset: 0x000121EF
	private void DestroyShrine()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	// Token: 0x060003EC RID: 1004 RVA: 0x00014004 File Offset: 0x00012204
	private void DropPowerup()
	{
		Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(0.3f, 0.2f, 0.1f);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
		ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
	}

	// Token: 0x060003ED RID: 1005 RVA: 0x00014069 File Offset: 0x00012269
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.StartCombatShrine(this.id);
	}

	// Token: 0x060003EE RID: 1006 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060003EF RID: 1007 RVA: 0x000030D7 File Offset: 0x000012D7
	public void AllExecute()
	{
	}

	// Token: 0x060003F0 RID: 1008 RVA: 0x0001407F File Offset: 0x0001227F
	public void StartShrine(int[] mobIds)
	{
		this.mobIds = mobIds;
		this.started = true;
		InvokeRepeating(nameof(CheckLights), 0.5f, 0.5f);
		Destroy(base.GetComponent<Collider>());
	}

	// Token: 0x060003F1 RID: 1009 RVA: 0x000140B0 File Offset: 0x000122B0
	public void ServerExecute(int fromClient)
	{
		if (this.started)
		{
			return;
		}
		this.mobIds = new int[3];
		MobType mobType = GameLoop.Instance.SelectMobToSpawn(true);
		int num = 3;
		for (int i = 0; i < num; i++)
		{
			int nextId = MobManager.Instance.GetNextId();
			int mobType2 = mobType.id;
			RaycastHit raycastHit;
			if (Physics.Raycast(base.transform.position + new Vector3(Random.Range(-1f, 1f) * 10f, 100f, Random.Range(-1f, 1f) * 10f), Vector3.down, out raycastHit, 200f, this.whatIsGround))
			{
				MobSpawner.Instance.ServerSpawnNewMob(nextId, mobType2, raycastHit.point, 1.75f, 1f, Mob.BossType.None, -1);
				this.mobIds[i] = nextId;
			}
		}
		this.StartShrine(this.mobIds);
		ServerSend.ShrineStart(this.mobIds, this.id);
	}

	// Token: 0x060003F2 RID: 1010 RVA: 0x000141AD File Offset: 0x000123AD
	public void RemoveObject()
	{
		Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x060003F3 RID: 1011 RVA: 0x000141C9 File Offset: 0x000123C9
	public string GetName()
	{
		return "Start battle";
	}

	// Token: 0x060003F4 RID: 1012 RVA: 0x000141D0 File Offset: 0x000123D0
	public bool IsStarted()
	{
		return this.started;
	}

	// Token: 0x060003F5 RID: 1013 RVA: 0x000141D8 File Offset: 0x000123D8
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060003F6 RID: 1014 RVA: 0x000141E1 File Offset: 0x000123E1
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040003B5 RID: 949
	private int id;

	// Token: 0x040003B6 RID: 950
	public MeshRenderer[] lights;

	// Token: 0x040003B7 RID: 951
	public Material lightMat;

	// Token: 0x040003B8 RID: 952
	private int[] mobIds;

	// Token: 0x040003B9 RID: 953
	public bool started;

	// Token: 0x040003BA RID: 954
	public LayerMask whatIsGround;

	// Token: 0x040003BB RID: 955
	public GameObject destroyShrineFx;
}
