using System;
using UnityEngine;

// Token: 0x0200005C RID: 92
public class LaserTest : MonoBehaviour
{
	// Token: 0x0600020B RID: 523 RVA: 0x0000C778 File Offset: 0x0000A978
	private void Awake()
	{
		this.lr.positionCount = 2;
		this.shape = this.ps.shape;
		this.vel = this.psSwirl.velocityOverLifetime;
		this.mob = base.transform.root.GetComponent<Mob>();
	}

	// Token: 0x0600020C RID: 524 RVA: 0x0000C7CC File Offset: 0x0000A9CC
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

	// Token: 0x0600020D RID: 525 RVA: 0x0000C859 File Offset: 0x0000AA59
	private void StopLaser()
	{
		this.target = base.transform;
		this.hitParticles.gameObject.SetActive(false);
		base.CancelInvoke("DamageEffect");
	}

	// Token: 0x0600020E RID: 526 RVA: 0x0000C884 File Offset: 0x0000AA84
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

	// Token: 0x0600020F RID: 527 RVA: 0x0000CA90 File Offset: 0x0000AC90
	private void DamageEffect()
	{
		Instantiate<GameObject>(this.damageFx, this.hitParticles.transform.position, this.hitParticles.transform.rotation);
	}

	// Token: 0x0400021E RID: 542
	public ParticleSystem ps;

	// Token: 0x0400021F RID: 543
	public ParticleSystem psSwirl;

	// Token: 0x04000220 RID: 544
	public LineRenderer lr;

	// Token: 0x04000221 RID: 545
	public Transform targetParticles;

	// Token: 0x04000222 RID: 546
	public LayerMask whatIsHittable;

	// Token: 0x04000223 RID: 547
	public Hitable hitable;

	// Token: 0x04000224 RID: 548
	public Transform hitParticles;

	// Token: 0x04000225 RID: 549
	private float damageUpdateRate = 0.1f;

	// Token: 0x04000226 RID: 550
	public GameObject damageFx;

	// Token: 0x04000227 RID: 551
	public GameObject sfx;

	// Token: 0x04000228 RID: 552
	private ParticleSystem.ShapeModule shape;

	// Token: 0x04000229 RID: 553
	private ParticleSystem.VelocityOverLifetimeModule vel;

	// Token: 0x0400022A RID: 554
	private Mob mob;

	// Token: 0x0400022B RID: 555
	public Transform target;

	// Token: 0x0400022C RID: 556
	private Vector3 currentPos;

	// Token: 0x0400022D RID: 557
	private bool hitSomething;
}
