using System;
using UnityEngine;

public class CooldownBar : MonoBehaviour
{
	private void Awake()
	{
		CooldownBar.Instance = this;
		base.gameObject.SetActive(false);
	}

	private void Update()
	{
		if (this.timeToReachTarget == 0f || this.t >= this.timeToReachTarget)
		{
			return;
		}
		this.t += Time.deltaTime;
		this.cooldownBar.transform.localScale = new Vector3(this.t / this.timeToReachTarget, 1f, 1f);
		if (this.t >= this.timeToReachTarget)
		{
			this.t = this.timeToReachTarget;
			if (!this.stayOnScreen)
			{
				base.transform.gameObject.SetActive(false);
			}
		}
	}

	public void ResetCooldown(float speedMultiplier)
	{
		this.t = 0f;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		this.timeToReachTarget = this.time / speedMultiplier;
		base.transform.gameObject.SetActive(true);
	}

	public void ResetCooldownTime(float time, bool stayOnScreen)
	{
		this.stayOnScreen = stayOnScreen;
		this.t = 0f;
		this.timeToReachTarget = time;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		base.transform.gameObject.SetActive(true);
	}

	public void HideBar()
	{
		this.t = this.timeToReachTarget;
		base.gameObject.SetActive(false);
	}

	public Transform cooldownBar;

	private float time = 1f;

	private float t;

	private float timeToReachTarget;

	public static CooldownBar Instance;

	private bool stayOnScreen;
}
