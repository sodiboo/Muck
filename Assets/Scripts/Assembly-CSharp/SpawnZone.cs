
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000E7 RID: 231
[ExecuteInEditMode]
public abstract class SpawnZone : MonoBehaviour, SharedObject
{
	// Token: 0x060006BC RID: 1724 RVA: 0x00021CA5 File Offset: 0x0001FEA5
	private void Start()
	{
		if (!Application.isPlaying)
		{
			return;
		}
		this.entities = new List<GameObject>();
		base.InvokeRepeating("SlowUpdate", Random.Range(0f, this.updateRate), this.updateRate);
	}

	// Token: 0x060006BD RID: 1725 RVA: 0x00021CDC File Offset: 0x0001FEDC
	private void SlowUpdate()
	{
		if (!LocalClient.serverOwner || GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		this.entities.RemoveAll((GameObject item) => item == null);
		if (this.entities.Count + this.entityBuffer < this.entityCap)
		{
			base.Invoke("QueueEntity", this.respawnTime);
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
			ServerSend.MobZoneToggle(false, this.id);
		}
	}

	// Token: 0x060006BE RID: 1726 RVA: 0x00021E44 File Offset: 0x00020044
	private void QueueEntity()
	{
		this.entityQueue++;
	}

	// Token: 0x060006BF RID: 1727
	public abstract void ServerSpawnEntity();

	// Token: 0x060006C0 RID: 1728 RVA: 0x00021E54 File Offset: 0x00020054
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

	// Token: 0x060006C1 RID: 1729
	public abstract GameObject LocalSpawnEntity(Vector3 pos, int entityType, int objectId, int zoneId);

	// Token: 0x060006C2 RID: 1730 RVA: 0x00021ED4 File Offset: 0x000200D4
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

	// Token: 0x060006C3 RID: 1731 RVA: 0x0000276E File Offset: 0x0000096E
	private void OnDrawGizmos()
	{
	}

	// Token: 0x060006C4 RID: 1732 RVA: 0x00021F38 File Offset: 0x00020138
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x060006C5 RID: 1733 RVA: 0x00021F41 File Offset: 0x00020141
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400065C RID: 1628
	public int id;

	// Token: 0x0400065D RID: 1629
	protected List<GameObject> entities;

	// Token: 0x0400065E RID: 1630
	protected int entityBuffer;

	// Token: 0x0400065F RID: 1631
	protected int entityQueue;

	// Token: 0x04000660 RID: 1632
	public float roamDistance;

	// Token: 0x04000661 RID: 1633
	public float renderDistance;

	// Token: 0x04000662 RID: 1634
	public int entityCap = 3;

	// Token: 0x04000663 RID: 1635
	public float respawnTime = 60f;

	// Token: 0x04000664 RID: 1636
	public float updateRate = 2f;

	// Token: 0x04000665 RID: 1637
	private bool rendered;

	// Token: 0x04000666 RID: 1638
	public LayerMask whatIsGround;
}
