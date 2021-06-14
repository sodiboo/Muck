using System;
using UnityEngine;

// Token: 0x02000003 RID: 3
public class Arrow : MonoBehaviour
{
	// Token: 0x17000001 RID: 1
	// (get) Token: 0x06000003 RID: 3 RVA: 0x0000209C File Offset: 0x0000029C
	// (set) Token: 0x06000004 RID: 4 RVA: 0x000020A4 File Offset: 0x000002A4
	public InventoryItem item { get; set; }

	// Token: 0x17000002 RID: 2
	// (get) Token: 0x06000005 RID: 5 RVA: 0x000020AD File Offset: 0x000002AD
	// (set) Token: 0x06000006 RID: 6 RVA: 0x000020B5 File Offset: 0x000002B5
	public int damage { get; set; }

	// Token: 0x17000003 RID: 3
	// (get) Token: 0x06000007 RID: 7 RVA: 0x000020BE File Offset: 0x000002BE
	// (set) Token: 0x06000008 RID: 8 RVA: 0x000020C6 File Offset: 0x000002C6
	public bool otherPlayersArrow { get; set; }

	// Token: 0x06000009 RID: 9 RVA: 0x000020CF File Offset: 0x000002CF
	private void Awake()
	{
		this.rb = base.GetComponent<Rigidbody>();
	}

	// Token: 0x0600000A RID: 10 RVA: 0x000020DD File Offset: 0x000002DD
	private void Update()
	{
		base.transform.rotation = Quaternion.LookRotation(this.rb.velocity);
	}

	// Token: 0x0600000B RID: 11 RVA: 0x00007734 File Offset: 0x00005934
	private void OnCollisionEnter(Collision other)
	{
		if (this.done)
		{
			return;
		}
		this.done = true;
		int layer = other.gameObject.layer;
		if (!this.otherPlayersArrow && (layer == LayerMask.NameToLayer("Player") || layer == LayerMask.NameToLayer("Enemy")))
		{
			Hitable componentInChildren = other.transform.root.GetComponentInChildren<Hitable>();
			if (!componentInChildren)
			{
				return;
			}
			PowerupCalculations.DamageResult damageMultiplier = PowerupCalculations.Instance.GetDamageMultiplier(this.fallingWhileShooting, this.speedWhileShooting);
			float damageMultiplier2 = damageMultiplier.damageMultiplier;
			bool flag = damageMultiplier.crit;
			float lifesteal = damageMultiplier.lifesteal;
			int num = (int)((float)this.damage * damageMultiplier2);
			Mob component = componentInChildren.GetComponent<Mob>();
			if (component && this.item.attackTypes != null && component.mobType.weaknesses != null)
			{
				foreach (MobType.Weakness weakness in component.mobType.weaknesses)
				{
					foreach (MobType.Weakness weakness2 in this.item.attackTypes)
					{
						Debug.LogError(string.Concat(new object[]
						{
							"checking: ",
							weakness,
							", a: ",
							weakness2
						}));
						if (weakness2 == weakness)
						{
							flag = true;
							num *= 2;
						}
					}
				}
			}
			Vector3 pos = other.collider.ClosestPoint(base.transform.position);
			HitEffect hitEffect = HitEffect.Normal;
			if (damageMultiplier.sniped)
			{
				hitEffect = HitEffect.Big;
			}
			else if (flag)
			{
				hitEffect = HitEffect.Crit;
			}
			else if (damageMultiplier.falling)
			{
				hitEffect = HitEffect.Falling;
			}
			componentInChildren.Hit(num, 1f, (int)hitEffect, pos);
			PlayerStatus.Instance.Heal(Mathf.CeilToInt((float)num * lifesteal));
			if (damageMultiplier.sniped)
			{
				PowerupCalculations.Instance.HitEffect(PowerupCalculations.Instance.sniperSfx);
			}
			if (flag)
			{
				PowerupInventory.Instance.StartJuice();
			}
			if (damageMultiplier2 > 0f && damageMultiplier.hammerMultiplier > 0f)
			{
				int num2 = 0;
				PowerupCalculations.Instance.SpawnOnHitEffect(num2, true, pos, (int)((float)num * damageMultiplier.hammerMultiplier));
				ClientSend.SpawnEffect(num2, pos);
			}
		}
		this.StopArrow(other);
	}

	// Token: 0x0600000C RID: 12 RVA: 0x00007970 File Offset: 0x00005B70
	private void StopArrow(Collision other)
	{
		this.rb.isKinematic = true;
		base.transform.SetParent(other.transform);
		this.done = true;
		base.gameObject.AddComponent<DestroyObject>().time = 10f;
	Destroy(this);
	Destroy(this.audio);
		this.trail.emitting = false;
		Vector3 position = base.transform.position;
		Vector3 forward = -base.transform.forward;
		ParticleSystem component =Instantiate<GameObject>(this.hitFx, position, Quaternion.LookRotation(forward)).GetComponent<ParticleSystem>();
		Renderer component2 = other.gameObject.GetComponent<Renderer>();
		Material material = null;
		if (component2 != null)
		{
			material = component2.material;
		}
		else
		{
			SkinnedMeshRenderer componentInChildren = other.transform.root.GetComponentInChildren<SkinnedMeshRenderer>();
			if (componentInChildren)
			{
				material = componentInChildren.material;
			}
		}
		if (material)
		{
			component.GetComponent<Renderer>().material = material;
		}
	Destroy(base.gameObject);
	}

	// Token: 0x04000002 RID: 2
	private Rigidbody rb;

	// Token: 0x04000003 RID: 3
	public AudioSource audio;

	// Token: 0x04000004 RID: 4
	public TrailRenderer trail;

	// Token: 0x04000006 RID: 6
	public GameObject hitFx;

	// Token: 0x04000008 RID: 8
	public bool fallingWhileShooting;

	// Token: 0x04000009 RID: 9
	public float speedWhileShooting;

	// Token: 0x0400000B RID: 11
	private bool done;
}
