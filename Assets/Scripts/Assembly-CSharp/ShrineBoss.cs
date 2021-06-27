using UnityEngine;

public class ShrineBoss : MonoBehaviour, SharedObject, Interactable
{
	private void Start()
	{
	}

	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.Interact(this.id);
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
		this.started = true;
		Debug.LogError("Spawning");
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		Invoke(nameof(RemoveFromResources), 1.33f);
	}

	public void ServerExecute(int fromClient)
	{
		this.started = true;
		Invoke(nameof(SpawnBoss), 1.3f);
		Instantiate<GameObject>(this.destroyShrineFx, base.transform.position, this.destroyShrineFx.transform.rotation);
		ServerSend.SendChatMessage(-1, "", "<color=orange>" + GameManager.players[fromClient].username + " summoned <color=red>" + this.boss.name);
	}

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

	private void RemoveFromResources()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
		Destroy(base.gameObject.transform.root.gameObject);
	}

	public void RemoveObject()
	{
		Destroy(base.gameObject);
	}

	public string GetName()
	{
		return "Challenge " + this.boss.name;
	}

	public bool IsStarted()
	{
		return this.started;
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	private bool started;

	private int id;

	public MobType boss;

	public GameObject destroyShrineFx;
}
