using System;
using UnityEngine;

// Token: 0x02000036 RID: 54
public class GraveInteract : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x1700000A RID: 10
	// (get) Token: 0x0600011D RID: 285 RVA: 0x00002DFA File Offset: 0x00000FFA
	// (set) Token: 0x0600011E RID: 286 RVA: 0x00002E02 File Offset: 0x00001002
	public int playerId { get; set; }

	// Token: 0x1700000B RID: 11
	// (get) Token: 0x0600011F RID: 287 RVA: 0x00002E0B File Offset: 0x0000100B
	// (set) Token: 0x06000120 RID: 288 RVA: 0x00002E13 File Offset: 0x00001013
	public string username { get; set; }

	// Token: 0x1700000C RID: 12
	// (get) Token: 0x06000121 RID: 289 RVA: 0x00002E1C File Offset: 0x0000101C
	// (set) Token: 0x06000122 RID: 290 RVA: 0x00002E24 File Offset: 0x00001024
	public float timeLeft { get; set; } = 30f;

	// Token: 0x06000123 RID: 291 RVA: 0x00002E2D File Offset: 0x0000102D
	public void SetTime(float time)
	{
		this.timeLeft = time;
	}

	// Token: 0x06000124 RID: 292 RVA: 0x0000BF84 File Offset: 0x0000A184
	private void Update()
	{
		if (this.timeLeft > 0f)
		{
			this.timeLeft -= Time.deltaTime;
			if (this.timeLeft <= 0f)
			{
				this.timeLeft = 0f;
			}
		}
		if (this.holding)
		{
			if (!PlayerMovement.Instance || Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) > 6f || !Input.GetKey(InputManager.interact) || PlayerStatus.Instance.IsPlayerDead())
			{
				this.StopHolding();
			}
			this.holdTime += Time.deltaTime;
			if (this.holdTime >= this.requiredHoldTime)
			{
				ClientSend.RevivePlayer(this.playerId, this.id, true);
				this.StopHolding();
			}
		}
	}

	// Token: 0x06000125 RID: 293 RVA: 0x00002E36 File Offset: 0x00001036
	private void StartHolding()
	{
		CooldownBar.Instance.ResetCooldownTime(this.requiredHoldTime, true);
		this.holding = true;
		this.holdTime = 0f;
	}

	// Token: 0x06000126 RID: 294 RVA: 0x00002E5B File Offset: 0x0000105B
	private void StopHolding()
	{
		this.holding = false;
		CooldownBar.Instance.HideBar();
		this.holdTime = 0f;
	}

	// Token: 0x06000127 RID: 295 RVA: 0x00002E79 File Offset: 0x00001079
	public void Interact()
	{
		if (!this.IsDay() || this.timeLeft > 0f)
		{
			return;
		}
		this.StartHolding();
	}

	// Token: 0x06000128 RID: 296 RVA: 0x00002147 File Offset: 0x00000347
	public void LocalExecute()
	{
	}

	// Token: 0x06000129 RID: 297 RVA: 0x00002E97 File Offset: 0x00001097
	public void AllExecute()
	{
	Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x0600012A RID: 298 RVA: 0x00002147 File Offset: 0x00000347
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x0600012B RID: 299 RVA: 0x00002E97 File Offset: 0x00001097
	public void RemoveObject()
	{
	Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x0600012C RID: 300 RVA: 0x0000C05C File Offset: 0x0000A25C
	public string GetName()
	{
		if (this.timeLeft > 0f)
		{
			int num = Mathf.CeilToInt(this.timeLeft);
			return string.Format("Can revive {0} in {1} seconds", this.username, num);
		}
		if (this.IsDay())
		{
			return string.Format("Hold {0} to revive", InputManager.interact);
		}
		return "Can only revive during day..";
	}

	// Token: 0x0600012D RID: 301 RVA: 0x00002EB3 File Offset: 0x000010B3
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x0600012E RID: 302 RVA: 0x00002EB6 File Offset: 0x000010B6
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x0600012F RID: 303 RVA: 0x00002EBF File Offset: 0x000010BF
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x06000130 RID: 304 RVA: 0x00002EC7 File Offset: 0x000010C7
	public bool IsDay()
	{
		return DayCycle.time > 0f && DayCycle.time < 0.5f;
	}

	// Token: 0x04000126 RID: 294
	private int id;

	// Token: 0x0400012A RID: 298
	private bool holding;

	// Token: 0x0400012B RID: 299
	private float holdTime;

	// Token: 0x0400012C RID: 300
	private float requiredHoldTime = 3f;
}
