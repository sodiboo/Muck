using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000116 RID: 278
[ExecuteInEditMode]
public abstract class SpawnZone : MonoBehaviour, SharedObject
{
	// Token: 0x060007FE RID: 2046 RVA: 0x00028510 File Offset: 0x00026710
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

	// Token: 0x060007FF RID: 2047 RVA: 0x0002856C File Offset: 0x0002676C
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

	// Token: 0x06000800 RID: 2048 RVA: 0x000286DC File Offset: 0x000268DC
	private void QueueEntity()
	{
		this.entityQueue++;
	}

	// Token: 0x06000801 RID: 2049
	public abstract void ServerSpawnEntity();

	// Token: 0x06000802 RID: 2050 RVA: 0x000286EC File Offset: 0x000268EC
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

	// Token: 0x06000803 RID: 2051
	public abstract GameObject LocalSpawnEntity(Vector3 pos, int entityType, int objectId, int zoneId);

	// Token: 0x06000804 RID: 2052 RVA: 0x0002876C File Offset: 0x0002696C
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

	// Token: 0x06000805 RID: 2053 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnDrawGizmos()
	{
	}

	// Token: 0x06000806 RID: 2054 RVA: 0x000287D0 File Offset: 0x000269D0
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000807 RID: 2055 RVA: 0x000287D9 File Offset: 0x000269D9
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040007A0 RID: 1952
	public int id;

	// Token: 0x040007A1 RID: 1953
	protected List<GameObject> entities;

	// Token: 0x040007A2 RID: 1954
	protected int entityBuffer;

	// Token: 0x040007A3 RID: 1955
	protected int entityQueue;

	// Token: 0x040007A4 RID: 1956
	public float roamDistance;

	// Token: 0x040007A5 RID: 1957
	public float renderDistance;

	// Token: 0x040007A6 RID: 1958
	public bool despawn = true;

	// Token: 0x040007A7 RID: 1959
	public int entityCap = 3;

	// Token: 0x040007A8 RID: 1960
	public float respawnTime = 60f;

	// Token: 0x040007A9 RID: 1961
	public float updateRate = 2f;

	// Token: 0x040007AA RID: 1962
	private bool rendered;

	// Token: 0x040007AB RID: 1963
	public LayerMask whatIsGround;
}
