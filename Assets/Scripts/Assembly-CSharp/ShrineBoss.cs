using UnityEngine;

// Token: 0x02000129 RID: 297
public class ShrineBoss : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x06000736 RID: 1846 RVA: 0x00002147 File Offset: 0x00000347
	private void Start()
	{
	}

	// Token: 0x06000737 RID: 1847 RVA: 0x00006C4F File Offset: 0x00004E4F
	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	// Token: 0x06000738 RID: 1848 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x06000739 RID: 1849 RVA: 0x000249E0 File Offset: 0x00022BE0
	public void AllExecute()
	{
		this.started = true;
		Debug.LogError("Spawning");
	Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		base.Invoke(nameof(RemoveFromResources), 1.33f);
	}

	// Token: 0x0600073A RID: 1850 RVA: 0x00024A38 File Offset: 0x00022C38
	public void ServerExecute(int fromClient)
	{
		this.started = true;
		base.Invoke(nameof(SpawnBoss), 1.3f);
	Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		ServerSend.SendChatMessage(-1, "", "<color=orange>" + GameManager.players[fromClient].username + " summoned <color=red>" + this.boss.name);
	}

	// Token: 0x0600073B RID: 1851 RVA: 0x00024AB8 File Offset: 0x00022CB8
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
		MobSpawner.Instance.ServerSpawnNewMob(nextId, this.boss.id, position, multiplier, bossMultiplier, Mob.BossType.BossShrine);
	}

	// Token: 0x0600073C RID: 1852 RVA: 0x00006C65 File Offset: 0x00004E65
	private void RemoveFromResources()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
	Destroy(base.gameObject.transform.root.gameObject);
	}

	// Token: 0x0600073D RID: 1853 RVA: 0x00002AC8 File Offset: 0x00000CC8
	public void RemoveObject()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x0600073E RID: 1854 RVA: 0x00006C92 File Offset: 0x00004E92
	public string GetName()
	{
		return "Challenge " + this.boss.name;
	}

	// Token: 0x0600073F RID: 1855 RVA: 0x00006CA9 File Offset: 0x00004EA9
	public bool IsStarted()
	{
		return this.started;
	}

	// Token: 0x06000740 RID: 1856 RVA: 0x00006CB1 File Offset: 0x00004EB1
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000741 RID: 1857 RVA: 0x00006CBA File Offset: 0x00004EBA
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400078A RID: 1930
	private bool started;

	// Token: 0x0400078B RID: 1931
	private int id;

	// Token: 0x0400078C RID: 1932
	public MobType boss;

	// Token: 0x0400078D RID: 1933
	public GameObject destroyShrineFx;
}
