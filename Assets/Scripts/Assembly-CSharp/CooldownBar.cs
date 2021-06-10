
using UnityEngine;

// Token: 0x02000014 RID: 20
public class CooldownBar : MonoBehaviour
{
	// Token: 0x0600006B RID: 107 RVA: 0x0000440D File Offset: 0x0000260D
	private void Awake()
	{
		CooldownBar.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x0600006C RID: 108 RVA: 0x00004424 File Offset: 0x00002624
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

	// Token: 0x0600006D RID: 109 RVA: 0x000044C0 File Offset: 0x000026C0
	public void ResetCooldown(float speedMultiplier)
	{
		this.t = 0f;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		this.timeToReachTarget = this.time / speedMultiplier;
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x0600006E RID: 110 RVA: 0x0000451C File Offset: 0x0000271C
	public void ResetCooldownTime(float time, bool stayOnScreen)
	{
		this.stayOnScreen = stayOnScreen;
		this.t = 0f;
		this.timeToReachTarget = time;
		this.cooldownBar.transform.localScale = new Vector3(0f, 1f, 1f);
		base.transform.gameObject.SetActive(true);
	}

	// Token: 0x0600006F RID: 111 RVA: 0x00004577 File Offset: 0x00002777
	public void HideBar()
	{
		this.t = this.timeToReachTarget;
		base.gameObject.SetActive(false);
	}

	// Token: 0x04000066 RID: 102
	public Transform cooldownBar;

	// Token: 0x04000067 RID: 103
	private float time = 1f;

	// Token: 0x04000068 RID: 104
	private float t;

	// Token: 0x04000069 RID: 105
	private float timeToReachTarget;

	// Token: 0x0400006A RID: 106
	public static CooldownBar Instance;

	// Token: 0x0400006B RID: 107
	private bool stayOnScreen;
}
