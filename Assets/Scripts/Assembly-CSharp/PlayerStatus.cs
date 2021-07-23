using System.Collections.Generic;
using UnityEngine;

public class PlayerStatus : MonoBehaviour
{
    public enum DamageType
    {
        Mob,
        Player,
        Drown
    }

    public enum WeaponHitType
    {
        Melee = 0,
        Ranged = 1,
        Rock = 2,
        Undefined = -1
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

    public int draculaStacks { get; set; }

    public float stamina { get; set; }

    public float maxStamina { get; set; }

    public float hunger { get; set; }

    public float maxHunger { get; set; }

    public int strength { get; set; } = 1;


    public int speed { get; set; } = 1;


    public bool adrenalineBoost { get; private set; }

    private void Awake()
    {
        Instance = this;
        player = GetComponent<PlayerMovement>();
        maxShield = (int)shield;
        maxHp = (int)hp;
        stamina = 100f;
        hunger = 100f;
        maxStamina = stamina;
        maxHunger = hunger;
        strength = 1;
        speed = 1;
        armor = new InventoryItem[4];
        InvokeRepeating("SlowUpdate", 1f, 1f);
    }

    public void Respawn()
    {
        hp = maxHp;
        shield = maxShield;
        stamina = maxStamina;
        hunger = maxHunger;
        dead = false;
        GameManager.players[LocalClient.instance.myId].dead = false;
        MoveCamera.Instance.PlayerRespawn(PlayerMovement.Instance.transform.position);
        invincible = true;
        CancelInvoke("StopInvincible");
        Invoke("StopInvincible", 3f);
    }

    private void StopInvincible()
    {
        invincible = false;
    }

    public void UpdateStats()
    {
        maxHp = 100 + PowerupInventory.Instance.GetHpMultiplier(null) + draculaStacks;
        maxShield = PowerupInventory.Instance.GetShield(null);
    }

    public void Damage(int newHp, int damageType = 0, bool ignoreProtection = false)
    {
        if (!invincible && !(hp + shield <= 0f))
        {
            int damageTaken = (int)(hp + shield) - newHp;
            HandleDamage(damageTaken, damageType, ignoreProtection);
        }
    }

    public void DealDamage(int damage, int damageType = 0, bool ignoreProtection = false, int damageFromPlayer = -1)
    {
        if (!(hp + shield <= 0f))
        {
            HandleDamage(damage, damageType, ignoreProtection, damageFromPlayer);
        }
    }

    private void HandleDamage(int damageTaken, int damageType = 0, bool ignoreProtection = false, int damageFromPlayer = -1)
    {
        if (!ignoreProtection)
        {
            damageTaken = OneShotProtection(damageTaken);
        }
        if (shield >= (float)damageTaken)
        {
            shield -= damageTaken;
        }
        else
        {
            damageTaken -= (int)shield;
            shield = 0f;
            hp -= damageTaken;
        }
        if (hp <= 0f)
        {
            hp = 0f;
            PlayerDied(damageType, damageFromPlayer);
        }
        if (hp / (float)maxHp < 0.3f && !adrenalineBoost && readyToAdrenalineBoost)
        {
            adrenalineBoost = true;
            readyToAdrenalineBoost = false;
            Invoke("StopAdrenaline", 5f);
        }
        readyToRegenShield = false;
        CancelInvoke("RegenShield");
        if (!dead)
        {
            Invoke("RegenShield", regenShieldDelay);
        }
        float shakeRatio = (float)damageTaken / (float)MaxHpAndShield();
        CameraShaker.Instance.DamageShake(shakeRatio);
        DamageVignette.Instance.VignetteHit();
    }

    private int OneShotProtection(int damageDone)
    {
        if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
        {
            return damageDone;
        }
        if (!protectionActive)
        {
            return damageDone;
        }
        if ((float)damageDone / (float)MaxHpAndShield() > 0.9f)
        {
            damageDone = (int)((float)MaxHpAndShield() * oneShotThreshold);
        }
        protectionActive = false;
        Invoke("ActivateProtection", oneShotProtectionCooldown);
        return damageDone;
    }

    private void ActivateProtection()
    {
        protectionActive = true;
    }

    private void StopAdrenaline()
    {
        adrenalineBoost = false;
        Invoke("ReadyAdrenaline", 10f);
    }

    private void ReadyAdrenaline()
    {
        readyToAdrenalineBoost = true;
    }

    private void PlayerDied(int damageType, int damageFromPlayer = -1)
    {
        hp = 0f;
        shield = 0f;
        PlayerMovement.Instance.gameObject.SetActive(value: false);
        dead = true;
        GameManager.players[LocalClient.instance.myId].dead = true;
        InventoryCell[] allCells = InventoryUI.Instance.allCells;
        foreach (InventoryCell inventoryCell in allCells)
        {
            if (!(inventoryCell.currentItem == null))
            {
                InventoryUI.Instance.DropItemIntoWorld(inventoryCell.currentItem);
                inventoryCell.currentItem = null;
                inventoryCell.UpdateCell();
            }
        }
        Hotbar.Instance.UpdateHotbar();
        ClientSend.PlayerDied(damageFromPlayer);
        PlayerRagdoll component = Object.Instantiate(playerRagdoll, PlayerMovement.Instance.transform.position, PlayerMovement.Instance.orientation.rotation).GetComponent<PlayerRagdoll>();
        MoveCamera.Instance.PlayerDied(component.transform.GetChild(0).GetChild(0).GetChild(0));
        component.SetRagdoll(LocalClient.instance.myId, -component.transform.forward);
        GameManager.players[LocalClient.instance.myId].dead = true;
        if (InventoryUI.Instance.gameObject.activeInHierarchy)
        {
            OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
        }
        for (int j = 0; j < armor.Length; j++)
        {
            UpdateArmor(j, -1);
        }
        AchievementManager.Instance.AddDeath((DamageType)damageType);
    }

    public bool IsPlayerDead()
    {
        return dead;
    }

    public void DropAllItems(List<InventoryCell> cells)
    {
    }

    public bool IsFullyHealed()
    {
        if (hp >= (float)maxHp)
        {
            return shield >= (float)maxShield;
        }
        return false;
    }

    public int HpAndShield()
    {
        return (int)(hp + shield);
    }

    public int MaxHpAndShield()
    {
        return maxHp + maxShield;
    }

    public float GetArmorRatio()
    {
        return armorTotal / 100f;
    }

    private void Update()
    {
        Stamina();
        Shield();
        Healing();
        Hunger();
        OutOfMap();
    }

    public void EnterOcean()
    {
        windParticles.SetActive(value: true);
        ParticleSystem.EmissionModule emission = leafParticles.GetComponent<ParticleSystem>().emission;
        emission.enabled = false;
    }

    private void SlowUpdate()
    {
        if (player.playerCam.position.y < World.Instance.water.position.y)
        {
            if (!underwaterAudio.enabled)
            {
                underwaterAudio.enabled = true;
                underwaterAudio.Play();
            }
        }
        else if (underwaterAudio.enabled)
        {
            underwaterAudio.enabled = false;
        }
        if (stamina <= 0f && underwater && hp > 0f)
        {
            DealDamage(5, 2);
            Object.Instantiate(drownParticles, base.transform.position, Quaternion.LookRotation(player.playerCam.transform.forward));
        }
    }

    private void OutOfMap()
    {
        if (!dead && (bool)PlayerMovement.Instance && PlayerMovement.Instance.transform.position.y < -200f)
        {
            Damage(1);
            if (Physics.Raycast(Vector3.up * 500f, Vector3.down, out var hitInfo, 1000f, GameManager.instance.whatIsGround))
            {
                PlayerMovement.Instance.transform.position = hitInfo.point + Vector3.up * 2f;
                PlayerMovement.Instance.GetRb().velocity = Vector3.zero;
            }
        }
    }

    private void Shield()
    {
        if (readyToRegenShield && !(shield >= (float)maxShield) && !(hp + shield <= 0f))
        {
            shield += shieldRegenRate * Time.deltaTime;
            if (shield > (float)maxShield)
            {
                shield = maxShield;
            }
        }
    }

    private void Hunger()
    {
        if (!(hunger <= 0f) && !(hp <= 0f))
        {
            float num = 1f * PowerupInventory.Instance.GetHungerMultiplier(null);
            if (healing)
            {
                num *= healingDrainMultiplier;
            }
            if (running)
            {
                num *= staminaDrainMultiplier;
            }
            hunger -= hungerDrainRate * Time.deltaTime * num;
            if (hunger < 0f)
            {
                hunger = 0f;
            }
        }
    }

    private void Healing()
    {
        if (!(hp <= 0f) && !(hp >= (float)maxHp) && !(hunger <= 0f))
        {
            float num = healingRate * Time.deltaTime * PowerupInventory.Instance.GetHealingMultiplier(null);
            hp += num;
        }
    }

    private void Stamina()
    {
        running = player.GetVelocity().magnitude > 5f && player.sprinting;
        underwater = player.IsUnderWater();
        if (running || underwater)
        {
            if (!(stamina <= 0f))
            {
                stamina -= staminaDrainRate * Time.deltaTime / PowerupInventory.Instance.GetStaminaMultiplier(null);
            }
        }
        else if (stamina < 100f && player.grounded && hunger > 0f)
        {
            float num = 1f;
            if (hunger <= 0f)
            {
                num *= 0.3f;
            }
            stamina += staminaRegenRate * Time.deltaTime * num;
        }
    }

    public void Heal(int healAmount)
    {
        hp += healAmount;
        if (hp > (float)maxHp)
        {
            hp = maxHp;
        }
    }

    public void Eat(InventoryItem item)
    {
        hp += item.heal;
        if (hp > (float)maxHp)
        {
            hp = maxHp;
        }
        stamina += item.stamina;
        if (stamina > maxStamina)
        {
            stamina = maxStamina;
        }
        hunger += item.hunger;
        if (hunger > maxHunger)
        {
            hunger = maxHunger;
        }
        AchievementManager.Instance.EatFood(item);
    }

    private void RegenShield()
    {
        readyToRegenShield = true;
    }

    public float GetHpRatio()
    {
        if (maxHp == 0)
        {
            return 0f;
        }
        float num = maxShield + maxHp;
        float num2 = (float)maxHp / num;
        return hp / (float)maxHp * num2;
    }

    public float GetShieldRatio()
    {
        if (maxShield == 0)
        {
            return 0f;
        }
        float num = maxShield + maxHp;
        float num2 = (float)maxShield / num;
        return shield / (float)maxShield * num2;
    }

    public float GetStaminaRatio()
    {
        return stamina / maxStamina;
    }

    public float GetHungerRatio()
    {
        return hunger / maxHunger;
    }

    public void Jump()
    {
        stamina -= jumpDrain / PowerupInventory.Instance.GetStaminaMultiplier(null);
    }

    public void AddKill(int killType, Mob mob)
    {
        Dracula();
        AchievementManager.Instance.AddKill((WeaponHitType)killType, mob);
    }

    public void Dracula()
    {
        int hpIncreasePerKill = PowerupInventory.Instance.GetHpIncreasePerKill(null);
        draculaStacks += hpIncreasePerKill;
        int maxDraculaStacks = PowerupInventory.Instance.GetMaxDraculaStacks();
        if (draculaStacks >= maxDraculaStacks)
        {
            draculaStacks = maxDraculaStacks;
        }
        UpdateStats();
        hp += hpIncreasePerKill;
    }

    public void UpdateArmor(int armorSlot, int itemId)
    {
        InventoryItem inventoryItem = null;
        if (itemId >= 0)
        {
            inventoryItem = ItemManager.Instance.allItems[itemId];
        }
        armor[armorSlot] = inventoryItem;
        armorTotal = 0f;
        InventoryItem[] array = armor;
        foreach (InventoryItem inventoryItem2 in array)
        {
            if (!(inventoryItem2 == null))
            {
                armorTotal += inventoryItem2.armor;
            }
        }
        ClientSend.SendArmor(armorSlot, itemId);
        CheckArmorSetBonus();
        if ((bool)PreviewPlayer.Instance)
        {
            PreviewPlayer.Instance.SetArmor(armorSlot, itemId);
        }
    }

    private void CheckArmorSetBonus()
    {
        currentSpeedArmorMultiplier = 1f;
        currentChunkArmorMultiplier = 1f;
        if (armor[0] == null)
        {
            return;
        }
        int id = armor[0].requirements[0].item.id;
        InventoryItem[] array = armor;
        foreach (InventoryItem inventoryItem in array)
        {
            if (inventoryItem == null || inventoryItem.requirements[0].item.id != id)
            {
                return;
            }
        }
        string text = armor[0].requirements[0].item.name;
        if (!(text == "Wolfskin"))
        {
            if (text == "Chunkium bar")
            {
                currentChunkArmorMultiplier = 1.6f;
            }
        }
        else
        {
            currentSpeedArmorMultiplier = 1.5f;
        }
    }

    public bool CanRun()
    {
        return stamina > 0f;
    }

    public bool CanJump()
    {
        return stamina >= jumpDrain;
    }
}
