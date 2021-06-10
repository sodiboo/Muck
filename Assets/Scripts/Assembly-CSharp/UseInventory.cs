
using UnityEngine;

// Token: 0x02000082 RID: 130
public class UseInventory : MonoBehaviour
{
	// Token: 0x06000372 RID: 882 RVA: 0x00011AD4 File Offset: 0x0000FCD4
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

	// Token: 0x06000373 RID: 883 RVA: 0x00011B98 File Offset: 0x0000FD98
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

	// Token: 0x06000374 RID: 884 RVA: 0x00011CB0 File Offset: 0x0000FEB0
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

	// Token: 0x06000375 RID: 885 RVA: 0x00011D10 File Offset: 0x0000FF10
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

	// Token: 0x06000376 RID: 886 RVA: 0x00011D78 File Offset: 0x0000FF78
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

	// Token: 0x06000377 RID: 887 RVA: 0x00011F45 File Offset: 0x00010145
	private void StartParticles()
	{
		this.eatingEmission.enabled = true;
	}

	// Token: 0x06000378 RID: 888 RVA: 0x00011F54 File Offset: 0x00010154
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

	// Token: 0x06000379 RID: 889 RVA: 0x00011FE0 File Offset: 0x000101E0
	private void ReleaseWeapon()
	{
		float num;
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
		InventoryItem inventoryItem = InventoryUI.Instance.arrows.currentItem;
		inventoryItem.amount--;
		if (inventoryItem.amount <= 0)
		{
			InventoryUI.Instance.arrows.currentItem = null;
		}
		InventoryUI.Instance.arrows.UpdateCell();
		Vector3 vector = PlayerMovement.Instance.playerCam.position + Vector3.down * 0.5f;
		Vector3 forward = PlayerMovement.Instance.playerCam.forward;
		GameObject gameObject =Instantiate(inventoryItem.prefab);
		gameObject.GetComponent<Renderer>().material = inventoryItem.material;
		gameObject.transform.position = vector;
		gameObject.transform.rotation = base.transform.rotation;
		InventoryItem inventoryItem2 = Hotbar.Instance.currentItem;
		float num2 = (float)Hotbar.Instance.currentItem.attackDamage;
		float num3 = (float)inventoryItem.attackDamage;
		float projectileSpeed = inventoryItem2.projectileSpeed;
		Rigidbody component = gameObject.GetComponent<Rigidbody>();
		float num4 = 1000f * num * projectileSpeed * PowerupInventory.Instance.GetRobinMultiplier(null);
		component.AddForce(forward * num4);
		Physics.IgnoreCollision(gameObject.GetComponent<Collider>(), PlayerMovement.Instance.GetPlayerCollider(), true);
		float num5 = num3 * num2;
		num5 *= num;
		Arrow component2 = gameObject.GetComponent<Arrow>();
		component2.damage = (int)(num5 * PowerupInventory.Instance.GetRobinMultiplier(null));
		component2.fallingWhileShooting = (!PlayerMovement.Instance.grounded && PlayerMovement.Instance.GetVelocity().y < 0f);
		component2.speedWhileShooting = PlayerMovement.Instance.GetVelocity().magnitude;
		ClientSend.ShootArrow(vector, forward, num4, inventoryItem.id);
		CameraShaker.Instance.ChargeShake(num);
	}

	// Token: 0x0600037A RID: 890 RVA: 0x0001221B File Offset: 0x0001041B
	private void FinishEating()
	{
		this.eatSfx.Stop();
		this.eatingEmission.enabled = false;
		PlayerStatus.Instance.Eat(this.currentItem);
		ClientSend.AnimationUpdate(OnlinePlayer.SharedAnimation.Eat, false);
		Hotbar.Instance.UseItem(1);
	}

	// Token: 0x0600037B RID: 891 RVA: 0x00012258 File Offset: 0x00010458
	private bool IsAnimationPlaying(string animationName)
	{
		if (this.animator.GetCurrentAnimatorClipInfo(0).Length == 0)
		{
			return false;
		}
		string name = this.animator.GetCurrentAnimatorClipInfo(0)[0].clip.name;
		return name.Contains(animationName) || animationName == name;
	}

	// Token: 0x04000328 RID: 808
	public static UseInventory Instance;

	// Token: 0x04000329 RID: 809
	public HitBox hitBox;

	// Token: 0x0400032A RID: 810
	public Animator animator;

	// Token: 0x0400032B RID: 811
	public TrailRenderer swingTrail;

	// Token: 0x0400032C RID: 812
	public RandomSfx swingSfx;

	// Token: 0x0400032D RID: 813
	public AudioSource chargeSfx;

	// Token: 0x0400032E RID: 814
	public AudioSource eatSfx;

	// Token: 0x0400032F RID: 815
	public ParticleSystem eatingParticles;

	// Token: 0x04000330 RID: 816
	private ParticleSystem.EmissionModule eatingEmission;

	// Token: 0x04000331 RID: 817
	private ParticleSystem.VelocityOverLifetimeModule velocity;

	// Token: 0x04000332 RID: 818
	private float eatTime;

	// Token: 0x04000333 RID: 819
	private float attackTime;

	// Token: 0x04000334 RID: 820
	private float chargeTime;

	// Token: 0x04000335 RID: 821
	public MeshRenderer meshRenderer;

	// Token: 0x04000336 RID: 822
	public MeshFilter meshFilter;

	// Token: 0x04000337 RID: 823
	public Transform renderTransform;

	// Token: 0x04000338 RID: 824
	private InventoryItem currentItem;
}
