using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200006C RID: 108
public class PlayerStatus : MonoBehaviour
{
	// Token: 0x17000013 RID: 19
	// (get) Token: 0x0600022C RID: 556 RVA: 0x00003AC7 File Offset: 0x00001CC7
	// (set) Token: 0x0600022D RID: 557 RVA: 0x00003ACF File Offset: 0x00001CCF
	public int draculaStacks { get; set; }

	// Token: 0x17000014 RID: 20
	// (get) Token: 0x0600022E RID: 558 RVA: 0x00003AD8 File Offset: 0x00001CD8
	// (set) Token: 0x0600022F RID: 559 RVA: 0x00003AE0 File Offset: 0x00001CE0
	public float stamina { get; set; }

	// Token: 0x17000015 RID: 21
	// (get) Token: 0x06000230 RID: 560 RVA: 0x00003AE9 File Offset: 0x00001CE9
	// (set) Token: 0x06000231 RID: 561 RVA: 0x00003AF1 File Offset: 0x00001CF1
	public float maxStamina { get; set; }

	// Token: 0x17000016 RID: 22
	// (get) Token: 0x06000232 RID: 562 RVA: 0x00003AFA File Offset: 0x00001CFA
	// (set) Token: 0x06000233 RID: 563 RVA: 0x00003B02 File Offset: 0x00001D02
	public float hunger { get; set; }

	// Token: 0x17000017 RID: 23
	// (get) Token: 0x06000234 RID: 564 RVA: 0x00003B0B File Offset: 0x00001D0B
	// (set) Token: 0x06000235 RID: 565 RVA: 0x00003B13 File Offset: 0x00001D13
	public float maxHunger { get; set; }

	// Token: 0x17000018 RID: 24
	// (get) Token: 0x06000236 RID: 566 RVA: 0x00003B1C File Offset: 0x00001D1C
	// (set) Token: 0x06000237 RID: 567 RVA: 0x00003B24 File Offset: 0x00001D24
	public int strength { get; set; } = 1;

	// Token: 0x17000019 RID: 25
	// (get) Token: 0x06000238 RID: 568 RVA: 0x00003B2D File Offset: 0x00001D2D
	// (set) Token: 0x06000239 RID: 569 RVA: 0x00003B35 File Offset: 0x00001D35
	public int speed { get; set; } = 1;

	// Token: 0x0600023A RID: 570 RVA: 0x0000FCB0 File Offset: 0x0000DEB0
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
	}

	// Token: 0x0600023B RID: 571 RVA: 0x0000FD34 File Offset: 0x0000DF34
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
		base.CancelInvoke(nameof(StopInvincible));
		base.Invoke(nameof(StopInvincible), 3f);
	}

	// Token: 0x0600023C RID: 572 RVA: 0x00003B3E File Offset: 0x00001D3E
	private void StopInvincible()
	{
		this.invincible = false;
	}

	// Token: 0x0600023D RID: 573 RVA: 0x00003B47 File Offset: 0x00001D47
	public void UpdateStats()
	{
		this.maxHp = 100 + PowerupInventory.Instance.GetHpMultiplier(null) + this.draculaStacks;
		this.maxShield = PowerupInventory.Instance.GetShield(null);
	}

	// Token: 0x0600023E RID: 574 RVA: 0x0000FDD0 File Offset: 0x0000DFD0
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

	// Token: 0x0600023F RID: 575 RVA: 0x0000FE14 File Offset: 0x0000E014
	public void DealDamage(int damage, bool ignoreProtection = false)
	{
		if (this.hp + this.shield <= 0f)
		{
			return;
		}
		this.HandleDamage(damage, ignoreProtection);
	}

	// Token: 0x06000240 RID: 576 RVA: 0x0000FE40 File Offset: 0x0000E040
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
			base.Invoke(nameof(StopAdrenaline), 5f);
		}
		this.readyToRegenShield = false;
		base.CancelInvoke(nameof(RegenShield));
		if (!this.dead)
		{
			base.Invoke(nameof(RegenShield), this.regenShieldDelay);
		}
		float shakeRatio = (float)damageTaken / (float)this.MaxHpAndShield();
		CameraShaker.Instance.DamageShake(shakeRatio);
		DamageVignette.Instance.VignetteHit();
	}

	// Token: 0x06000241 RID: 577 RVA: 0x0000FF48 File Offset: 0x0000E148
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
		base.Invoke(nameof(ActivateProtection), this.oneShotProtectionCooldown);
		return damageDone;
	}

	// Token: 0x06000242 RID: 578 RVA: 0x00003B75 File Offset: 0x00001D75
	private void ActivateProtection()
	{
		this.protectionActive = true;
	}

	// Token: 0x06000243 RID: 579 RVA: 0x00003B7E File Offset: 0x00001D7E
	private void StopAdrenaline()
	{
		this.adrenalineBoost = false;
		base.Invoke(nameof(ReadyAdrenaline), 10f);
	}

	// Token: 0x06000244 RID: 580 RVA: 0x00003B97 File Offset: 0x00001D97
	private void ReadyAdrenaline()
	{
		this.readyToAdrenalineBoost = true;
	}

	// Token: 0x1700001A RID: 26
	// (get) Token: 0x06000245 RID: 581 RVA: 0x00003BA0 File Offset: 0x00001DA0
	// (set) Token: 0x06000246 RID: 582 RVA: 0x00003BA8 File Offset: 0x00001DA8
	public bool adrenalineBoost { get; private set; }

	// Token: 0x06000247 RID: 583 RVA: 0x0000FFAC File Offset: 0x0000E1AC
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
		PlayerRagdoll component =Instantiate<GameObject>(this.playerRagdoll, PlayerMovement.Instance.transform.position, PlayerMovement.Instance.orientation.rotation).GetComponent<PlayerRagdoll>();
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

	// Token: 0x06000248 RID: 584 RVA: 0x00003BB1 File Offset: 0x00001DB1
	public bool IsPlayerDead()
	{
		return this.dead;
	}

	// Token: 0x06000249 RID: 585 RVA: 0x00002147 File Offset: 0x00000347
	public void DropAllItems(List<InventoryCell> cells)
	{
	}

	// Token: 0x0600024A RID: 586 RVA: 0x00003BB9 File Offset: 0x00001DB9
	public bool IsFullyHealed()
	{
		return this.hp >= (float)this.maxHp && this.shield >= (float)this.maxShield;
	}

	// Token: 0x0600024B RID: 587 RVA: 0x00003BDE File Offset: 0x00001DDE
	public int HpAndShield()
	{
		return (int)(this.hp + this.shield);
	}

	// Token: 0x0600024C RID: 588 RVA: 0x00003BEE File Offset: 0x00001DEE
	public int MaxHpAndShield()
	{
		return this.maxHp + this.maxShield;
	}

	// Token: 0x0600024D RID: 589 RVA: 0x00003BFD File Offset: 0x00001DFD
	public float GetArmorRatio()
	{
		return this.armorTotal / 100f;
	}

	// Token: 0x0600024E RID: 590 RVA: 0x00003C0B File Offset: 0x00001E0B
	private void Update()
	{
		this.Stamina();
		this.Shield();
		this.Healing();
		this.Hunger();
		this.OutOfMap();
	}

	// Token: 0x0600024F RID: 591 RVA: 0x00010120 File Offset: 0x0000E320
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

	// Token: 0x06000250 RID: 592 RVA: 0x000101D4 File Offset: 0x0000E3D4
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

	// Token: 0x06000251 RID: 593 RVA: 0x00010244 File Offset: 0x0000E444
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

	// Token: 0x06000252 RID: 594 RVA: 0x000102D4 File Offset: 0x0000E4D4
	private void Healing()
	{
		if (this.hp <= 0f || this.hp >= (float)this.maxHp || this.hunger <= 0f)
		{
			return;
		}
		float num = this.healingRate * Time.deltaTime * PowerupInventory.Instance.GetHealingMultiplier(null);
		this.hp += num;
	}

	// Token: 0x06000253 RID: 595 RVA: 0x00010334 File Offset: 0x0000E534
	private void Stamina()
	{
		this.running = (this.player.GetVelocity().magnitude > 5f && this.player.sprinting);
		if (!this.running)
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

	// Token: 0x06000254 RID: 596 RVA: 0x00003C2B File Offset: 0x00001E2B
	public void Heal(int healAmount)
	{
		this.hp += (float)healAmount;
		if (this.hp > (float)this.maxHp)
		{
			this.hp = (float)this.maxHp;
		}
	}

	// Token: 0x06000255 RID: 597 RVA: 0x00010408 File Offset: 0x0000E608
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

	// Token: 0x06000256 RID: 598 RVA: 0x00003C58 File Offset: 0x00001E58
	private void RegenShield()
	{
		this.readyToRegenShield = true;
	}

	// Token: 0x06000257 RID: 599 RVA: 0x000104A0 File Offset: 0x0000E6A0
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

	// Token: 0x06000258 RID: 600 RVA: 0x000104E8 File Offset: 0x0000E6E8
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

	// Token: 0x06000259 RID: 601 RVA: 0x00003C61 File Offset: 0x00001E61
	public float GetStaminaRatio()
	{
		return this.stamina / this.maxStamina;
	}

	// Token: 0x0600025A RID: 602 RVA: 0x00003C71 File Offset: 0x00001E71
	public float GetHungerRatio()
	{
		return this.hunger / this.maxHunger;
	}

	// Token: 0x0600025B RID: 603 RVA: 0x00003C81 File Offset: 0x00001E81
	public void Jump()
	{
		this.stamina -= this.jumpDrain / PowerupInventory.Instance.GetStaminaMultiplier(null);
	}

	// Token: 0x0600025C RID: 604 RVA: 0x00010530 File Offset: 0x0000E730
	public void Dracula()
	{
		int hpIncreasePerKill = PowerupInventory.Instance.GetHpIncreasePerKill(null);
		this.draculaStacks += hpIncreasePerKill;
		int num = PowerupInventory.Instance.GetAmount("Dracula") * PowerupInventory.Instance.GetMaxDraculaStacks();
		if (this.draculaStacks >= num)
		{
			this.draculaStacks = num;
		}
		this.UpdateStats();
		this.hp += (float)hpIncreasePerKill;
	}

	// Token: 0x0600025D RID: 605 RVA: 0x00010598 File Offset: 0x0000E798
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

	// Token: 0x0600025E RID: 606 RVA: 0x00010620 File Offset: 0x0000E820
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

	// Token: 0x0600025F RID: 607 RVA: 0x00003CA2 File Offset: 0x00001EA2
	public bool CanRun()
	{
		return this.stamina > 0f;
	}

	// Token: 0x06000260 RID: 608 RVA: 0x00003CB1 File Offset: 0x00001EB1
	public bool CanJump()
	{
		return this.stamina >= this.jumpDrain;
	}

	// Token: 0x0400024A RID: 586
	public float hp = 100f;

	// Token: 0x0400024B RID: 587
	public int maxHp;

	// Token: 0x0400024D RID: 589
	public float shield;

	// Token: 0x0400024E RID: 590
	public int maxShield;

	// Token: 0x04000253 RID: 595
	private bool dead;

	// Token: 0x04000256 RID: 598
	private float staminaRegenRate = 15f;

	// Token: 0x04000257 RID: 599
	private float staminaDrainRate = 12f;

	// Token: 0x04000258 RID: 600
	private float staminaBoost = 1f;

	// Token: 0x04000259 RID: 601
	private bool running;

	// Token: 0x0400025A RID: 602
	private float jumpDrain = 10f;

	// Token: 0x0400025B RID: 603
	private float hungerDrainRate = 0.15f;

	// Token: 0x0400025C RID: 604
	private float healingDrainMultiplier = 2f;

	// Token: 0x0400025D RID: 605
	private float staminaDrainMultiplier = 5f;

	// Token: 0x0400025E RID: 606
	private bool healing;

	// Token: 0x0400025F RID: 607
	private float healingRate = 5f;

	// Token: 0x04000260 RID: 608
	private bool readyToRegenShield = true;

	// Token: 0x04000261 RID: 609
	private float shieldRegenRate = 20f;

	// Token: 0x04000262 RID: 610
	private float regenShieldDelay = 5f;

	// Token: 0x04000263 RID: 611
	private PlayerMovement player;

	// Token: 0x04000264 RID: 612
	public static PlayerStatus Instance;

	// Token: 0x04000265 RID: 613
	private bool invincible;

	// Token: 0x04000266 RID: 614
	private float oneShotThreshold = 0.9f;

	// Token: 0x04000267 RID: 615
	private float oneShotProtectionCooldown = 20f;

	// Token: 0x04000268 RID: 616
	private bool protectionActive = true;

	// Token: 0x04000269 RID: 617
	private bool readyToAdrenalineBoost = true;

	// Token: 0x0400026B RID: 619
	public GameObject playerRagdoll;

	// Token: 0x0400026C RID: 620
	public InventoryItem[] armor;

	// Token: 0x0400026D RID: 621
	private float armorTotal;

	// Token: 0x0400026E RID: 622
	public float currentSpeedArmorMultiplier = 1f;

	// Token: 0x0400026F RID: 623
	public float currentChunkArmorMultiplier = 1f;
}
