using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A1 RID: 161
public class UseInventory : MonoBehaviour
{
	// Token: 0x060003BE RID: 958 RVA: 0x00015650 File Offset: 0x00013850
	private void Awake()
	{
		UseInventory.Instance = this;
		foreach (AnimationClip animationClip in this.animator.runtimeAnimatorController.animationClips)
		{
			string name = animationClip.name;
			if (!(name == "Attack"))
			{
				if (!(name == "Eat"))
				{
					if (name == "Charge")
					{
						this.chargeTime = animationClip.length;
					}
				}
				else
				{
					this.eatTime = animationClip.length;
				}
			}
			else
			{
				this.attackTime = animationClip.length;
			}
		}
		this.eatingEmission = this.eatingParticles.emission;
		this.eatingEmission.enabled = false;
		this.velocity = this.eatingParticles.velocityOverLifetime;
		this.SetWeapon(null);
	}

	// Token: 0x060003BF RID: 959 RVA: 0x00015714 File Offset: 0x00013914
	public void SetWeapon(InventoryItem item)
	{
		this.StopUse();
		this.currentItem = item;
		if (item == null)
		{
			this.meshRenderer.material = null;
			this.meshFilter.mesh = null;
			return;
		}
		if (item.swingFx)
		{
			this.swingTrail.gameObject.SetActive(true);
		}
		else
		{
			this.swingTrail.gameObject.SetActive(false);
		}
		this.renderTransform.localRotation = Quaternion.Euler(item.rotationOffset);
		this.renderTransform.localScale = Vector3.one * item.scale;
		this.renderTransform.localPosition = item.positionOffset;
		this.meshRenderer.material = item.material;
		this.meshFilter.mesh = item.mesh;
		this.hitBox.transform.parent.localScale = item.attackRange;
		this.animator.SetFloat("AttackSpeed", this.currentItem.attackSpeed);
		this.animator.Play("Equip", -1, 0f);
	}

	// Token: 0x060003C0 RID: 960 RVA: 0x0001582C File Offset: 0x00013A2C
	private void StopUse()
	{
		if (this.IsAnimationPlaying("Eat"))
		{
			this.eatSfx.Stop();
			this.eatingEmission.enabled = false;
		}
		base.CancelInvoke();
		this.animator.Play("Idle");
		CooldownBar.Instance.HideBar();
		this.eatingEmission.enabled = false;
	}

	// Token: 0x060003C1 RID: 961 RVA: 0x0001588C File Offset: 0x00013A8C
	private void Update()
	{
		if (this.IsAnimationPlaying("Eat"))
		{
			Vector3 vector = PlayerMovement.Instance.GetVelocity();
			this.velocity.x = vector.x;
			this.velocity.y = vector.y;
			this.velocity.z = vector.z;
		}
	}

	// Token: 0x060003C2 RID: 962 RVA: 0x000158F4 File Offset: 0x00013AF4
	public void Use()
	{
		if (this.currentItem == null)
		{
			return;
		}
		if (OtherInput.Instance.IsAnyMenuOpen())
		{
			return;
		}
		if (this.IsAnimationPlaying("Attack") || this.IsAnimationPlaying("Equip") || this.IsAnimationPlaying("Eat") || this.IsAnimationPlaying("Charge") || this.IsAnimationPlaying("ChargeHold") || this.IsAnimationPlaying("Shoot"))
		{
			return;
		}
		float num = this.attackTime;
		float num2 = this.currentItem.attackSpeed;
		num2 *= PowerupInventory.Instance.GetAttackSpeedMultiplier(null);
		num /= num2;
		bool stayOnScreen = false;
		string stateName;
		if (this.currentItem.tag == InventoryItem.ItemTag.Food)
		{
			num = this.eatTime / num2;
			stateName = "Eat";
			this.eatSfx.Stop();
			base.CancelInvoke("FinishEating");
			this.eatSfx.PlayDelayed(0.3f / num2);
			ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, true);
			base.Invoke("FinishEating", num * 0.95f);
			base.Invoke("StartParticles", num * 0.25f);
		}
		else if (this.currentItem.type == InventoryItem.ItemType.Bow)
		{
			float robinMultiplier = PowerupInventory.Instance.GetRobinMultiplier(null);
			num = this.chargeTime / (num2 * robinMultiplier);
			stateName = "Charge";
			ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, true);
			this.chargeSfx.Play();
			this.chargeSfx.pitch = this.currentItem.attackSpeed;
			stayOnScreen = true;
		}
		else
		{
			this.swingSfx.Randomize(0.15f / num2);
			stateName = "Attack" + Random.Range(1, 4);
			ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Attack, true);
		}
		this.animator.Play(stateName);
		this.animator.SetFloat("AttackSpeed", num2);
		CooldownBar.Instance.ResetCooldownTime(num, stayOnScreen);
	}

	// Token: 0x060003C3 RID: 963 RVA: 0x00004A8F File Offset: 0x00002C8F
	private void StartParticles()
	{
		this.eatingEmission.enabled = true;
	}

	// Token: 0x060003C4 RID: 964 RVA: 0x00015AC4 File Offset: 0x00013CC4
	public void UseButtonUp()
	{
		if (this.IsAnimationPlaying("Eat"))
		{
			this.animator.Play("Idle");
			this.eatingEmission.enabled = false;
			CooldownBar.Instance.HideBar();
			this.eatSfx.Stop();
			ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
			base.CancelInvoke();
		}
		if (this.IsAnimationPlaying("Charge") || this.IsAnimationPlaying("ChargeHold"))
		{
			this.chargeSfx.Stop();
			ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, false);
			this.ReleaseWeapon();
		}
	}

	// Token: 0x060003C5 RID: 965 RVA: 0x00015B50 File Offset: 0x00013D50
	private void ReleaseWeapon()
	{
		float num = 0f;
		if (this.IsAnimationPlaying("ChargeHold"))
		{
			num = 1f;
		}
		else
		{
			num = this.animator.GetCurrentAnimatorStateInfo(0).normalizedTime;
			MonoBehaviour.print("charge: " + num);
		}
		ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Charge, false);
		this.animator.Play("Shoot", -1, 0f);
		CooldownBar.Instance.HideBar();
		if (InventoryUI.Instance.arrows.currentItem == null)
		{
			return;
		}
		InventoryItem inventoryItem = Hotbar.Instance.currentItem;
		InventoryItem inventoryItem2 = InventoryUI.Instance.arrows.currentItem;
		List<Collider> list = new List<Collider>();
		int num2 = 0;
		while (num2 < inventoryItem.bowComponent.nArrows && !(InventoryUI.Instance.arrows.currentItem == null))
		{
			inventoryItem2.amount--;
			if (inventoryItem2.amount <= 0)
			{
				InventoryUI.Instance.arrows.currentItem = null;
			}
			Vector3 vector = PlayerMovement.Instance.playerCam.position + Vector3.down * 0.5f;
			Vector3 vector2 = PlayerMovement.Instance.playerCam.forward;
			float num3 = (float)inventoryItem.bowComponent.angleDelta;
			vector2 = Quaternion.AngleAxis(-(num3 * (float)(inventoryItem.bowComponent.nArrows - 1)) / 2f + num3 * (float)num2, PlayerMovement.Instance.playerCam.up) * vector2;
			GameObject gameObject =Instantiate<GameObject>(inventoryItem2.prefab);
			gameObject.GetComponent<Renderer>().material = inventoryItem2.material;
			gameObject.transform.position = vector;
			gameObject.transform.rotation = base.transform.rotation;
			float num4 = (float)Hotbar.Instance.currentItem.attackDamage;
			float num5 = (float)inventoryItem2.attackDamage;
			float projectileSpeed = inventoryItem.bowComponent.projectileSpeed;
			Rigidbody component = gameObject.GetComponent<Rigidbody>();
			float num6 = 100f * num * projectileSpeed * PowerupInventory.Instance.GetRobinMultiplier(null);
			component.AddForce(vector2 * num6);
			Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), PlayerMovement.Instance.GetPlayerCollider(), true);
			float num7 = num5 * num4;
			num7 *= num;
			Arrow component2 = gameObject.GetComponent<Arrow>();
			component2.damage = (int)(num7 * PowerupInventory.Instance.GetRobinMultiplier(null));
			component2.fallingWhileShooting = (!PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f);
			component2.speedWhileShooting = PlayerMovement.Instance.GetVelocity().magnitude;
			component2.item = inventoryItem2;
			ClientSend.ShootArrow(vector, vector2, num6, inventoryItem2.id);
			list.Add(component2.GetComponent<Collider>());
			num2++;
		}
		foreach (Collider collider in list)
		{
			foreach (Collider collider2 in list)
			{
				Physics.IgnoreCollision(collider, collider2, true);
			}
		}
		InventoryUI.Instance.arrows.UpdateCell();
		CameraShaker.Instance.ChargeShake(num);
	}

	// Token: 0x060003C6 RID: 966 RVA: 0x00004A9D File Offset: 0x00002C9D
	private void FinishEating()
	{
		this.eatSfx.Stop();
		this.eatingEmission.enabled = false;
		PlayerStatus.Instance.Eat(this.currentItem);
		ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
		Hotbar.Instance.UseItem(1);
	}

	// Token: 0x060003C7 RID: 967 RVA: 0x00015EBC File Offset: 0x000140BC
	private bool IsAnimationPlaying(string animationName)
	{
		if (this.animator.GetCurrentAnimatorClipInfo(0).Length == 0)
		{
			return false;
		}
		string name = this.animator.GetCurrentAnimatorClipInfo(0)[0].clip.name;
		return name.Contains(animationName) || animationName == name;
	}

	// Token: 0x040003B8 RID: 952
	public static UseInventory Instance;

	// Token: 0x040003B9 RID: 953
	public HitBox hitBox;

	// Token: 0x040003BA RID: 954
	public Animator animator;

	// Token: 0x040003BB RID: 955
	public TrailRenderer swingTrail;

	// Token: 0x040003BC RID: 956
	public RandomSfx swingSfx;

	// Token: 0x040003BD RID: 957
	public AudioSource chargeSfx;

	// Token: 0x040003BE RID: 958
	public AudioSource eatSfx;

	// Token: 0x040003BF RID: 959
	public ParticleSystem eatingParticles;

	// Token: 0x040003C0 RID: 960
	private ParticleSystem.EmissionModule eatingEmission;

	// Token: 0x040003C1 RID: 961
	private ParticleSystem.VelocityOverLifetimeModule velocity;

	// Token: 0x040003C2 RID: 962
	private float eatTime;

	// Token: 0x040003C3 RID: 963
	private float attackTime;

	// Token: 0x040003C4 RID: 964
	private float chargeTime;

	// Token: 0x040003C5 RID: 965
	public MeshRenderer meshRenderer;

	// Token: 0x040003C6 RID: 966
	public MeshFilter meshFilter;

	// Token: 0x040003C7 RID: 967
	public Transform renderTransform;

	// Token: 0x040003C8 RID: 968
	private InventoryItem currentItem;
}
