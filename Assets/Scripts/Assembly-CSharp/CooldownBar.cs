using System;
using UnityEngine;

// Token: 0x02000017 RID: 23
public class CooldownBar : MonoBehaviour
{
	// Token: 0x06000072 RID: 114 RVA: 0x000024E3 File Offset: 0x000006E3
	private void Awake()
	{
		CooldownBar.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000073 RID: 115 RVA: 0x000091CC File Offset: 0x000073CC
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

	// Token: 0x06000074 RID: 116 RVA: 0x00009268 File Offset: 0x00007468
	public void ResetCooldown(float speedMultiplier)
	{
		this.t = 0f;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		this.timeToReachTarget = this.time / speedMultiplier;
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x06000075 RID: 117 RVA: 0x000092C4 File Offset: 0x000074C4
	public void ResetCooldownTime(float time, bool stayOnScreen)
	{
		this.stayOnScreen = stayOnScreen;
		this.t = 0f;
		this.timeToReachTarget = time;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x06000076 RID: 118 RVA: 0x000024F7 File Offset: 0x000006F7
	public void HideBar()
	{
		this.t = this.timeToReachTarget;
		base.gameObject.SetActive(false);
	}

	// Token: 0x04000074 RID: 116
	public Transform cooldownBar;

	// Token: 0x04000075 RID: 117
	private float time = 1f;

	// Token: 0x04000076 RID: 118
	private float t;

	// Token: 0x04000077 RID: 119
	private float timeToReachTarget;

	// Token: 0x04000078 RID: 120
	public static CooldownBar Instance;

	// Token: 0x04000079 RID: 121
	private bool stayOnScreen;
}
