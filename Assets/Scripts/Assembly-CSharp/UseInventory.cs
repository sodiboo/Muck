using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A8 RID: 168
public class UseInventory : MonoBehaviour
{
	// Token: 0x0600045F RID: 1119 RVA: 0x000167D4 File Offset: 0x000149D4
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

	// Token: 0x06000460 RID: 1120 RVA: 0x00016898 File Offset: 0x00014A98
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

	// Token: 0x06000461 RID: 1121 RVA: 0x000169B0 File Offset: 0x00014BB0
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

	// Token: 0x06000462 RID: 1122 RVA: 0x00016A10 File Offset: 0x00014C10
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

	// Token: 0x06000463 RID: 1123 RVA: 0x00016A78 File Offset: 0x00014C78
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
			Invoke(nameof(FinishEating), num * 0.95f);
			Invoke(nameof(StartParticles), num * 0.25f);
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

	// Token: 0x06000464 RID: 1124 RVA: 0x00016C45 File Offset: 0x00014E45
	private void StartParticles()
	{
		this.eatingEmission.enabled = true;
	}

	// Token: 0x06000465 RID: 1125 RVA: 0x00016C54 File Offset: 0x00014E54
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

	// Token: 0x06000466 RID: 1126 RVA: 0x00016CE0 File Offset: 0x00014EE0
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
			GameObject gameObject = Instantiate<GameObject>(inventoryItem2.prefab);
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

	// Token: 0x06000467 RID: 1127 RVA: 0x0001704C File Offset: 0x0001524C
	private void FinishEating()
	{
		this.eatSfx.Stop();
		this.eatingEmission.enabled = false;
		PlayerStatus.Instance.Eat(this.currentItem);
		ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
		Hotbar.Instance.UseItem(1);
	}

	// Token: 0x06000468 RID: 1128 RVA: 0x00017088 File Offset: 0x00015288
	private bool IsAnimationPlaying(string animationName)
	{
		if (this.animator.GetCurrentAnimatorClipInfo(0).Length == 0)
		{
			return false;
		}
		string name = this.animator.GetCurrentAnimatorClipInfo(0)[0].clip.name;
		return name.Contains(animationName) || animationName == name;
	}

	// Token: 0x04000425 RID: 1061
	public static UseInventory Instance;

	// Token: 0x04000426 RID: 1062
	public HitBox hitBox;

	// Token: 0x04000427 RID: 1063
	public Animator animator;

	// Token: 0x04000428 RID: 1064
	public TrailRenderer swingTrail;

	// Token: 0x04000429 RID: 1065
	public RandomSfx swingSfx;

	// Token: 0x0400042A RID: 1066
	public AudioSource chargeSfx;

	// Token: 0x0400042B RID: 1067
	public AudioSource eatSfx;

	// Token: 0x0400042C RID: 1068
	public ParticleSystem eatingParticles;

	// Token: 0x0400042D RID: 1069
	private ParticleSystem.EmissionModule eatingEmission;

	// Token: 0x0400042E RID: 1070
	private ParticleSystem.VelocityOverLifetimeModule velocity;

	// Token: 0x0400042F RID: 1071
	private float eatTime;

	// Token: 0x04000430 RID: 1072
	private float attackTime;

	// Token: 0x04000431 RID: 1073
	private float chargeTime;

	// Token: 0x04000432 RID: 1074
	public MeshRenderer meshRenderer;

	// Token: 0x04000433 RID: 1075
	public MeshFilter meshFilter;

	// Token: 0x04000434 RID: 1076
	public Transform renderTransform;

	// Token: 0x04000435 RID: 1077
	private InventoryItem currentItem;
}
