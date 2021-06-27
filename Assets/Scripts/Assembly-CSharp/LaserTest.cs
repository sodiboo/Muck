using System;
using UnityEngine;

public class LaserTest : MonoBehaviour
{
	private void Awake()
	{
		this.lr.positionCount = 2;
		this.shape = this.ps.shape;
		this.vel = this.psSwirl.velocityOverLifetime;
		this.mob = base.transform.root.GetComponent<Mob>();
	}

	private void OnEnable()
	{
		this.currentPos = base.transform.position;
		this.target = this.mob.target;
		if (this.target == null)
		{
			base.gameObject.SetActive(false);
			return;
		}
		base.CancelInvoke("StopLaser");
		Invoke(nameof(StopLaser), 2.1f);
		this.hitParticles.gameObject.SetActive(true);
		InvokeRepeating(nameof(DamageEffect), this.damageUpdateRate, this.damageUpdateRate);
	}

	private void StopLaser()
	{
		this.target = base.transform;
		this.hitParticles.gameObject.SetActive(false);
		base.CancelInvoke("DamageEffect");
	}

	private void LateUpdate()
	{
		if (this.hitable == null)
		{
			Debug.LogError("Stopping");
			base.gameObject.SetActive(false);
			this.sfx.SetActive(false);
			this.StopLaser();
			return;
		}
		this.currentPos = Vector3.Lerp(this.currentPos, this.target.position, Time.deltaTime * 15f);
		float maxDistance = Vector3.Distance(base.transform.position, this.currentPos);
		RaycastHit raycastHit;
		if (Physics.Raycast(base.transform.position, base.transform.forward, out raycastHit, maxDistance, this.whatIsHittable))
		{
			this.currentPos = raycastHit.point - base.transform.forward * 0.2f;
			this.hitSomething = true;
		}
		this.targetParticles.transform.position = this.currentPos;
		base.transform.LookAt(this.target);
		float num = Vector3.Distance(base.transform.position, this.currentPos);
		this.shape.position = new Vector3(this.shape.position.x, this.shape.position.y, num / 2f);
		this.shape.scale = new Vector3(this.shape.scale.x, this.shape.scale.y, num);
		this.vel.z = num / 2f;
		this.lr.SetPosition(0, Vector3.zero);
		this.lr.SetPosition(1, Vector3.forward * num / base.transform.root.localScale.x);
		this.hitParticles.transform.position = this.currentPos;
		this.hitParticles.transform.rotation = Quaternion.LookRotation(raycastHit.normal);
	}

	private void DamageEffect()
	{
		Instantiate<GameObject>(this.damageFx, this.hitParticles.transform.position, this.hitParticles.transform.rotation);
	}

	public ParticleSystem ps;

	public ParticleSystem psSwirl;

	public LineRenderer lr;

	public Transform targetParticles;

	public LayerMask whatIsHittable;

	public Hitable hitable;

	public Transform hitParticles;

	private float damageUpdateRate = 0.1f;

	public GameObject damageFx;

	public GameObject sfx;

	private ParticleSystem.ShapeModule shape;

	private ParticleSystem.VelocityOverLifetimeModule vel;

	private Mob mob;

	public Transform target;

	private Vector3 currentPos;

	private bool hitSomething;
}
