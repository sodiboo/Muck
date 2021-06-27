using UnityEngine;

public class ShrineInteractable : MonoBehaviour, SharedObject, Interactable
{
	private void Start()
	{
	}

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

	private void DestroyShrine()
	{
		ResourceManager.Instance.RemoveInteractItem(this.id);
	}

	private void DropPowerup()
	{
		Powerup randomPowerup = ItemManager.Instance.GetRandomPowerup(0.3f, 0.2f, 0.1f);
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropPowerupAtPosition(randomPowerup.id, base.transform.position, nextId);
		ServerSend.DropPowerupAtPosition(randomPowerup.id, nextId, base.transform.position);
	}

	public void Interact()
	{
		if (this.started)
		{
			return;
		}
		ClientSend.StartCombatShrine(this.id);
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
	}

	public void StartShrine(int[] mobIds)
	{
		this.mobIds = mobIds;
		this.started = true;
		InvokeRepeating(nameof(CheckLights), 0.5f, 0.5f);
		Destroy(base.GetComponent<Collider>());
	}

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

	public void RemoveObject()
	{
		Destroy(base.gameObject.transform.root.gameObject);
	}

	public string GetName()
	{
		return "Start battle";
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

	private int id;

	public MeshRenderer[] lights;

	public Material lightMat;

	private int[] mobIds;

	public bool started;

	public LayerMask whatIsGround;

	public GameObject destroyShrineFx;
}
