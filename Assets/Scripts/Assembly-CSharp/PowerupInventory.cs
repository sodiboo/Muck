
using JetBrains.Annotations;
using UnityEngine;

// Token: 0x02000081 RID: 129
public class PowerupInventory : MonoBehaviour
{
	// Token: 0x0600034F RID: 847 RVA: 0x00011243 File Offset: 0x0000F443
	private void Awake()
	{
		PowerupInventory.Instance = this;
	}

	// Token: 0x06000350 RID: 848 RVA: 0x0001124B File Offset: 0x0000F44B
	private void Start()
	{
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
	}

	// Token: 0x06000351 RID: 849 RVA: 0x00011268 File Offset: 0x0000F468
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
		ParticleSystem component =Instantiate(this.powerupFx, position, Quaternion.identity).GetComponent<ParticleSystem>();
		var sys = component.main;
		sys.startColor = ItemManager.Instance.allPowerups[powerupId].GetOutlineColor();
		if (ItemManager.Instance.allPowerups[powerupId].tier == Powerup.PowerTier.Orange)
		{
			component.gameObject.GetComponent<RandomSfx>().sounds = new AudioClip[]
			{
				this.goodPowerupSfx
			};
			component.GetComponent<RandomSfx>().Randomize(0f);
		}
	}

	// Token: 0x06000352 RID: 850 RVA: 0x000113A4 File Offset: 0x0000F5A4
	public float GetDefenseMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Danis Milk"]], 0.1f, 40f);
	}

	// Token: 0x06000353 RID: 851 RVA: 0x000113D8 File Offset: 0x0000F5D8
	public static float CumulativeDistribution(int amount, float scaleSpeed, float maxValue)
	{
		float f = 2.71828f;
		return (1f - Mathf.Pow(f, (float)(-(float)amount) * scaleSpeed)) * maxValue;
	}

	// Token: 0x06000354 RID: 852 RVA: 0x00011400 File Offset: 0x0000F600
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

	// Token: 0x06000355 RID: 853 RVA: 0x0001149E File Offset: 0x0000F69E
	public int GetExtraDamage([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 0;
	}

	// Token: 0x06000356 RID: 854 RVA: 0x000114AC File Offset: 0x0000F6AC
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

	// Token: 0x06000357 RID: 855 RVA: 0x00011514 File Offset: 0x0000F714
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

	// Token: 0x06000358 RID: 856 RVA: 0x00011570 File Offset: 0x0000F770
	public float GetHealingMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = (float)playerPowerups[ItemManager.Instance.stringToPowerupId["Broccoli"]];
		float num2 = 0.1f;
		return num * num2;
	}

	// Token: 0x06000359 RID: 857 RVA: 0x000115A8 File Offset: 0x0000F7A8
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

	// Token: 0x0600035A RID: 858 RVA: 0x00011608 File Offset: 0x0000F808
	public float GetLootMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Piggybank"]];
		return 1f + PowerupInventory.CumulativeDistribution(amount, 0.16f, 2f);
	}

	// Token: 0x0600035B RID: 859 RVA: 0x00011650 File Offset: 0x0000F850
	public float GetSniperScopeMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]];
		float num = PowerupInventory.CumulativeDistribution(amount, 0.13f, 0.3f);
		float result = PowerupInventory.CumulativeDistribution(amount, 0.3f, 70f);
		if (num > Random.Range(0f, 1f))
		{
			return result;
		}
		return 1f;
	}

	// Token: 0x0600035C RID: 860 RVA: 0x000116B8 File Offset: 0x0000F8B8
	public float GetSniperScopeDamageMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]], 0.3f, 70f);
		return 1f + num;
	}

	// Token: 0x0600035D RID: 861 RVA: 0x00011700 File Offset: 0x0000F900
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

	// Token: 0x0600035E RID: 862 RVA: 0x0001177C File Offset: 0x0000F97C
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

	// Token: 0x0600035F RID: 863 RVA: 0x000117AF File Offset: 0x0000F9AF
	public int GetHpIncreasePerKill([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Dracula"]];
	}

	// Token: 0x06000360 RID: 864 RVA: 0x000117D4 File Offset: 0x0000F9D4
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

	// Token: 0x06000361 RID: 865 RVA: 0x00011808 File Offset: 0x0000FA08
	public float GetHungerMultiplier([CanBeNull] int[] playerPowerups)
	{
		return 1f;
	}

	// Token: 0x06000362 RID: 866 RVA: 0x0001181C File Offset: 0x0000FA1C
	public float GetJuiceMultiplier([CanBeNull] int[] playerPowerups)
	{
		return 1f;
	}

	// Token: 0x06000363 RID: 867 RVA: 0x00011830 File Offset: 0x0000FA30
	public float GetRobinMultiplier([CanBeNull] int[] playerPowerups)
	{
		return 1f;
	}

	// Token: 0x06000364 RID: 868 RVA: 0x00011844 File Offset: 0x0000FA44
	public float GetEnforcerMultiplier([CanBeNull] int[] playerPowerups, float speed = -1f)
	{
		return 1f;
	}

	// Token: 0x06000365 RID: 869 RVA: 0x00011858 File Offset: 0x0000FA58
	public float GetSpeedMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sneaker"]], 0.08f, 2f);
		float num2 = 1f;
		if (PlayerStatus.Instance.adrenalineBoost)
		{
			num2 = this.GetAdrenalineBoost(null);
		}
		return (1f + num) * num2;
	}

	// Token: 0x06000366 RID: 870 RVA: 0x000118BC File Offset: 0x0000FABC
	public float GetAdrenalineBoost([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Adrenaline"]], 1f, 2f);
		return 1f + num;
	}

	// Token: 0x06000367 RID: 871 RVA: 0x00011901 File Offset: 0x0000FB01
	public int GetMaxHpAndShield(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 100 + this.GetHpMultiplier(playerPowerups) + this.GetShield(playerPowerups);
	}

	// Token: 0x06000368 RID: 872 RVA: 0x00011920 File Offset: 0x0000FB20
	public float GetCritChance(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Horseshoe"]], 0.08f, 0.9f);
		return 0.1f + num;
	}

	// Token: 0x06000369 RID: 873 RVA: 0x00011968 File Offset: 0x0000FB68
	public float GetJumpMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Jetpack"]], 0.075f, 2.5f);
		return 1f + num;
	}

	// Token: 0x0600036A RID: 874 RVA: 0x000119AD File Offset: 0x0000FBAD
	public int GetExtraJumps(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Janniks Frog"]];
	}

	// Token: 0x0600036B RID: 875 RVA: 0x000119D0 File Offset: 0x0000FBD0
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

	// Token: 0x0600036C RID: 876 RVA: 0x00011A20 File Offset: 0x0000FC20
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

	// Token: 0x0600036D RID: 877 RVA: 0x00011A79 File Offset: 0x0000FC79
	public float GetLifestealMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Crimson Dagger"]], 0.1f, 0.5f);
	}

	// Token: 0x0600036E RID: 878 RVA: 0x00011AAB File Offset: 0x0000FCAB
	public float GetDamageMultiplier()
	{
		return 1f;
	}

	// Token: 0x0600036F RID: 879 RVA: 0x0000276E File Offset: 0x0000096E
	public void StartJuice()
	{
	}

	// Token: 0x06000370 RID: 880 RVA: 0x00011AB2 File Offset: 0x0000FCB2
	private void StopJuice()
	{
		this.juiceSpeed = 1f;
	}

	// Token: 0x04000323 RID: 803
	private int[] powerups;

	// Token: 0x04000324 RID: 804
	public GameObject powerupFx;

	// Token: 0x04000325 RID: 805
	public AudioClip goodPowerupSfx;

	// Token: 0x04000326 RID: 806
	private float juiceSpeed = 1f;

	// Token: 0x04000327 RID: 807
	public static PowerupInventory Instance;
}
