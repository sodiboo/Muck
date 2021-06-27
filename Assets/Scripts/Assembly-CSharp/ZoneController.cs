using System;
using UnityEngine;

public class ZoneController : MonoBehaviour
{
	private void Awake()
	{
		ZoneController.Instance = this;
		this.maxScale = base.transform.localScale.x;
		this.desiredZoneScale = this.maxScale;
		InvokeRepeating(nameof(SlowUpdate), this.updateRate, this.updateRate);
	}

	private void Start()
	{
		this.AdjustZoneHeight();
	}

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

	public void NextDay(int day)
	{
		int gameLength = (int)GameManager.gameSettings.gameLength;
		this.currentDay = day;
		this.desiredZoneScale = 1f - (float)this.currentDay / (float)gameLength;
		this.desiredZoneScale = Mathf.Clamp(this.desiredZoneScale, 0f, 1f);
		this.desiredZoneScale *= this.maxScale;
	}

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

	private int baseDamage = 1;

	private float threshold = 1.5f;

	private float updateRate = 0.5f;

	private bool inZone;

	public Transform audio;

	public AudioSource transition;

	public AudioSource damageAudio;

	private float maxScale;

	public static ZoneController Instance;

	public LayerMask whatIsGround;

	private int currentDay;

	private float desiredZoneScale;

	private float zoneSpeed = 5f;
}
