
using UnityEngine;

// Token: 0x02000101 RID: 257
public class ZoneController : MonoBehaviour
{
	// Token: 0x0600077D RID: 1917 RVA: 0x000250B8 File Offset: 0x000232B8
	private void Awake()
	{
		ZoneController.Instance = this;
		this.maxScale = base.transform.localScale.x;
		this.desiredZoneScale = this.maxScale;
		base.InvokeRepeating("SlowUpdate", this.updateRate, this.updateRate);
	}

	// Token: 0x0600077E RID: 1918 RVA: 0x00025104 File Offset: 0x00023304
	private void Start()
	{
		this.AdjustZoneHeight();
	}

	// Token: 0x0600077F RID: 1919 RVA: 0x0002510C File Offset: 0x0002330C
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

	// Token: 0x06000780 RID: 1920 RVA: 0x00025184 File Offset: 0x00023384
	public void NextDay(int day)
	{
		int gameLength = (int)GameManager.gameSettings.gameLength;
		this.currentDay = day;
		this.desiredZoneScale = 1f - (float)this.currentDay / (float)gameLength;
		this.desiredZoneScale = Mathf.Clamp(this.desiredZoneScale, 0f, 1f);
		this.desiredZoneScale *= this.maxScale;
	}

	// Token: 0x06000781 RID: 1921 RVA: 0x000251E8 File Offset: 0x000233E8
	private void SlowUpdate()
	{
		if (!PlayerMovement.Instance || PlayerStatus.Instance.IsPlayerDead())
		{
			return;
		}
		Vector3 position = PlayerMovement.Instance.transform.position;
		if (Vector3.Distance(Vector3.zero, position) > base.transform.localScale.x)
		{
			PlayerStatus.Instance.DealDamage(this.baseDamage * GameManager.instance.currentDay + 1);
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

	// Token: 0x06000782 RID: 1922 RVA: 0x000252E0 File Offset: 0x000234E0
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

	// Token: 0x04000707 RID: 1799
	private int baseDamage = 1;

	// Token: 0x04000708 RID: 1800
	private float threshold = 1.5f;

	// Token: 0x04000709 RID: 1801
	private float updateRate = 0.5f;

	// Token: 0x0400070A RID: 1802
	private bool inZone;

	// Token: 0x0400070B RID: 1803
	public Transform audio;

	// Token: 0x0400070C RID: 1804
	public AudioSource transition;

	// Token: 0x0400070D RID: 1805
	public AudioSource damageAudio;

	// Token: 0x0400070E RID: 1806
	private float maxScale;

	// Token: 0x0400070F RID: 1807
	public static ZoneController Instance;

	// Token: 0x04000710 RID: 1808
	public LayerMask whatIsGround;

	// Token: 0x04000711 RID: 1809
	private int currentDay;

	// Token: 0x04000712 RID: 1810
	private float desiredZoneScale;

	// Token: 0x04000713 RID: 1811
	private float zoneSpeed = 5f;
}
