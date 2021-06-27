using System;
using System.Collections.Generic;
using UnityEngine;

public class PlayerStatus : MonoBehaviour
{
    public int draculaStacks { get; set; }

    private float _stamina;

    public float stamina
    {
        get => GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative ? maxStamina : _stamina;
        set => _stamina = value;
    }

    public float maxStamina { get; set; }

    private float _hunger;

    public float hunger
    {
        get => GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative ? maxHunger : _hunger;
        set => _hunger = value;
    }

    public float maxHunger { get; set; }

    public int strength { get; set; } = 1;

    public int speed { get; set; } = 1;

    private void Awake()
    {
        PlayerStatus.Instance = this;
        this.player = base.GetComponent<PlayerMovement>();
        this.maxShield = (int)this.shield;
        this.maxHp = (int)this.hp;
        this._stamina = 100f;
        this._hunger = 100f;
        this.maxStamina = this._stamina;
        this.maxHunger = this._hunger;
        this.strength = 1;
        this.speed = 1;
        this.armor = new InventoryItem[4];
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) invincible = true;
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
    }

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
        if (GameManager.gameSettings.gameMode != GameSettings.GameMode.Creative) base.Invoke(nameof(StopInvincible), 3f);
    }

    private void StopInvincible()
    {
        this.invincible = false;
    }

    public void UpdateStats()
    {
        this.maxHp = 100 + PowerupInventory.Instance.GetHpMultiplier(null) + this.draculaStacks;
        this.maxShield = PowerupInventory.Instance.GetShield(null);
    }

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

    public void DealDamage(int damage, bool ignoreProtection = false)
    {
        if (invincible) return;
        if (this.hp + this.shield <= 0f)
        {
            return;
        }
        this.HandleDamage(damage, ignoreProtection);
    }

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

    private void ActivateProtection()
    {
        this.protectionActive = true;
    }

    private void StopAdrenaline()
    {
        this.adrenalineBoost = false;
        base.Invoke(nameof(ReadyAdrenaline), 10f);
    }

    private void ReadyAdrenaline()
    {
        this.readyToAdrenalineBoost = true;
    }

    public bool adrenalineBoost { get; private set; }

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

    public bool IsPlayerDead()
    {
        return this.dead;
    }

    public void DropAllItems(List<InventoryCell> cells)
    {
    }

    public bool IsFullyHealed()
    {
        return this.hp >= (float)this.maxHp && this.shield >= (float)this.maxShield;
    }

    public int HpAndShield()
    {
        return (int)(this.hp + this.shield);
    }

    public int MaxHpAndShield()
    {
        return this.maxHp + this.maxShield;
    }

    public float GetArmorRatio()
    {
        return this.armorTotal / 100f;
    }

    private void Update()
    {
        this.Stamina();
        this.Shield();
        this.Healing();
        this.Hunger();
        this.OutOfMap();
    }

	public void EnterOcean()
	{
		this.windParticles.SetActive(true);
		var emission = this.leafParticles.GetComponent<ParticleSystem>().emission;
		emission.enabled = false;
	}

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

    private void Healing()
    {
        if (this.hp <= 0f || this.hp >= (float)this.maxHp || this.hunger <= 0f)
        {
            return;
        }
        float num = this.healingRate * Time.deltaTime * PowerupInventory.Instance.GetHealingMultiplier(null);
        this.hp += num;
    }

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

    public void Heal(int healAmount)
    {
        this.hp += (float)healAmount;
        if (this.hp > (float)this.maxHp)
        {
            this.hp = (float)this.maxHp;
        }
    }

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

    private void RegenShield()
    {
        this.readyToRegenShield = true;
    }

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

    public float GetStaminaRatio()
    {
        return this.stamina / this.maxStamina;
    }

    public float GetHungerRatio()
    {
        return this.hunger / this.maxHunger;
    }

    public void Jump()
    {
        this.stamina -= this.jumpDrain / PowerupInventory.Instance.GetStaminaMultiplier(null);
    }

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

    public bool CanRun()
    {
        return this.stamina > 0f;
    }

    public bool CanJump()
    {
        return this.stamina >= this.jumpDrain;
    }

    public float hp = 100f;

    public int maxHp;

    public float shield;

    public int maxShield;

    private bool dead;

    private float staminaRegenRate = 15f;

    private float staminaDrainRate = 12f;

    private float staminaBoost = 1f;

    private bool running;

    private float jumpDrain = 10f;

    private float hungerDrainRate = 0.15f;

    private float healingDrainMultiplier = 2f;

    private float staminaDrainMultiplier = 5f;

    private bool healing;

    private float healingRate = 5f;

    private bool readyToRegenShield = true;

    private float shieldRegenRate = 20f;

    private float regenShieldDelay = 5f;

    private PlayerMovement player;

    public static PlayerStatus Instance;

    private bool invincible;

    private float oneShotThreshold = 0.9f;

    private float oneShotProtectionCooldown = 20f;

    private bool protectionActive = true;

    private bool readyToAdrenalineBoost = true;

    public GameObject playerRagdoll;

	public GameObject drownParticles;

	public AudioSource underwaterAudio;

	public GameObject leafParticles;

	public GameObject windParticles;

	private bool underwater;

    public InventoryItem[] armor;

    private float armorTotal;

    public float currentSpeedArmorMultiplier = 1f;

    public float currentChunkArmorMultiplier = 1f;
}
