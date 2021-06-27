using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public abstract class SpawnZone : MonoBehaviour, SharedObject
{
	private void Start()
	{
		this.entityQueue = this.entityCap;
		this.entityBuffer = this.entityCap;
		if (!Application.isPlaying)
		{
			return;
		}
		this.entities = new List<GameObject>();
		InvokeRepeating(nameof(SlowUpdate), Random.Range(0f, this.updateRate), this.updateRate);
	}

	private void SlowUpdate()
	{
		if (!LocalClient.serverOwner || GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		this.entities.RemoveAll((GameObject item) => item == null);
		if (this.entities.Count + this.entityBuffer < this.entityCap)
		{
			Invoke(nameof(QueueEntity), this.respawnTime);
			this.entityBuffer++;
		}
		bool flag = false;
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (!(playerManager == null) && Vector3.Distance(base.transform.position, playerManager.transform.position) < this.renderDistance)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			int num = this.entityQueue;
			for (int i = 0; i < num; i++)
			{
				MonoBehaviour.print("dequeing");
				this.ServerSpawnEntity();
				this.entityQueue--;
			}
			if (!this.rendered)
			{
				ServerSend.MobZoneToggle(true, this.id);
				this.rendered = true;
				return;
			}
		}
		else if (this.rendered)
		{
			this.rendered = false;
			if (this.despawn)
			{
				ServerSend.MobZoneToggle(false, this.id);
			}
		}
	}

	private void QueueEntity()
	{
		this.entityQueue++;
	}

	public abstract void ServerSpawnEntity();

	public Vector3 FindRandomPos()
	{
		Vector2 insideUnitCircle = Random.insideUnitCircle;
		Vector3 origin = base.transform.position + new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y) * this.roamDistance;
		origin.y = 200f;
		RaycastHit raycastHit;
		if (Physics.Raycast(origin, Vector3.down, out raycastHit, 500f, this.whatIsGround))
		{
			return raycastHit.point;
		}
		return Vector3.zero;
	}

	public abstract GameObject LocalSpawnEntity(Vector3 pos, int entityType, int objectId, int zoneId);

	public void ToggleEntities(bool show)
	{
		foreach (GameObject gameObject in this.entities)
		{
			if (gameObject != null)
			{
				gameObject.gameObject.SetActive(show);
			}
		}
	}

	private void OnDrawGizmos()
	{
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	public int id;

	protected List<GameObject> entities;

	protected int entityBuffer;

	protected int entityQueue;

	public float roamDistance;

	public float renderDistance;

	public bool despawn = true;

	public int entityCap = 3;

	public float respawnTime = 60f;

	public float updateRate = 2f;

	private bool rendered;

	public LayerMask whatIsGround;
}
