using UnityEngine;

// Token: 0x02000109 RID: 265
public class ShrineGuardian : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x060007C4 RID: 1988 RVA: 0x00027B86 File Offset: 0x00025D86
	private void Start()
	{
		this.gemRend.material = this.gemMats[this.type - Guardian.GuardianType.Red];
		Boat.Instance.guardians.Add(this);
	}

	// Token: 0x060007C5 RID: 1989 RVA: 0x00027BB2 File Offset: 0x00025DB2
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	// Token: 0x060007C6 RID: 1990 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060007C7 RID: 1991 RVA: 0x00027BC8 File Offset: 0x00025DC8
	public void AllExecute()
	{
		this.started = true;
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		Invoke(nameof(RemoveFromResources), 1.33f);
	}

	// Token: 0x060007C8 RID: 1992 RVA: 0x00027C08 File Offset: 0x00025E08
	public void ServerExecute(int fromClient)
	{
		this.started = true;
		Invoke(nameof(SpawnBoss), 1.3f);
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		ServerSend.SendChatMessage(-1, "", "<color=orange>" + GameManager.players[fromClient].username + " summoned <color=red>" + this.boss.name);
	}

	// Token: 0x060007C9 RID: 1993 RVA: 0x00027C88 File Offset: 0x00025E88
	private void SpawnBoss()
	{
		int nextId = MobManager.Instance.GetNextId();
		float bossMultiplier = 0.9f + 0.1f * (float)GameManager.instance.GetPlayersAlive();
		float multiplier = 1.5f;
		if (Random.Range(0f, 1f) < 0.2f)
		{
			multiplier = 1.5f;
		}
		Vector3 position = base.transform.position;
		MobSpawner.Instance.ServerSpawnNewMob(nextId, this.boss.id, position, multiplier, bossMultiplier, Mob.BossType.BossShrine, (int)this.type);
	}

	// Token: 0x060007CA RID: 1994 RVA: 0x00027D06 File Offset: 0x00025F06
	private void RemoveFromResources()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
		Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x060007CB RID: 1995 RVA: 0x00006759 File Offset: 0x00004959
	public void RemoveObject()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x060007CC RID: 1996 RVA: 0x00027D33 File Offset: 0x00025F33
	public string GetName()
	{
		return "Challenge " + this.boss.name;
	}

	// Token: 0x060007CD RID: 1997 RVA: 0x00027D4A File Offset: 0x00025F4A
	public bool IsStarted()
	{
		return this.started;
	}

	// Token: 0x060007CE RID: 1998 RVA: 0x00027D52 File Offset: 0x00025F52
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060007CF RID: 1999 RVA: 0x00027D5B File Offset: 0x00025F5B
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000777 RID: 1911
	public Guardian.GuardianType type;

	// Token: 0x04000778 RID: 1912
	private bool started;

	// Token: 0x04000779 RID: 1913
	private int id;

	// Token: 0x0400077A RID: 1914
	public MobType boss;

	// Token: 0x0400077B RID: 1915
	public GameObject destroyShrineFx;

	// Token: 0x0400077C RID: 1916
	public MeshRenderer gemRend;

	// Token: 0x0400077D RID: 1917
	public Material[] gemMats;
}
