using System;
using UnityEngine;

// Token: 0x02000040 RID: 64
public class GraveInteract : MonoBehaviour, SharedObject, Interactable
{
	// Token: 0x1700000F RID: 15
	// (get) Token: 0x06000176 RID: 374 RVA: 0x00009333 File Offset: 0x00007533
	// (set) Token: 0x06000177 RID: 375 RVA: 0x0000933B File Offset: 0x0000753B
	public int playerId { get; set; }

	// Token: 0x17000010 RID: 16
	// (get) Token: 0x06000178 RID: 376 RVA: 0x00009344 File Offset: 0x00007544
	// (set) Token: 0x06000179 RID: 377 RVA: 0x0000934C File Offset: 0x0000754C
	public string username { get; set; }

	// Token: 0x17000011 RID: 17
	// (get) Token: 0x0600017A RID: 378 RVA: 0x00009355 File Offset: 0x00007555
	// (set) Token: 0x0600017B RID: 379 RVA: 0x0000935D File Offset: 0x0000755D
	public float timeLeft { get; set; } = 30f;

	// Token: 0x0600017C RID: 380 RVA: 0x00009366 File Offset: 0x00007566
	public void SetTime(float time)
	{
		this.timeLeft = time;
	}

	// Token: 0x0600017D RID: 381 RVA: 0x00009370 File Offset: 0x00007570
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

	// Token: 0x0600017E RID: 382 RVA: 0x00009447 File Offset: 0x00007647
	private void StartHolding()
	{
		CooldownBar.Instance.ResetCooldownTime(this.requiredHoldTime, true);
		this.holding = true;
		this.holdTime = 0f;
	}

	// Token: 0x0600017F RID: 383 RVA: 0x0000946C File Offset: 0x0000766C
	private void StopHolding()
	{
		this.holding = false;
		CooldownBar.Instance.HideBar();
		this.holdTime = 0f;
	}

	// Token: 0x06000180 RID: 384 RVA: 0x0000948A File Offset: 0x0000768A
	public void Interact()
	{
		if (!this.IsDay() || this.timeLeft > 0f)
		{
			return;
		}
		this.StartHolding();
	}

	// Token: 0x06000181 RID: 385 RVA: 0x000030D7 File Offset: 0x000012D7
	public void LocalExecute()
	{
	}

	// Token: 0x06000182 RID: 386 RVA: 0x000094A8 File Offset: 0x000076A8
	public void AllExecute()
	{
		Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x06000183 RID: 387 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ServerExecute(int fromClient)
	{
	}

	// Token: 0x06000184 RID: 388 RVA: 0x000094A8 File Offset: 0x000076A8
	public void RemoveObject()
	{
		Destroy(base.gameObject.transform.parent.gameObject);
	}

	// Token: 0x06000185 RID: 389 RVA: 0x000094C4 File Offset: 0x000076C4
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

	// Token: 0x06000186 RID: 390 RVA: 0x00007C91 File Offset: 0x00005E91
	public bool IsStarted()
	{
		return false;
	}

	// Token: 0x06000187 RID: 391 RVA: 0x00009523 File Offset: 0x00007723
	public void SetId(int id)
	{
		this.id = id;
	}

	// Token: 0x06000188 RID: 392 RVA: 0x0000952C File Offset: 0x0000772C
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x06000189 RID: 393 RVA: 0x00009534 File Offset: 0x00007734
	public bool IsDay()
	{
		return DayCycle.time > 0f && DayCycle.time < 0.5f;
	}

	// Token: 0x04000176 RID: 374
	private int id;

	// Token: 0x0400017A RID: 378
	private bool holding;

	// Token: 0x0400017B RID: 379
	private float holdTime;

	// Token: 0x0400017C RID: 380
	private float requiredHoldTime = 3f;
}
