using System;
using UnityEngine;

public class GraveInteract : MonoBehaviour, SharedObject, Interactable
{
	public int playerId { get; set; }

	public string username { get; set; }

	public float timeLeft { get; set; } = 30f;

	public void SetTime(float time)
	{
		this.timeLeft = time;
	}

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

	private void StartHolding()
	{
		CooldownBar.Instance.ResetCooldownTime(this.requiredHoldTime, true);
		this.holding = true;
		this.holdTime = 0f;
	}

	private void StopHolding()
	{
		this.holding = false;
		CooldownBar.Instance.HideBar();
		this.holdTime = 0f;
	}

	public void Interact()
	{
		if (!this.IsDay() || this.timeLeft > 0f)
		{
			return;
		}
		this.StartHolding();
	}

	public void LocalExecute()
	{
	}

	public void AllExecute()
	{
		Destroy(base.gameObject.transform.parent.gameObject);
	}

	public void ServerExecute(int fromClient)
	{
	}

	public void RemoveObject()
	{
		Destroy(base.gameObject.transform.parent.gameObject);
	}

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

	public bool IsStarted()
	{
		return false;
	}

	public void SetId(int id)
	{
		this.id = id;
	}

	public int GetId()
	{
		return this.id;
	}

	public bool IsDay()
	{
		return DayCycle.time > 0f && DayCycle.time < 0.5f;
	}

	private int id;

	private bool holding;

	private float holdTime;

	private float requiredHoldTime = 3f;
}
