using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007B RID: 123
public class PlayerStatus : MonoBehaviour
{
	// Token: 0x17000019 RID: 25
	// (get) Token: 0x060002B7 RID: 695 RVA: 0x0000F201 File Offset: 0x0000D401
	// (set) Token: 0x060002B8 RID: 696 RVA: 0x0000F209 File Offset: 0x0000D409
	public int draculaStacks { get; set; }

	// Token: 0x1700001A RID: 26
	// (get) Token: 0x060002B9 RID: 697 RVA: 0x0000F212 File Offset: 0x0000D412
	// (set) Token: 0x060002BA RID: 698 RVA: 0x0000F21A File Offset: 0x0000D41A
	public float stamina { get; set; }

	// Token: 0x1700001B RID: 27
	// (get) Token: 0x060002BB RID: 699 RVA: 0x0000F223 File Offset: 0x0000D423
	// (set) Token: 0x060002BC RID: 700 RVA: 0x0000F22B File Offset: 0x0000D42B
	public float maxStamina { get; set; }

	// Token: 0x1700001C RID: 28
	// (get) Token: 0x060002BD RID: 701 RVA: 0x0000F234 File Offset: 0x0000D434
	// (set) Token: 0x060002BE RID: 702 RVA: 0x0000F23C File Offset: 0x0000D43C
	public float hunger { get; set; }

	// Token: 0x1700001D RID: 29
	// (get) Token: 0x060002BF RID: 703 RVA: 0x0000F245 File Offset: 0x0000D445
	// (set) Token: 0x060002C0 RID: 704 RVA: 0x0000F24D File Offset: 0x0000D44D
	public float maxHunger { get; set; }

	// Token: 0x1700001E RID: 30
	// (get) Token: 0x060002C1 RID: 705 RVA: 0x0000F256 File Offset: 0x0000D456
	// (set) Token: 0x060002C2 RID: 706 RVA: 0x0000F25E File Offset: 0x0000D45E
	public int strength { get; set; } = 1;

	// Token: 0x1700001F RID: 31
	// (get) Token: 0x060002C3 RID: 707 RVA: 0x0000F267 File Offset: 0x0000D467
	// (set) Token: 0x060002C4 RID: 708 RVA: 0x0000F26F File Offset: 0x0000D46F
	public int speed { get; set; } = 1;

	// Token: 0x060002C5 RID: 709 RVA: 0x0000F278 File Offset: 0x0000D478
	private void Awake()
	{
		PlayerStatus.Instance = this;
		this.player = base.GetComponent<PlayerMovement>();
		this.maxShield = (int)this.shield;
		this.maxHp = (int)this.hp;
		this.stamina = 100f;
		this.hunger = 100f;
		this.maxStamina = this.stamina;
		this.maxHunger = this.hunger;
		this.strength = 1;
		this.speed = 1;
		this.armor = new InventoryItem[4];
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	// Token: 0x060002C6 RID: 710 RVA: 0x0000F310 File Offset: 0x0000D510
	public void Respawn()
	{
		this.hp = (float)this.maxHp;
		this.shield = (float)this.maxShield;
		this.stamina = this.maxStamina;
		this.hunger = this.maxHunger;
		this.dead = false;
		GameManager.players[LocalClient.instance.myId].dead = false;
		MoveCamera.Instance.PlayerRespawn(PlayerMovement.Instance.transform.position);
		this.invincible = true;
		base.CancelInvoke("StopInvincible");
		Invoke(nameof(StopInvincible), 3f);
	}

	// Token: 0x060002C7 RID: 711 RVA: 0x0000F3AB File Offset: 0x0000D5AB
	private void StopInvincible()
	{
		this.invincible = false;
	}

	// Token: 0x060002C8 RID: 712 RVA: 0x0000F3B4 File Offset: 0x0000D5B4
	public void UpdateStats()
	{
		this.maxHp = 100 + PowerupInventory.Instance.GetHpMultiplier(null) + this.draculaStacks;
		this.maxShield = PowerupInventory.Instance.GetShield(null);
	}

	// Token: 0x060002C9 RID: 713 RVA: 0x0000F3E4 File Offset: 0x0000D5E4
	public void Damage(int newHp, bool ignoreProtection = false)
	{
		if (this.invincible)
		{
			return;
		}
		if (this.hp + this.shield <= 0f)
		{
			return;
		}
		int damageTaken = (int)(this.hp + this.shield) - newHp;
		this.HandleDamage(damageTaken, ignoreProtection);
	}

	// Token: 0x060002CA RID: 714 RVA: 0x0000F428 File Offset: 0x0000D628
	public void DealDamage(int damage, bool ignoreProtection = false)
	{
		if (this.hp + this.shield <= 0f)
		{
			return;
		}
		this.HandleDamage(damage, ignoreProtection);
	}

	// Token: 0x060002CB RID: 715 RVA: 0x0000F454 File Offset: 0x0000D654
	private void HandleDamage(int damageTaken, bool ignoreProtection = false)
	{
		if (!ignoreProtection)
		{
			damageTaken = this.OneShotProtection(damageTaken);
		}
		if (this.shield >= (float)damageTaken)
		{
			this.shield -= (float)damageTaken;
		}
		else
		{
			damageTaken -= (int)this.shield;
			this.shield = 0f;
			this.hp -= (float)damageTaken;
		}
		if (this.hp <= 0f)
		{
			this.hp = 0f;
			this.PlayerDied();
		}
		if (this.hp / (float)this.maxHp < 0.3f && !this.adrenalineBoost && this.readyToAdrenalineBoost)
		{
			this.adrenalineBoost = true;
			this.readyToAdrenalineBoost = false;
			Invoke(nameof(StopAdrenaline), 5f);
		}
		this.readyToRegenShield = false;
		base.CancelInvoke("RegenShield");
		if (!this.dead)
		{
			Invoke(nameof(RegenShield), this.regenShieldDelay);
		}
		float shakeRatio = (float)damageTaken / (float)this.MaxHpAndShield();
		CameraShaker.Instance.DamageShake(shakeRatio);
		DamageVignette.Instance.VignetteHit();
	}

	// Token: 0x060002CC RID: 716 RVA: 0x0000F55C File Offset: 0x0000D75C
	private int OneShotProtection(int damageDone)
	{
		if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			return damageDone;
		}
		if (!this.protectionActive)
		{
			return damageDone;
		}
		if ((float)damageDone / (float)this.MaxHpAndShield() > 0.9f)
		{
			damageDone = (int)((float)this.MaxHpAndShield() * this.oneShotThreshold);
		}
		this.protectionActive = false;
		Invoke(nameof(ActivateProtection), this.oneShotProtectionCooldown);
		return damageDone;
	}

	// Token: 0x060002CD RID: 717 RVA: 0x0000F5BD File Offset: 0x0000D7BD
	private void ActivateProtection()
	{
		this.protectionActive = true;
	}

	// Token: 0x060002CE RID: 718 RVA: 0x0000F5C6 File Offset: 0x0000D7C6
	private void StopAdrenaline()
	{
		this.adrenalineBoost = false;
		Invoke(nameof(ReadyAdrenaline), 10f);
	}

	// Token: 0x060002CF RID: 719 RVA: 0x0000F5DF File Offset: 0x0000D7DF
	private void ReadyAdrenaline()
	{
		this.readyToAdrenalineBoost = true;
	}

	// Token: 0x17000020 RID: 32
	// (get) Token: 0x060002D0 RID: 720 RVA: 0x0000F5E8 File Offset: 0x0000D7E8
	// (set) Token: 0x060002D1 RID: 721 RVA: 0x0000F5F0 File Offset: 0x0000D7F0
	public bool adrenalineBoost { get; private set; }

	// Token: 0x060002D2 RID: 722 RVA: 0x0000F5FC File Offset: 0x0000D7FC
	private void PlayerDied()
	{
		this.hp = 0f;
		this.shield = 0f;
		PlayerMovement.Instance.gameObject.SetActive(false);
		this.dead = true;
		GameManager.players[LocalClient.instance.myId].dead = true;
		foreach (InventoryCell inventoryCell in InventoryUI.Instance.allCells)
		{
			if (!(inventoryCell.currentItem == null))
			{
				InventoryUI.Instance.DropItemIntoWorld(inventoryCell.currentItem);
				inventoryCell.currentItem = null;
				inventoryCell.UpdateCell();
			}
		}
		Hotbar.Instance.UpdateHotbar();
		ClientSend.PlayerDied();
		PlayerRagdoll component = Instantiate<GameObject>(this.playerRagdoll, PlayerMovement.Instance.transform.position, PlayerMovement.Instance.orientation.rotation).GetComponent<PlayerRagdoll>();
		MoveCamera.Instance.PlayerDied(component.transform.GetChild(0).GetChild(0).GetChild(0));
		component.SetRagdoll(LocalClient.instance.myId, -component.transform.forward);
		GameManager.players[LocalClient.instance.myId].dead = true;
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
		}
		for (int j = 0; j < this.armor.Length; j++)
		{
			this.UpdateArmor(j, -1);
		}
	}

	// Token: 0x060002D3 RID: 723 RVA: 0x0000F76E File Offset: 0x0000D96E
	public bool IsPlayerDead()
	{
		return this.dead;
	}

	// Token: 0x060002D4 RID: 724 RVA: 0x000030D7 File Offset: 0x000012D7
	public void DropAllItems(List<InventoryCell> cells)
	{
	}

	// Token: 0x060002D5 RID: 725 RVA: 0x0000F776 File Offset: 0x0000D976
	public bool IsFullyHealed()
	{
		return this.hp >= (float)this.maxHp && this.shield >= (float)this.maxShield;
	}

	// Token: 0x060002D6 RID: 726 RVA: 0x0000F79B File Offset: 0x0000D99B
	public int HpAndShield()
	{
		return (int)(this.hp + this.shield);
	}

	// Token: 0x060002D7 RID: 727 RVA: 0x0000F7AB File Offset: 0x0000D9AB
	public int MaxHpAndShield()
	{
		return this.maxHp + this.maxShield;
	}

	// Token: 0x060002D8 RID: 728 RVA: 0x0000F7BA File Offset: 0x0000D9BA
	public float GetArmorRatio()
	{
		return this.armorTotal / 100f;
	}

	// Token: 0x060002D9 RID: 729 RVA: 0x0000F7C8 File Offset: 0x0000D9C8
	private void Update()
	{
		this.Stamina();
		this.Shield();
		this.Healing();
		this.Hunger();
		this.OutOfMap();
	}

	// Token: 0x060002DA RID: 730 RVA: 0x0000F7E8 File Offset: 0x0000D9E8
	public void EnterOcean()
	{
		this.windParticles.SetActive(true);
		var emission = this.leafParticles.GetComponent<ParticleSystem>().emission;
		emission.enabled = false;
	}

	// Token: 0x060002DB RID: 731 RVA: 0x0000F81C File Offset: 0x0000DA1C
	private void SlowUpdate()
	{
		if (this.player.playerCam.position.y < World.Instance.water.position.y)
		{
			if (!this.underwaterAudio.enabled)
			{
				this.underwaterAudio.enabled = true;
				this.underwaterAudio.Play();
			}
		}
		else if (this.underwaterAudio.enabled)
		{
			this.underwaterAudio.enabled = false;
		}
		if (this.stamina <= 0f && this.underwater && this.hp > 0f)
		{
			this.DealDamage(5, false);
			Instantiate<GameObject>(this.drownParticles, base.transform.position, Quaternion.LookRotation(this.player.playerCam.transform.forward));
		}
	}

	// Token: 0x060002DC RID: 732 RVA: 0x0000F8F0 File Offset: 0x0000DAF0
	private void OutOfMap()
	{
		if (this.dead || !PlayerMovement.Instance)
		{
			return;
		}
		if (PlayerMovement.Instance.transform.position.y < -200f)
		{
			this.Damage(1, false);
			RaycastHit raycastHit;
			if (Physics.Raycast(Vector3.up * 500f, Vector3.down, out raycastHit, 1000f, GameManager.instance.whatIsGround))
			{
				PlayerMovement.Instance.transform.position = raycastHit.point + Vector3.up * 2f;
				PlayerMovement.Instance.GetRb().velocity = Vector3.zero;
			}
		}
	}

	// Token: 0x060002DD RID: 733 RVA: 0x0000F9A4 File Offset: 0x0000DBA4
	private void Shield()
	{
		if (!this.readyToRegenShield || this.shield >= (float)this.maxShield || this.hp + this.shield <= 0f)
		{
			return;
		}
		this.shield += this.shieldRegenRate * Time.deltaTime;
		if (this.shield > (float)this.maxShield)
		{
			this.shield = (float)this.maxShield;
		}
	}

	// Token: 0x060002DE RID: 734 RVA: 0x0000FA14 File Offset: 0x0000DC14
	private void Hunger()
	{
		if (this.hunger <= 0f || this.hp <= 0f)
		{
			return;
		}
		float num = 1f * PowerupInventory.Instance.GetHungerMultiplier(null);
		if (this.healing)
		{
			num *= this.healingDrainMultiplier;
		}
		if (this.running)
		{
			num *= this.staminaDrainMultiplier;
		}
		this.hunger -= this.hungerDrainRate * Time.deltaTime * num;
		if (this.hunger < 0f)
		{
			this.hunger = 0f;
		}
	}

	// Token: 0x060002DF RID: 735 RVA: 0x0000FAA4 File Offset: 0x0000DCA4
	private void Healing()
	{
		if (this.hp <= 0f || this.hp >= (float)this.maxHp || this.hunger <= 0f)
		{
			return;
		}
		float num = this.healingRate * Time.deltaTime * PowerupInventory.Instance.GetHealingMultiplier(null);
		this.hp += num;
	}

	// Token: 0x060002E0 RID: 736 RVA: 0x0000FB04 File Offset: 0x0000DD04
	private void Stamina()
	{
		this.running = (this.player.GetVelocity().magnitude > 5f && this.player.sprinting);
		this.underwater = this.player.IsUnderWater();
		if (!this.running && !this.underwater)
		{
			if (this.stamina < 100f && this.player.grounded && this.hunger > 0f)
			{
				float num = 1f;
				if (this.hunger <= 0f)
				{
					num *= 0.3f;
				}
				this.stamina += this.staminaRegenRate * Time.deltaTime * num;
			}
			return;
		}
		if (this.stamina <= 0f)
		{
			return;
		}
		this.stamina -= this.staminaDrainRate * Time.deltaTime / PowerupInventory.Instance.GetStaminaMultiplier(null);
	}

	// Token: 0x060002E1 RID: 737 RVA: 0x0000FBF1 File Offset: 0x0000DDF1
	public void Heal(int healAmount)
	{
		this.hp += (float)healAmount;
		if (this.hp > (float)this.maxHp)
		{
			this.hp = (float)this.maxHp;
		}
	}

	// Token: 0x060002E2 RID: 738 RVA: 0x0000FC20 File Offset: 0x0000DE20
	public void Eat(InventoryItem item)
	{
		this.hp += item.heal;
		if (this.hp > (float)this.maxHp)
		{
			this.hp = (float)this.maxHp;
		}
		this.stamina += item.stamina;
		if (this.stamina > this.maxStamina)
		{
			this.stamina = this.maxStamina;
		}
		this.hunger += item.hunger;
		if (this.hunger > this.maxHunger)
		{
			this.hunger = this.maxHunger;
		}
	}

	// Token: 0x060002E3 RID: 739 RVA: 0x0000FCB6 File Offset: 0x0000DEB6
	private void RegenShield()
	{
		this.readyToRegenShield = true;
	}

	// Token: 0x060002E4 RID: 740 RVA: 0x0000FCC0 File Offset: 0x0000DEC0
	public float GetHpRatio()
	{
		if (this.maxHp == 0)
		{
			return 0f;
		}
		float num = (float)(this.maxShield + this.maxHp);
		float num2 = (float)this.maxHp / num;
		return this.hp / (float)this.maxHp * num2;
	}

	// Token: 0x060002E5 RID: 741 RVA: 0x0000FD08 File Offset: 0x0000DF08
	public float GetShieldRatio()
	{
		if (this.maxShield == 0)
		{
			return 0f;
		}
		float num = (float)(this.maxShield + this.maxHp);
		float num2 = (float)this.maxShield / num;
		return this.shield / (float)this.maxShield * num2;
	}

	// Token: 0x060002E6 RID: 742 RVA: 0x0000FD4D File Offset: 0x0000DF4D
	public float GetStaminaRatio()
	{
		return this.stamina / this.maxStamina;
	}

	// Token: 0x060002E7 RID: 743 RVA: 0x0000FD5D File Offset: 0x0000DF5D
	public float GetHungerRatio()
	{
		return this.hunger / this.maxHunger;
	}

	// Token: 0x060002E8 RID: 744 RVA: 0x0000FD6D File Offset: 0x0000DF6D
	public void Jump()
	{
		this.stamina -= this.jumpDrain / PowerupInventory.Instance.GetStaminaMultiplier(null);
	}

	// Token: 0x060002E9 RID: 745 RVA: 0x0000FD90 File Offset: 0x0000DF90
	public void Dracula()
	{
		int hpIncreasePerKill = PowerupInventory.Instance.GetHpIncreasePerKill(null);
		this.draculaStacks += hpIncreasePerKill;
		int maxDraculaStacks = PowerupInventory.Instance.GetMaxDraculaStacks();
		if (this.draculaStacks >= maxDraculaStacks)
		{
			this.draculaStacks = maxDraculaStacks;
		}
		this.UpdateStats();
		this.hp += (float)hpIncreasePerKill;
	}

	// Token: 0x060002EA RID: 746 RVA: 0x0000FDE8 File Offset: 0x0000DFE8
	public void UpdateArmor(int armorSlot, int itemId)
	{
		InventoryItem inventoryItem = null;
		if (itemId >= 0)
		{
			inventoryItem = ItemManager.Instance.allItems[itemId];
		}
		this.armor[armorSlot] = inventoryItem;
		this.armorTotal = 0f;
		foreach (InventoryItem inventoryItem2 in this.armor)
		{
			if (!(inventoryItem2 == null))
			{
				this.armorTotal += (float)inventoryItem2.armor;
			}
		}
		ClientSend.SendArmor(armorSlot, itemId);
		this.CheckArmorSetBonus();
		PreviewPlayer.Instance.SetArmor(armorSlot, itemId);
	}

	// Token: 0x060002EB RID: 747 RVA: 0x0000FE70 File Offset: 0x0000E070
	private void CheckArmorSetBonus()
	{
		this.currentSpeedArmorMultiplier = 1f;
		this.currentChunkArmorMultiplier = 1f;
		if (this.armor[0] == null)
		{
			return;
		}
		int id = this.armor[0].requirements[0].item.id;
		foreach (InventoryItem inventoryItem in this.armor)
		{
			if (inventoryItem == null)
			{
				return;
			}
			if (inventoryItem.requirements[0].item.id != id)
			{
				return;
			}
		}
		string name = this.armor[0].requirements[0].item.name;
		if (name == "Wolfskin")
		{
			this.currentSpeedArmorMultiplier = 1.5f;
			return;
		}
		if (!(name == "Chunkium bar"))
		{
			return;
		}
		this.currentChunkArmorMultiplier = 1.6f;
	}

	// Token: 0x060002EC RID: 748 RVA: 0x0000FF46 File Offset: 0x0000E146
	public bool CanRun()
	{
		return this.stamina > 0f;
	}

	// Token: 0x060002ED RID: 749 RVA: 0x0000FF55 File Offset: 0x0000E155
	public bool CanJump()
	{
		return this.stamina >= this.jumpDrain;
	}

	// Token: 0x040002C9 RID: 713
	public float hp = 100f;

	// Token: 0x040002CA RID: 714
	public int maxHp;

	// Token: 0x040002CC RID: 716
	public float shield;

	// Token: 0x040002CD RID: 717
	public int maxShield;

	// Token: 0x040002D2 RID: 722
	private bool dead;

	// Token: 0x040002D5 RID: 725
	private float staminaRegenRate = 15f;

	// Token: 0x040002D6 RID: 726
	private float staminaDrainRate = 12f;

	// Token: 0x040002D7 RID: 727
	private float staminaBoost = 1f;

	// Token: 0x040002D8 RID: 728
	private bool running;

	// Token: 0x040002D9 RID: 729
	private float jumpDrain = 10f;

	// Token: 0x040002DA RID: 730
	private float hungerDrainRate = 0.15f;

	// Token: 0x040002DB RID: 731
	private float healingDrainMultiplier = 2f;

	// Token: 0x040002DC RID: 732
	private float staminaDrainMultiplier = 5f;

	// Token: 0x040002DD RID: 733
	private bool healing;

	// Token: 0x040002DE RID: 734
	private float healingRate = 5f;

	// Token: 0x040002DF RID: 735
	private bool readyToRegenShield = true;

	// Token: 0x040002E0 RID: 736
	private float shieldRegenRate = 20f;

	// Token: 0x040002E1 RID: 737
	private float regenShieldDelay = 5f;

	// Token: 0x040002E2 RID: 738
	private PlayerMovement player;

	// Token: 0x040002E3 RID: 739
	public static PlayerStatus Instance;

	// Token: 0x040002E4 RID: 740
	private bool invincible;

	// Token: 0x040002E5 RID: 741
	private float oneShotThreshold = 0.9f;

	// Token: 0x040002E6 RID: 742
	private float oneShotProtectionCooldown = 20f;

	// Token: 0x040002E7 RID: 743
	private bool protectionActive = true;

	// Token: 0x040002E8 RID: 744
	private bool readyToAdrenalineBoost = true;

	// Token: 0x040002EA RID: 746
	public GameObject playerRagdoll;

	// Token: 0x040002EB RID: 747
	public GameObject drownParticles;

	// Token: 0x040002EC RID: 748
	public AudioSource underwaterAudio;

	// Token: 0x040002ED RID: 749
	public GameObject leafParticles;

	// Token: 0x040002EE RID: 750
	public GameObject windParticles;

	// Token: 0x040002EF RID: 751
	private bool underwater;

	// Token: 0x040002F0 RID: 752
	public InventoryItem[] armor;

	// Token: 0x040002F1 RID: 753
	private float armorTotal;

	// Token: 0x040002F2 RID: 754
	public float currentSpeedArmorMultiplier = 1f;

	// Token: 0x040002F3 RID: 755
	public float currentChunkArmorMultiplier = 1f;
}
