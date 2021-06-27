using System;
using UnityEngine;

// Token: 0x0200001B RID: 27
public class CooldownBar : MonoBehaviour
{
	// Token: 0x060000A2 RID: 162 RVA: 0x00005178 File Offset: 0x00003378
	private void Awake()
	{
		CooldownBar.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x060000A3 RID: 163 RVA: 0x0000518C File Offset: 0x0000338C
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

	// Token: 0x060000A4 RID: 164 RVA: 0x00005228 File Offset: 0x00003428
	public void ResetCooldown(float speedMultiplier)
	{
		this.t = 0f;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		this.timeToReachTarget = this.time / speedMultiplier;
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x060000A5 RID: 165 RVA: 0x00005284 File Offset: 0x00003484
	public void ResetCooldownTime(float time, bool stayOnScreen)
	{
		this.stayOnScreen = stayOnScreen;
		this.t = 0f;
		this.timeToReachTarget = time;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x060000A6 RID: 166 RVA: 0x000052DF File Offset: 0x000034DF
	public void HideBar()
	{
		this.t = this.timeToReachTarget;
		base.gameObject.SetActive(false);
	}

	// Token: 0x040000A8 RID: 168
	public Transform cooldownBar;

	// Token: 0x040000A9 RID: 169
	private float time = 1f;

	// Token: 0x040000AA RID: 170
	private float t;

	// Token: 0x040000AB RID: 171
	private float timeToReachTarget;

	// Token: 0x040000AC RID: 172
	public static CooldownBar Instance;

	// Token: 0x040000AD RID: 173
	private bool stayOnScreen;
}
