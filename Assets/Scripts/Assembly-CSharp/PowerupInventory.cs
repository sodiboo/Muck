using JetBrains.Annotations;
using UnityEngine;


public class PowerupInventory : MonoBehaviour
{

	private void Awake()
	{
		PowerupInventory.Instance = this;
	}


	private void Start()
	{
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
	}


	public void AddPowerup(string name, int powerupId, int objectId)
	{
		this.powerups[powerupId]++;
		UiEvents.Instance.AddPowerup(ItemManager.Instance.allPowerups[powerupId]);
		PlayerStatus.Instance.UpdateStats();
		PowerupUI.Instance.AddPowerup(powerupId);
		string colorName = ItemManager.Instance.allPowerups[powerupId].GetColorName();
		string message = string.Concat(new string[]
		{
			"Picked up <color=",
			colorName,
			">(",
			name,
			")<color=white>"
		});
		ChatBox.Instance.SendMessage(message);
		Vector3 position = ItemManager.Instance.list[objectId].transform.position;
		ParticleSystem component =Instantiate<GameObject>(this.powerupFx, position, Quaternion.identity).GetComponent<ParticleSystem>();
		var main= component.main;
		main.startColor = ItemManager.Instance.allPowerups[powerupId].GetOutlineColor();
		if (ItemManager.Instance.allPowerups[powerupId].tier == Powerup.PowerTier.Orange)
		{
			component.gameObject.GetComponent<RandomSfx>().sounds = new AudioClip[]
			{
				this.goodPowerupSfx
			};
			component.GetComponent<RandomSfx>().Randomize(0f);
		}
	}


	public float GetDefenseMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Danis Milk"]], 0.1f, 40f);
	}


	public static float CumulativeDistribution(int amount, float scaleSpeed, float maxValue)
	{
		float f = 2.71828f;
		return (1f - Mathf.Pow(f, (float)(-(float)amount) * scaleSpeed)) * maxValue;
	}


	public float GetStrengthMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Dumbbell"]];
		float num2 = 0.1f;
		int num3 = playerPowerups[ItemManager.Instance.stringToPowerupId["Berserk"]];
		float num4 = 0f;
		if (num3 > 0)
		{
			num4 = ((float)PlayerStatus.Instance.maxHp - PlayerStatus.Instance.hp) / (float)PlayerStatus.Instance.maxHp;
		}
		MonoBehaviour.print("berserk multiplier: " + num4);
		return 1f + (float)num * num2 + (float)num3 * num4;
	}


	public int GetExtraDamage([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 0;
	}


	public float GetAttackSpeedMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Orange Juice"]], 0.12f, 1f);
		float num2 = 1f;
		if (PlayerStatus.Instance.adrenalineBoost)
		{
			num2 = this.GetAdrenalineBoost(null);
		}
		return (1f + num) * num2 * this.juiceSpeed;
	}


	public float GetStaminaMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Peanut Butter"]];
		float num2 = 0.15f;
		float num3 = 1f;
		if (PlayerStatus.Instance.adrenalineBoost)
		{
			num3 = this.GetAdrenalineBoost(null);
		}
		return (1f + (float)num * num2) * num3;
	}


	public float GetHealingMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = (float)playerPowerups[ItemManager.Instance.stringToPowerupId["Broccoli"]];
		float num2 = 0.05f;
		return num * num2;
	}


	public float GetResourceMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = 0f;
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			num = 1.75f;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Checkered Shirt"]];
		return 1f + PowerupInventory.CumulativeDistribution(amount, 0.3f, 4f) + num;
	}


	public float GetLootMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Piggybank"]];
		return 1f + PowerupInventory.CumulativeDistribution(amount, 0.15f, 1.25f);
	}


	public float GetSniperScopeMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]];
		float num = PowerupInventory.CumulativeDistribution(amount, 0.15f, 0.2f);
		float result = PowerupInventory.CumulativeDistribution(amount, 0.25f, 50f);
		if (num > Random.Range(0f, 1f))
		{
			return result;
		}
		return 1f;
	}


	public float GetSniperScopeDamageMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]], 0.3f, 70f);
		return 1f + num;
	}


	public float GetLightningMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Knuts Hammer"]];
		if (num <= 0)
		{
			return -1f;
		}
		float num2 = PowerupInventory.CumulativeDistribution(num, 0.12f, 0.4f);
		float num3 = PowerupInventory.CumulativeDistribution(num, 0.12f, 1f);
		if (num2 > Random.Range(0f, 1f))
		{
			return 2f + num3;
		}
		return -1f;
	}


	public int GetHpMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Red Pill"]];
		int num2 = 10;
		return num * num2;
	}


	public int GetHpIncreasePerKill([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Dracula"]];
	}


	public int GetShield([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Blue Pill"]];
		int num2 = 10;
		return num * num2;
	}


	public float GetHungerMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Spooo Bean"]], 0.2f, 0.5f);
		return 1f - num;
	}


	public float GetJuiceMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Juice"]], 0.3f, 1f);
		return 1f + num;
	}


	public float GetRobinMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Robin Hood Hat"]], 0.06f, 2f);
		return 1f + num;
	}


	public float GetEnforcerMultiplier([CanBeNull] int[] playerPowerups, float speed = -1f)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Enforcer"]];
		if (num < 1)
		{
			return 1f;
		}
		float num2 = PowerupInventory.CumulativeDistribution(num, 0.4f, 2f);
		float num3 = PlayerMovement.Instance.GetVelocity().magnitude / 20f;
		if (speed != -1f)
		{
			num3 = speed / 20f;
		}
		float num4 = num2 * num3;
		return 1f + num4;
	}


	public float GetSpeedMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sneaker"]], 0.08f, 1.75f);
		float num2 = 1f;
		if (PlayerStatus.Instance.adrenalineBoost)
		{
			num2 = this.GetAdrenalineBoost(null);
		}
		return (1f + num) * num2 * PlayerStatus.Instance.currentSpeedArmorMultiplier;
	}


	public float GetAdrenalineBoost([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Adrenaline"]], 1f, 2f);
		return 1f + num;
	}


	public int GetMaxHpAndShield(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 100 + this.GetHpMultiplier(playerPowerups) + this.GetShield(playerPowerups);
	}


	public float GetCritChance(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Horseshoe"]], 0.08f, 0.9f);
		return 0.1f + num;
	}


	public float GetJumpMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Jetpack"]], 0.075f, 2.5f);
		return 1f + num;
	}


	public int GetExtraJumps(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Janniks Frog"]];
	}


	public float GetFallWingsMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int num = playerPowerups[ItemManager.Instance.stringToPowerupId["Wings of Glory"]];
		if (num == 0)
		{
			return 1f;
		}
		float num2 = PowerupInventory.CumulativeDistribution(num, 0.45f, 2.5f);
		return 1f + num2;
	}


	public float GetKnockbackMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		if (PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Bulldozer"]], 0.15f, 1f) > Random.Range(0f, 1f))
		{
			return 1f;
		}
		return 0f;
	}


	public float GetLifestealMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Crimson Dagger"]], 0.1f, 0.5f);
	}


	public float GetDamageMultiplier()
	{
		return 1f;
	}


	public void StartJuice()
	{
		if (this.powerups[ItemManager.Instance.stringToPowerupId["Juice"]] < 1)
		{
			return;
		}
		this.juiceSpeed = this.GetJuiceMultiplier(null);
		base.CancelInvoke(nameof(StopJuice));
		base.Invoke(nameof(StopJuice), 2f);
	}


	private void StopJuice()
	{
		this.juiceSpeed = 1f;
	}


	public int GetAmount(string powerup)
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId[powerup]];
	}


	public int GetMaxDraculaStacks()
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId["Dracula"]] * this.maxStacksPerDracula;
	}


	private int[] powerups;


	public GameObject powerupFx;


	public AudioClip goodPowerupSfx;


	private float juiceSpeed = 1f;


	public static PowerupInventory Instance;


	private int maxStacksPerDracula = 50;
}
