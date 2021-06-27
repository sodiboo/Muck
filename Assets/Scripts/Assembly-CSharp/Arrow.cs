using System;
using UnityEngine;

public class Arrow : MonoBehaviour
{
	public InventoryItem item { get; set; }

	public int damage { get; set; }

	public bool otherPlayersArrow { get; set; }

	private void Awake()
	{
		this.rb = base.GetComponent<Rigidbody>();
	}

	private void Update()
	{
		base.transform.rotation = Quaternion.LookRotation(this.rb.velocity);
	}

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
		ParticleSystem component = Instantiate<GameObject>(this.hitFx, position, Quaternion.LookRotation(forward)).GetComponent<ParticleSystem>();
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

	private Rigidbody rb;

	public AudioSource audio;

	public TrailRenderer trail;

	public GameObject hitFx;

	public bool fallingWhileShooting;

	public float speedWhileShooting;

	private bool done;
}
