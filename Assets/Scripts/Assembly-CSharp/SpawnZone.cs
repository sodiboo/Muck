using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000135 RID: 309
[ExecuteInEditMode]
public abstract class SpawnZone : MonoBehaviour, SharedObject
{
	// Token: 0x0600076C RID: 1900 RVA: 0x00024F34 File Offset: 0x00023134
	private void Start()
	{
		this.entityQueue = this.entityCap;
		this.entityBuffer = this.entityCap;
		if (!Application.isPlaying)
		{
			return;
		}
		this.entities = new List<GameObject>();
		base.InvokeRepeating(nameof(SlowUpdate), Random.Range(0f, this.updateRate), this.updateRate);
	}

	// Token: 0x0600076D RID: 1901 RVA: 0x00024F90 File Offset: 0x00023190
	private void SlowUpdate()
	{
		if (!LocalClient.serverOwner || GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		this.entities.RemoveAll((GameObject item) => item == null);
		if (this.entities.Count + this.entityBuffer < this.entityCap)
		{
			base.Invoke(nameof(QueueEntity), this.respawnTime);
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

	// Token: 0x0600076E RID: 1902 RVA: 0x00006E6D File Offset: 0x0000506D
	private void QueueEntity()
	{
		this.entityQueue++;
	}

	// Token: 0x0600076F RID: 1903
	public abstract void ServerSpawnEntity();

	// Token: 0x06000770 RID: 1904 RVA: 0x00025100 File Offset: 0x00023300
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

	// Token: 0x06000771 RID: 1905
	public abstract GameObject LocalSpawnEntity(Vector3 pos, int entityType, int objectId, int zoneId);

	// Token: 0x06000772 RID: 1906 RVA: 0x00025180 File Offset: 0x00023380
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

	// Token: 0x06000773 RID: 1907 RVA: 0x00002147 File Offset: 0x00000347
	private void OnDrawGizmos()
	{
	}

	// Token: 0x06000774 RID: 1908 RVA: 0x00006E7D File Offset: 0x0000507D
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000775 RID: 1909 RVA: 0x00006E86 File Offset: 0x00005086
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040007AB RID: 1963
	public int id;

	// Token: 0x040007AC RID: 1964
	protected List<GameObject> entities;

	// Token: 0x040007AD RID: 1965
	protected int entityBuffer;

	// Token: 0x040007AE RID: 1966
	protected int entityQueue;

	// Token: 0x040007AF RID: 1967
	public float roamDistance;

	// Token: 0x040007B0 RID: 1968
	public float renderDistance;

	// Token: 0x040007B1 RID: 1969
	public bool despawn = true;

	// Token: 0x040007B2 RID: 1970
	public int entityCap = 3;

	// Token: 0x040007B3 RID: 1971
	public float respawnTime = 60f;

	// Token: 0x040007B4 RID: 1972
	public float updateRate = 2f;

	// Token: 0x040007B5 RID: 1973
	private bool rendered;

	// Token: 0x040007B6 RID: 1974
	public LayerMask whatIsGround;
}
