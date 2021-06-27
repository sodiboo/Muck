using System;
using UnityEngine;

// Token: 0x02000134 RID: 308
public class ZoneController : MonoBehaviour
{
	// Token: 0x060008C9 RID: 2249 RVA: 0x0002BAA4 File Offset: 0x00029CA4
	private void Awake()
	{
		ZoneController.Instance = this;
		this.maxScale = base.transform.localScale.x;
		this.desiredZoneScale = this.maxScale;
		InvokeRepeating(nameof(SlowUpdate), this.updateRate, this.updateRate);
	}

	// Token: 0x060008CA RID: 2250 RVA: 0x0002BAF0 File Offset: 0x00029CF0
	private void Start()
	{
		this.AdjustZoneHeight();
	}

	// Token: 0x060008CB RID: 2251 RVA: 0x0002BAF8 File Offset: 0x00029CF8
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

	// Token: 0x060008CC RID: 2252 RVA: 0x0002BB70 File Offset: 0x00029D70
	public void NextDay(int day)
	{
		int gameLength = (int)GameManager.gameSettings.gameLength;
		this.currentDay = day;
		this.desiredZoneScale = 1f - (float)this.currentDay / (float)gameLength;
		this.desiredZoneScale = Mathf.Clamp(this.desiredZoneScale, 0f, 1f);
		this.desiredZoneScale *= this.maxScale;
	}

	// Token: 0x060008CD RID: 2253 RVA: 0x0002BBD4 File Offset: 0x00029DD4
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

	// Token: 0x060008CE RID: 2254 RVA: 0x0002BCCC File Offset: 0x00029ECC
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

	// Token: 0x04000855 RID: 2133
	private int baseDamage = 1;

	// Token: 0x04000856 RID: 2134
	private float threshold = 1.5f;

	// Token: 0x04000857 RID: 2135
	private float updateRate = 0.5f;

	// Token: 0x04000858 RID: 2136
	private bool inZone;

	// Token: 0x04000859 RID: 2137
	public Transform audio;

	// Token: 0x0400085A RID: 2138
	public AudioSource transition;

	// Token: 0x0400085B RID: 2139
	public AudioSource damageAudio;

	// Token: 0x0400085C RID: 2140
	private float maxScale;

	// Token: 0x0400085D RID: 2141
	public static ZoneController Instance;

	// Token: 0x0400085E RID: 2142
	public LayerMask whatIsGround;

	// Token: 0x0400085F RID: 2143
	private int currentDay;

	// Token: 0x04000860 RID: 2144
	private float desiredZoneScale;

	// Token: 0x04000861 RID: 2145
	private float zoneSpeed = 5f;
}
