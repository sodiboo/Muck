using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000AE RID: 174
public abstract class MobServer : MonoBehaviour
{
	// Token: 0x06000416 RID: 1046 RVA: 0x00004E26 File Offset: 0x00003026
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x06000417 RID: 1047 RVA: 0x00016C80 File Offset: 0x00014E80
	protected void StartRoutines()
	{
		base.InvokeRepeating("SyncPosition", Random.Range(0f, this.syncPositionInterval), this.syncPositionInterval);
		base.Invoke("SyncFindNextPosition", Random.Range(0f, this.FindPositionInterval) + this.mob.mobType.spawnTime);
		base.InvokeRepeating("Behaviour", Random.Range(0f, this.behaviourInterval) + this.mob.mobType.spawnTime, this.behaviourInterval);
	}

	// Token: 0x06000418 RID: 1048 RVA: 0x00004E34 File Offset: 0x00003034
	private void Update()
	{
		if (!this.mob.ready)
		{
			return;
		}
		this.Behaviour();
	}

	// Token: 0x06000419 RID: 1049
	protected abstract void Behaviour();

	// Token: 0x0600041A RID: 1050
	public abstract void TookDamage();

	// Token: 0x0600041B RID: 1051 RVA: 0x00016D0C File Offset: 0x00014F0C
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

	// Token: 0x0600041C RID: 1052 RVA: 0x00016D80 File Offset: 0x00014F80
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

	// Token: 0x0600041D RID: 1053
	protected abstract Vector3 FindNextPosition();

	// Token: 0x04000409 RID: 1033
	protected Mob mob;

	// Token: 0x0400040A RID: 1034
	private float syncPositionInterval = 2f;

	// Token: 0x0400040B RID: 1035
	protected float FindPositionInterval = 0.5f;

	// Token: 0x0400040C RID: 1036
	protected float behaviourInterval = 0.1f;

	// Token: 0x0400040D RID: 1037
	protected float[] findPositionInterval = new float[]
	{
		0.5f,
		2f,
		5f
	};

	// Token: 0x0400040E RID: 1038
	protected int previousTargetId = -1;
}
