
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200005B RID: 91
public class PlayerStatus : MonoBehaviour
{
	// Token: 0x1700000F RID: 15
	// (get) Token: 0x060001FF RID: 511 RVA: 0x0000B781 File Offset: 0x00009981
	// (set) Token: 0x06000200 RID: 512 RVA: 0x0000B789 File Offset: 0x00009989
	public int draculaStacks { get; set; }

	// Token: 0x17000010 RID: 16
	// (get) Token: 0x06000201 RID: 513 RVA: 0x0000B792 File Offset: 0x00009992
	// (set) Token: 0x06000202 RID: 514 RVA: 0x0000B79A File Offset: 0x0000999A
	public float stamina { get; set; }

	// Token: 0x17000011 RID: 17
	// (get) Token: 0x06000203 RID: 515 RVA: 0x0000B7A3 File Offset: 0x000099A3
	// (set) Token: 0x06000204 RID: 516 RVA: 0x0000B7AB File Offset: 0x000099AB
	public float maxStamina { get; set; }

	// Token: 0x17000012 RID: 18
	// (get) Token: 0x06000205 RID: 517 RVA: 0x0000B7B4 File Offset: 0x000099B4
	// (set) Token: 0x06000206 RID: 518 RVA: 0x0000B7BC File Offset: 0x000099BC
	public float hunger { get; set; }

	// Token: 0x17000013 RID: 19
	// (get) Token: 0x06000207 RID: 519 RVA: 0x0000B7C5 File Offset: 0x000099C5
	// (set) Token: 0x06000208 RID: 520 RVA: 0x0000B7CD File Offset: 0x000099CD
	public float maxHunger { get; set; }

	// Token: 0x17000014 RID: 20
	// (get) Token: 0x06000209 RID: 521 RVA: 0x0000B7D6 File Offset: 0x000099D6
	// (set) Token: 0x0600020A RID: 522 RVA: 0x0000B7DE File Offset: 0x000099DE
	public int strength { get; set; } = 1;

	// Token: 0x17000015 RID: 21
	// (get) Token: 0x0600020B RID: 523 RVA: 0x0000B7E7 File Offset: 0x000099E7
	// (set) Token: 0x0600020C RID: 524 RVA: 0x0000B7EF File Offset: 0x000099EF
	public int speed { get; set; } = 1;

	// Token: 0x0600020D RID: 525 RVA: 0x0000B7F8 File Offset: 0x000099F8
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

	// Token: 0x0600020E RID: 526 RVA: 0x0000B87C File Offset: 0x00009A7C
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
		base.Invoke("StopInvincible", 3f);
	}

	// Token: 0x0600020F RID: 527 RVA: 0x0000B917 File Offset: 0x00009B17
	private void StopInvincible()
	{
		this.invincible = false;
	}

	// Token: 0x06000210 RID: 528 RVA: 0x0000B920 File Offset: 0x00009B20
	public void UpdateStats()
	{
		this.maxHp = 100 + PowerupInventory.Instance.GetHpMultiplier(null) + this.draculaStacks;
		this.maxShield = PowerupInventory.Instance.GetShield(null);
	}

	// Token: 0x06000211 RID: 529 RVA: 0x0000B950 File Offset: 0x00009B50
	public void Damage(int newHp)
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
		this.HandleDamage(damageTaken);
	}

	// Token: 0x06000212 RID: 530 RVA: 0x0000B994 File Offset: 0x00009B94
	public void DealDamage(int damage)
	{
		if (this.hp + this.shield <= 0f)
		{
			return;
		}
		this.HandleDamage(damage);
	}

	// Token: 0x06000213 RID: 531 RVA: 0x0000B9C0 File Offset: 0x00009BC0
	private void HandleDamage(int damageTaken)
	{
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
			base.Invoke("StopAdrenaline", 5f);
		}
		this.readyToRegenShield = false;
		base.CancelInvoke("RegenShield");
		if (!this.dead)
		{
			base.Invoke("RegenShield", this.regenShieldDelay);
		}
		float shakeRatio = (float)damageTaken / (float)this.MaxHpAndShield();
		CameraShaker.Instance.DamageShake(shakeRatio);
		DamageVignette.Instance.VignetteHit();
	}

	// Token: 0x06000214 RID: 532 RVA: 0x0000BAB9 File Offset: 0x00009CB9
	private void StopAdrenaline()
	{
		this.adrenalineBoost = false;
		base.Invoke("ReadyAdrenaline", 10f);
	}

	// Token: 0x06000215 RID: 533 RVA: 0x0000BAD2 File Offset: 0x00009CD2
	private void ReadyAdrenaline()
	{
		this.readyToAdrenalineBoost = true;
	}

	// Token: 0x17000016 RID: 22
	// (get) Token: 0x06000216 RID: 534 RVA: 0x0000BADB File Offset: 0x00009CDB
	// (set) Token: 0x06000217 RID: 535 RVA: 0x0000BAE3 File Offset: 0x00009CE3
	public bool adrenalineBoost { get; private set; }

	// Token: 0x06000218 RID: 536 RVA: 0x0000BAEC File Offset: 0x00009CEC
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
		PlayerRagdoll component =Instantiate(this.playerRagdoll, PlayerMovement.Instance.transform.position, PlayerMovement.Instance.orientation.rotation).GetComponent<PlayerRagdoll>();
		MoveCamera.Instance.PlayerDied(component.transform.GetChild(0).GetChild(0).GetChild(0));
		component.SetRagdoll(LocalClient.instance.myId, -component.transform.forward);
		GameManager.players[LocalClient.instance.myId].dead = true;
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
		}
	}

	// Token: 0x06000219 RID: 537 RVA: 0x0000BC3E File Offset: 0x00009E3E
	public bool IsPlayerDead()
	{
		return this.dead;
	}

	// Token: 0x0600021A RID: 538 RVA: 0x0000276E File Offset: 0x0000096E
	public void DropAllItems(List<InventoryCell> cells)
	{
	}

	// Token: 0x0600021B RID: 539 RVA: 0x0000BC46 File Offset: 0x00009E46
	public bool IsFullyHealed()
	{
		return this.hp >= (float)this.maxHp && this.shield >= (float)this.maxShield;
	}

	// Token: 0x0600021C RID: 540 RVA: 0x0000BC6B File Offset: 0x00009E6B
	public int HpAndShield()
	{
		return (int)(this.hp + this.shield);
	}

	// Token: 0x0600021D RID: 541 RVA: 0x0000BC7B File Offset: 0x00009E7B
	public int MaxHpAndShield()
	{
		return this.maxHp + this.maxShield;
	}

	// Token: 0x0600021E RID: 542 RVA: 0x0000BC8A File Offset: 0x00009E8A
	public float GetArmorRatio()
	{
		return this.armorTotal / 100f;
	}

	// Token: 0x0600021F RID: 543 RVA: 0x0000BC98 File Offset: 0x00009E98
	private void Update()
	{
		this.Stamina();
		this.Shield();
		this.Healing();
		this.Hunger();
		this.OutOfMap();
	}

	// Token: 0x06000220 RID: 544 RVA: 0x0000BCB8 File Offset: 0x00009EB8
	private void OutOfMap()
	{
		if (this.dead || !PlayerMovement.Instance)
		{
			return;
		}
		if (PlayerMovement.Instance.transform.position.y < -200f)
		{
			this.Damage(0);
			this.PlayerDied();
		}
	}

	// Token: 0x06000221 RID: 545 RVA: 0x0000BCF8 File Offset: 0x00009EF8
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

	// Token: 0x06000222 RID: 546 RVA: 0x0000BD68 File Offset: 0x00009F68
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

	// Token: 0x06000223 RID: 547 RVA: 0x0000BDF8 File Offset: 0x00009FF8
	private void Healing()
	{
		if (this.hp <= 0f || this.hp >= (float)this.maxHp || this.hunger <= 0f)
		{
			return;
		}
		float num = this.healingRate * Time.deltaTime * PowerupInventory.Instance.GetHealingMultiplier(null);
		this.hp += num;
	}

	// Token: 0x06000224 RID: 548 RVA: 0x0000BE58 File Offset: 0x0000A058
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

	// Token: 0x06000225 RID: 549 RVA: 0x0000BF2C File Offset: 0x0000A12C
	public void Heal(int healAmount)
	{
		this.hp += (float)healAmount;
		if (this.hp > (float)this.maxHp)
		{
			this.hp = (float)this.maxHp;
		}
	}

	// Token: 0x06000226 RID: 550 RVA: 0x0000BF5C File Offset: 0x0000A15C
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

	// Token: 0x06000227 RID: 551 RVA: 0x0000BFF2 File Offset: 0x0000A1F2
	private void RegenShield()
	{
		this.readyToRegenShield = true;
	}

	// Token: 0x06000228 RID: 552 RVA: 0x0000BFFC File Offset: 0x0000A1FC
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

	// Token: 0x06000229 RID: 553 RVA: 0x0000C044 File Offset: 0x0000A244
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

	// Token: 0x0600022A RID: 554 RVA: 0x0000C089 File Offset: 0x0000A289
	public float GetStaminaRatio()
	{
		return this.stamina / this.maxStamina;
	}

	// Token: 0x0600022B RID: 555 RVA: 0x0000C099 File Offset: 0x0000A299
	public float GetHungerRatio()
	{
		return this.hunger / this.maxHunger;
	}

	// Token: 0x0600022C RID: 556 RVA: 0x0000C0A9 File Offset: 0x0000A2A9
	public void Jump()
	{
		this.stamina -= this.jumpDrain / PowerupInventory.Instance.GetStaminaMultiplier(null);
	}

	// Token: 0x0600022D RID: 557 RVA: 0x0000C0CC File Offset: 0x0000A2CC
	public void Dracula()
	{
		int hpIncreasePerKill = PowerupInventory.Instance.GetHpIncreasePerKill(null);
		this.draculaStacks += hpIncreasePerKill;
		this.UpdateStats();
		this.hp += (float)hpIncreasePerKill;
	}

	// Token: 0x0600022E RID: 558 RVA: 0x0000C108 File Offset: 0x0000A308
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
		PreviewPlayer.Instance.SetArmor(armorSlot, itemId);
		ClientSend.SendArmor(armorSlot, itemId);
	}

	// Token: 0x0600022F RID: 559 RVA: 0x0000C189 File Offset: 0x0000A389
	public bool CanRun()
	{
		return this.stamina > 0f;
	}

	// Token: 0x06000230 RID: 560 RVA: 0x0000C198 File Offset: 0x0000A398
	public bool CanJump()
	{
		return this.stamina >= this.jumpDrain;
	}

	// Token: 0x040001FE RID: 510
	public float hp = 100f;

	// Token: 0x040001FF RID: 511
	public int maxHp;

	// Token: 0x04000201 RID: 513
	public float shield;

	// Token: 0x04000202 RID: 514
	public int maxShield;

	// Token: 0x04000207 RID: 519
	private bool dead;

	// Token: 0x0400020A RID: 522
	private float staminaRegenRate = 15f;

	// Token: 0x0400020B RID: 523
	private float staminaDrainRate = 12f;

	// Token: 0x0400020C RID: 524
	private float staminaBoost = 1f;

	// Token: 0x0400020D RID: 525
	private bool running;

	// Token: 0x0400020E RID: 526
	private float jumpDrain = 10f;

	// Token: 0x0400020F RID: 527
	private float hungerDrainRate = 0.15f;

	// Token: 0x04000210 RID: 528
	private float healingDrainMultiplier = 2f;

	// Token: 0x04000211 RID: 529
	private float staminaDrainMultiplier = 5f;

	// Token: 0x04000212 RID: 530
	private bool healing;

	// Token: 0x04000213 RID: 531
	private float healingRate = 5f;

	// Token: 0x04000214 RID: 532
	private bool readyToRegenShield = true;

	// Token: 0x04000215 RID: 533
	private float shieldRegenRate = 20f;

	// Token: 0x04000216 RID: 534
	private float regenShieldDelay = 5f;

	// Token: 0x04000217 RID: 535
	private PlayerMovement player;

	// Token: 0x04000218 RID: 536
	public static PlayerStatus Instance;

	// Token: 0x04000219 RID: 537
	private bool invincible;

	// Token: 0x0400021A RID: 538
	private bool readyToAdrenalineBoost = true;

	// Token: 0x0400021C RID: 540
	public GameObject playerRagdoll;

	// Token: 0x0400021D RID: 541
	public InventoryItem[] armor;

	// Token: 0x0400021E RID: 542
	private float armorTotal;
}
