
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200008A RID: 138
public abstract class MobServer : MonoBehaviour
{
	// Token: 0x060003BF RID: 959 RVA: 0x00012E94 File Offset: 0x00011094
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x060003C0 RID: 960 RVA: 0x00012EA4 File Offset: 0x000110A4
	protected void StartRoutines()
	{
		base.InvokeRepeating("SyncPosition", Random.Range(0f, this.syncPositionInterval), this.syncPositionInterval);
		base.Invoke("SyncFindNextPosition", Random.Range(0f, this.FindPositionInterval) + this.mob.mobType.spawnTime);
		base.InvokeRepeating("Behaviour", Random.Range(0f, this.behaviourInterval) + this.mob.mobType.spawnTime, this.behaviourInterval);
	}

	// Token: 0x060003C1 RID: 961 RVA: 0x00012F30 File Offset: 0x00011130
	private void Update()
	{
		this.Behaviour();
	}

	// Token: 0x060003C2 RID: 962
	protected abstract void Behaviour();

	// Token: 0x060003C3 RID: 963
	public abstract void TookDamage();

	// Token: 0x060003C4 RID: 964 RVA: 0x00012F38 File Offset: 0x00011138
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

	// Token: 0x060003C5 RID: 965 RVA: 0x00012FAC File Offset: 0x000111AC
	protected void SyncFindNextPosition()
	{
		if (GameManager.players == null)
		{
			return;
		}
		Vector3 vector = this.FindNextPosition();
		if (vector == Vector3.zero)
		{
			return;
		}
		this.mob.SetDestination(vector);
		ServerSend.MobSetDestination(this.mob.GetId(), vector);
	}

	// Token: 0x060003C6 RID: 966
	protected abstract Vector3 FindNextPosition();

	// Token: 0x0400035C RID: 860
	protected Mob mob;

	// Token: 0x0400035D RID: 861
	private float syncPositionInterval = 2f;

	// Token: 0x0400035E RID: 862
	protected float FindPositionInterval = 0.5f;

	// Token: 0x0400035F RID: 863
	protected float behaviourInterval = 0.1f;

	// Token: 0x04000360 RID: 864
	protected float[] findPositionInterval = new float[]
	{
		0.5f,
		2f,
		5f
	};
}
