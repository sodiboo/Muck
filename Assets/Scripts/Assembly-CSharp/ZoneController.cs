using System;
using UnityEngine;

// Token: 0x02000158 RID: 344
public class ZoneController : MonoBehaviour
{
	// Token: 0x0600083C RID: 2108 RVA: 0x000281E4 File Offset: 0x000263E4
	private void Awake()
	{
		ZoneController.Instance = this;
		this.maxScale = base.transform.localScale.x;
		this.desiredZoneScale = this.maxScale;
		base.InvokeRepeating("SlowUpdate", this.updateRate, this.updateRate);
	}

	// Token: 0x0600083D RID: 2109 RVA: 0x000075F7 File Offset: 0x000057F7
	private void Start()
	{
		this.AdjustZoneHeight();
	}

	// Token: 0x0600083E RID: 2110 RVA: 0x00028230 File Offset: 0x00026430
	private void AdjustZoneHeight()
	{
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position + Vector3.up * 500f, Vector3.down, out raycastHit, 1000f, this.whatIsGround))
		{
			Vector3 position = base.transform.position;
			position.y = raycastHit.point.y;
			base.transform.position = position;
		}
	}

	// Token: 0x0600083F RID: 2111 RVA: 0x000282A8 File Offset: 0x000264A8
	public void NextDay(int day)
	{
		int gameLength = (int)GameManager.gameSettings.gameLength;
		this.currentDay = day;
		this.desiredZoneScale = 1f - (float)this.currentDay / (float)gameLength;
		this.desiredZoneScale = Mathf.Clamp(this.desiredZoneScale, 0f, 1f);
		this.desiredZoneScale *= this.maxScale;
	}

	// Token: 0x06000840 RID: 2112 RVA: 0x0002830C File Offset: 0x0002650C
	private void SlowUpdate()
	{
		if (!PlayerMovement.Instance || PlayerStatus.Instance.IsPlayerDead())
		{
			return;
		}
		Vector3 position = PlayerMovement.Instance.transform.position;
		if (Vector3.Distance(Vector3.zero, position) > base.transform.localScale.x)
		{
			PlayerStatus.Instance.DealDamage(this.baseDamage * GameManager.instance.currentDay + 1, false);
			this.audio.transform.position = position;
			this.damageAudio.Play();
			if (this.inZone)
			{
				return;
			}
			this.transition.Play();
			this.inZone = true;
			PPController.Instance.SetChromaticAberration(1f);
			ZoneVignette.Instance.SetVignette(true);
			return;
		}
		else
		{
			if (!this.inZone)
			{
				return;
			}
			this.transition.Play();
			this.inZone = false;
			ZoneVignette.Instance.SetVignette(false);
			PPController.Instance.SetChromaticAberration(0f);
			return;
		}
	}

	// Token: 0x06000841 RID: 2113 RVA: 0x00028404 File Offset: 0x00026604
	private void Update()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		Vector3 position = PlayerMovement.Instance.transform.position;
		if (!this.inZone)
		{
			Vector3 normalized = (position - Vector3.zero).normalized;
			this.audio.transform.position = Vector3.zero + normalized * base.transform.localScale.x;
		}
		else
		{
			this.audio.transform.position = position;
		}
		if (base.transform.localScale.x > this.desiredZoneScale && base.transform.localScale.x > 0f)
		{
			if (base.transform.localScale.x < 40f)
			{
				this.zoneSpeed = 1f;
			}
			base.transform.localScale -= Vector3.one * this.zoneSpeed * Time.deltaTime;
		}
	}

	// Token: 0x0400087A RID: 2170
	private int baseDamage = 1;

	// Token: 0x0400087B RID: 2171
	private float threshold = 1.5f;

	// Token: 0x0400087C RID: 2172
	private float updateRate = 0.5f;

	// Token: 0x0400087D RID: 2173
	private bool inZone;

	// Token: 0x0400087E RID: 2174
	public Transform audio;

	// Token: 0x0400087F RID: 2175
	public AudioSource transition;

	// Token: 0x04000880 RID: 2176
	public AudioSource damageAudio;

	// Token: 0x04000881 RID: 2177
	private float maxScale;

	// Token: 0x04000882 RID: 2178
	public static ZoneController Instance;

	// Token: 0x04000883 RID: 2179
	public LayerMask whatIsGround;

	// Token: 0x04000884 RID: 2180
	private int currentDay;

	// Token: 0x04000885 RID: 2181
	private float desiredZoneScale;

	// Token: 0x04000886 RID: 2182
	private float zoneSpeed = 5f;
}
