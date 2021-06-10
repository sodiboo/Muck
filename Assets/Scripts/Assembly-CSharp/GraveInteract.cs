
using UnityEngine;

// Token: 0x0200002D RID: 45
public class GraveInteract : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x17000009 RID: 9
	// (get) Token: 0x06000108 RID: 264 RVA: 0x000076EB File Offset: 0x000058EB
	// (set) Token: 0x06000109 RID: 265 RVA: 0x000076F3 File Offset: 0x000058F3
	public int playerId { get; set; }

	// Token: 0x1700000A RID: 10
	// (get) Token: 0x0600010A RID: 266 RVA: 0x000076FC File Offset: 0x000058FC
	// (set) Token: 0x0600010B RID: 267 RVA: 0x00007704 File Offset: 0x00005904
	public string username { get; set; }

	// Token: 0x0600010C RID: 268 RVA: 0x0000770D File Offset: 0x0000590D
	private void Update()
	{
		if (this.timeLeft <= 0f)
		{
			return;
		}
		this.timeLeft -= Time.deltaTime;
		if (this.timeLeft <= 0f)
		{
			this.timeLeft = 0f;
		}
	}

	// Token: 0x0600010D RID: 269 RVA: 0x00007747 File Offset: 0x00005947
	public void Interact()
	{
		if (!this.IsDay() || this.timeLeft > 0f)
		{
			return;
		}
		ClientSend.RevivePlayer(this.playerId, this.id, true);
	}

	// Token: 0x0600010E RID: 270 RVA: 0x0000276E File Offset: 0x0000096E
	public void LocalExecute()
	{
	}

	// Token: 0x0600010F RID: 271 RVA: 0x00007771 File Offset: 0x00005971
	public void AllExecute()
	{
	Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x06000110 RID: 272 RVA: 0x0000276E File Offset: 0x0000096E
	public void ServerExecute()
	{
	}

	// Token: 0x06000111 RID: 273 RVA: 0x00007771 File Offset: 0x00005971
	public void RemoveObject()
	{
	Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x06000112 RID: 274 RVA: 0x00007790 File Offset: 0x00005990
	public string GetName()
	{
		if (this.timeLeft > 0f)
		{
			int num = Mathf.CeilToInt(this.timeLeft);
			return string.Format("Can revive {0} in {1} seconds", this.username, num);
		}
		if (this.IsDay())
		{
			return string.Format("Press {0} to revive", InputManager.interact);
		}
		return "Can only revive during day..";
	}

	// Token: 0x06000113 RID: 275 RVA: 0x000077EF File Offset: 0x000059EF
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000114 RID: 276 RVA: 0x000077F8 File Offset: 0x000059F8
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x06000115 RID: 277 RVA: 0x00007800 File Offset: 0x00005A00
	public bool IsDay()
	{
		return DayCycle.time > 0f && DayCycle.time < 0.5f;
	}

	// Token: 0x04000101 RID: 257
	private int id;

	// Token: 0x04000104 RID: 260
	private float timeLeft = 30f;
}
