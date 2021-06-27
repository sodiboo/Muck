using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000B1 RID: 177
public abstract class MobServer : MonoBehaviour
{
	// Token: 0x060004B5 RID: 1205 RVA: 0x0001815C File Offset: 0x0001635C
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x060004B6 RID: 1206 RVA: 0x0001816C File Offset: 0x0001636C
	protected void StartRoutines()
	{
		InvokeRepeating(nameof(SyncPosition), Random.Range(0f, this.syncPositionInterval), this.syncPositionInterval);
		Invoke(nameof(SyncFindNextPosition), Random.Range(0f, this.FindPositionInterval) + this.findPositionInterval[0]);
		InvokeRepeating(nameof(Behaviour), Random.Range(0f, this.behaviourInterval) + this.mob.mobType.spawnTime, this.behaviourInterval);
	}

	// Token: 0x060004B7 RID: 1207 RVA: 0x000181F0 File Offset: 0x000163F0
	private void Update()
	{
		if (!this.mob.ready)
		{
			return;
		}
		this.Behaviour();
	}

	// Token: 0x060004B8 RID: 1208
	protected abstract void Behaviour();

	// Token: 0x060004B9 RID: 1209
	public abstract void TookDamage();

	// Token: 0x060004BA RID: 1210 RVA: 0x00018208 File Offset: 0x00016408
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

	// Token: 0x060004BB RID: 1211 RVA: 0x0001827C File Offset: 0x0001647C
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

	// Token: 0x060004BC RID: 1212
	protected abstract Vector3 FindNextPosition();

	// Token: 0x04000465 RID: 1125
	protected Mob mob;

	// Token: 0x04000466 RID: 1126
	private float syncPositionInterval = 2f;

	// Token: 0x04000467 RID: 1127
	protected float FindPositionInterval = 0.5f;

	// Token: 0x04000468 RID: 1128
	protected float behaviourInterval = 0.1f;

	// Token: 0x04000469 RID: 1129
	protected float[] findPositionInterval = new float[]
	{
		0.5f,
		2f,
		5f
	};

	// Token: 0x0400046A RID: 1130
	protected int previousTargetId = -1;
}
