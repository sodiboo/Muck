using System.Collections.Generic;
using UnityEngine;

public abstract class MobServer : MonoBehaviour
{
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	protected void StartRoutines()
	{
		InvokeRepeating(nameof(SyncPosition), Random.Range(0f, this.syncPositionInterval), this.syncPositionInterval);
		Invoke(nameof(SyncFindNextPosition), Random.Range(0f, this.FindPositionInterval) + this.findPositionInterval[0]);
		InvokeRepeating(nameof(Behaviour), Random.Range(0f, this.behaviourInterval) + this.mob.mobType.spawnTime, this.behaviourInterval);
	}

	private void Update()
	{
		if (!this.mob.ready)
		{
			return;
		}
		this.Behaviour();
	}

	protected abstract void Behaviour();

	public abstract void TookDamage();

	private void SyncPosition()
	{
		using (Dictionary<int, PlayerManager>.ValueCollection.Enumerator enumerator = GameManager.players.Values.GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				if (!enumerator.Current)
				{
					break;
				}
				ServerSend.MobMove(this.mob.GetId(), base.transform.position);
			}
		}
	}

	protected void SyncFindNextPosition()
	{
		if (GameManager.players == null)
		{
			return;
		}
		Vector3 vector = this.FindNextPosition();
		if (this.mob.targetPlayerId != this.previousTargetId)
		{
			ServerSend.SendMobTarget(this.mob.id, this.mob.targetPlayerId);
		}
		this.previousTargetId = this.mob.targetPlayerId;
		if (vector == Vector3.zero)
		{
			return;
		}
		this.mob.SetDestination(vector);
		ServerSend.MobSetDestination(this.mob.GetId(), vector);
	}

	protected abstract Vector3 FindNextPosition();

	protected Mob mob;

	private float syncPositionInterval = 2f;

	protected float FindPositionInterval = 0.5f;

	protected float behaviourInterval = 0.1f;

	protected float[] findPositionInterval = new float[]
	{
		0.5f,
		2f,
		5f
	};

	protected int previousTargetId = -1;
}
