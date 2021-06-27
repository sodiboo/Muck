using UnityEngine;

// Token: 0x02000108 RID: 264
public class ShrineBoss : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x060007B7 RID: 1975 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Start()
	{
	}

	// Token: 0x060007B8 RID: 1976 RVA: 0x000279C1 File Offset: 0x00025BC1
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	// Token: 0x060007B9 RID: 1977 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x060007BA RID: 1978 RVA: 0x000279D8 File Offset: 0x00025BD8
	public void AllExecute()
	{
		this.started = true;
		Debug.LogError("Spawning");
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		Invoke(nameof(RemoveFromResources), 1.33f);
	}

	// Token: 0x060007BB RID: 1979 RVA: 0x00027A30 File Offset: 0x00025C30
	public void ServerExecute(int fromClient)
	{
		this.started = true;
		Invoke(nameof(SpawnBoss), 1.3f);
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		ServerSend.SendChatMessage(-1, "", "<color=orange>" + GameManager.players[fromClient].username + " summoned <color=red>" + this.boss.name);
	}

	// Token: 0x060007BC RID: 1980 RVA: 0x00027AB0 File Offset: 0x00025CB0
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
		MobSpawner.Instance.ServerSpawnNewMob(nextId, this.boss.id, position, multiplier, bossMultiplier, Mob.BossType.BossShrine, -1);
	}

	// Token: 0x060007BD RID: 1981 RVA: 0x00027B29 File Offset: 0x00025D29
	private void RemoveFromResources()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
		Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x060007BE RID: 1982 RVA: 0x00006759 File Offset: 0x00004959
	public void RemoveObject()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x060007BF RID: 1983 RVA: 0x00027B56 File Offset: 0x00025D56
	public string GetName()
	{
		return "Challenge " + this.boss.name;
	}

	// Token: 0x060007C0 RID: 1984 RVA: 0x00027B6D File Offset: 0x00025D6D
	public bool IsStarted()
	{
		return this.started;
	}

	// Token: 0x060007C1 RID: 1985 RVA: 0x00027B75 File Offset: 0x00025D75
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060007C2 RID: 1986 RVA: 0x00027B7E File Offset: 0x00025D7E
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000773 RID: 1907
	private bool started;

	// Token: 0x04000774 RID: 1908
	private int id;

	// Token: 0x04000775 RID: 1909
	public MobType boss;

	// Token: 0x04000776 RID: 1910
	public GameObject destroyShrineFx;
}
