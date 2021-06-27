using System;
using UnityEngine;

// Token: 0x02000035 RID: 53
public class FinishGameInteract : MonoBehaviour, Interactable, SharedObject
{
	// Token: 0x06000135 RID: 309 RVA: 0x00007B7C File Offset: 0x00005D7C
	private void Awake()
	{
		foreach (Collider collider in base.GetComponents<Collider>())
		{
			if (collider.isTrigger)
			{
				collider.enabled = true;
			}
		}
		base.gameObject.layer = LayerMask.NameToLayer("Interact");
	}

	// Token: 0x06000136 RID: 310 RVA: 0x00007BC8 File Offset: 0x00005DC8
	public void Interact()
	{
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		if (Boat.Instance.countPlayers.players.Count >= playersInLobby)
		{
			ClientSend.Interact(this.id);
		}
	}

	// Token: 0x06000137 RID: 311 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x06000138 RID: 312 RVA: 0x00007C02 File Offset: 0x00005E02
	public void AllExecute()
	{
		Boat.Instance.LeaveIsland();
	}

	// Token: 0x06000139 RID: 313 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient = -1)
	{
	}

	// Token: 0x0600013A RID: 314 RVA: 0x000030D7 File Offset: 0x000012D7
	public void RemoveObject()
	{
	}

	// Token: 0x0600013B RID: 315 RVA: 0x00007C10 File Offset: 0x00005E10
	public string GetName()
	{
		int playersInLobby = GameManager.instance.GetPlayersInLobby();
		int count = Boat.Instance.countPlayers.players.Count;
		if (count >= playersInLobby)
		{
			return string.Format("Press {0} to leave Muck!", InputManager.interact) + string.Format("\n({0}/{1})", count, playersInLobby);
		}
		return "Get all players on the ship!" + string.Format("\n({0}/{1})", count, playersInLobby);
	}

	// Token: 0x0600013C RID: 316 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0600013D RID: 317 RVA: 0x00007C94 File Offset: 0x00005E94
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600013E RID: 318 RVA: 0x00007C9D File Offset: 0x00005E9D
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x0400013B RID: 315
	private int id;
}
