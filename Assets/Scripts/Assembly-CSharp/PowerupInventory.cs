using JetBrains.Annotations;
using UnityEngine;

// Token: 0x020000A7 RID: 167
public class PowerupInventory : MonoBehaviour
{
	// Token: 0x0600043A RID: 1082 RVA: 0x00015D9B File Offset: 0x00013F9B
	private void Awake()
	{
		PowerupInventory.Instance = this;
	}

	// Token: 0x0600043B RID: 1083 RVA: 0x00015DA3 File Offset: 0x00013FA3
	private void Start()
	{
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
	}

	// Token: 0x0600043C RID: 1084 RVA: 0x00015DC0 File Offset: 0x00013FC0
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
		ParticleSystem component = Instantiate<GameObject>(this.powerupFx, position, Quaternion.identity).GetComponent<ParticleSystem>();
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

	// Token: 0x0600043D RID: 1085 RVA: 0x00015EFC File Offset: 0x000140FC
	public float GetDefenseMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Danis Milk"]], 0.1f, 40f);
	}

	// Token: 0x0600043E RID: 1086 RVA: 0x00015F30 File Offset: 0x00014130
	public static float CumulativeDistribution(int amount, float scaleSpeed, float maxValue)
	{
		float f = 2.71828f;
		return (1f - Mathf.Pow(f, (float)(-(float)amount) * scaleSpeed)) * maxValue;
	}

	// Token: 0x0600043F RID: 1087 RVA: 0x00015F58 File Offset: 0x00014158
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

	// Token: 0x06000440 RID: 1088 RVA: 0x00015FF6 File Offset: 0x000141F6
	public int GetExtraDamage([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 0;
	}

	// Token: 0x06000441 RID: 1089 RVA: 0x00016004 File Offset: 0x00014204
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

	// Token: 0x06000442 RID: 1090 RVA: 0x0001606C File Offset: 0x0001426C
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

	// Token: 0x06000443 RID: 1091 RVA: 0x000160C8 File Offset: 0x000142C8
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

	// Token: 0x06000444 RID: 1092 RVA: 0x00016100 File Offset: 0x00014300
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

	// Token: 0x06000445 RID: 1093 RVA: 0x00016160 File Offset: 0x00014360
	public float GetLootMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Piggybank"]];
		return 1f + PowerupInventory.CumulativeDistribution(amount, 0.15f, 1.25f);
	}

	// Token: 0x06000446 RID: 1094 RVA: 0x000161A8 File Offset: 0x000143A8
	public float GetSniperScopeMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]];
		float num = PowerupInventory.CumulativeDistribution(amount, 0.14f, 0.15f);
		float result = PowerupInventory.CumulativeDistribution(amount, 0.25f, 50f);
		if (num > Random.Range(0f, 1f))
		{
			return result;
		}
		return 1f;
	}

	// Token: 0x06000447 RID: 1095 RVA: 0x00016210 File Offset: 0x00014410
	public float GetSniperScopeDamageMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]], 0.3f, 70f);
		return 1f + num;
	}

	// Token: 0x06000448 RID: 1096 RVA: 0x00016258 File Offset: 0x00014458
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

	// Token: 0x06000449 RID: 1097 RVA: 0x000162D4 File Offset: 0x000144D4
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

	// Token: 0x0600044A RID: 1098 RVA: 0x00016307 File Offset: 0x00014507
	public int GetHpIncreasePerKill([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Dracula"]];
	}

	// Token: 0x0600044B RID: 1099 RVA: 0x0001632C File Offset: 0x0001452C
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

	// Token: 0x0600044C RID: 1100 RVA: 0x00016360 File Offset: 0x00014560
	public float GetHungerMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Spooo Bean"]], 0.2f, 0.5f);
		return 1f - num;
	}

	// Token: 0x0600044D RID: 1101 RVA: 0x000163A8 File Offset: 0x000145A8
	public float GetJuiceMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Juice"]], 0.3f, 1f);
		return 1f + num;
	}

	// Token: 0x0600044E RID: 1102 RVA: 0x000163F0 File Offset: 0x000145F0
	public float GetRobinMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Robin Hood Hat"]], 0.06f, 2f);
		return 1f + num;
	}

	// Token: 0x0600044F RID: 1103 RVA: 0x00016438 File Offset: 0x00014638
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

	// Token: 0x06000450 RID: 1104 RVA: 0x000164B4 File Offset: 0x000146B4
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

	// Token: 0x06000451 RID: 1105 RVA: 0x00016520 File Offset: 0x00014720
	public float GetAdrenalineBoost([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Adrenaline"]], 1f, 2f);
		return 1f + num;
	}

	// Token: 0x06000452 RID: 1106 RVA: 0x00016565 File Offset: 0x00014765
	public int GetMaxHpAndShield(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 100 + this.GetHpMultiplier(playerPowerups) + this.GetShield(playerPowerups);
	}

	// Token: 0x06000453 RID: 1107 RVA: 0x00016584 File Offset: 0x00014784
	public float GetCritChance(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Horseshoe"]], 0.08f, 0.9f);
		return 0.1f + num;
	}

	// Token: 0x06000454 RID: 1108 RVA: 0x000165CC File Offset: 0x000147CC
	public float GetJumpMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Jetpack"]], 0.075f, 2.5f);
		return 1f + num;
	}

	// Token: 0x06000455 RID: 1109 RVA: 0x00016611 File Offset: 0x00014811
	public int GetExtraJumps(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Janniks Frog"]];
	}

	// Token: 0x06000456 RID: 1110 RVA: 0x00016634 File Offset: 0x00014834
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

	// Token: 0x06000457 RID: 1111 RVA: 0x00016684 File Offset: 0x00014884
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

	// Token: 0x06000458 RID: 1112 RVA: 0x000166DD File Offset: 0x000148DD
	public float GetLifestealMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Crimson Dagger"]], 0.1f, 0.5f);
	}

	// Token: 0x06000459 RID: 1113 RVA: 0x0001670F File Offset: 0x0001490F
	public float GetDamageMultiplier()
	{
		return 1f;
	}

	// Token: 0x0600045A RID: 1114 RVA: 0x00016718 File Offset: 0x00014918
	public void StartJuice()
	{
		if (this.powerups[ItemManager.Instance.stringToPowerupId["Juice"]] < 1)
		{
			return;
		}
		this.juiceSpeed = this.GetJuiceMultiplier(null);
		base.CancelInvoke("StopJuice");
		Invoke(nameof(StopJuice), 2f);
	}

	// Token: 0x0600045B RID: 1115 RVA: 0x0001676C File Offset: 0x0001496C
	private void StopJuice()
	{
		this.juiceSpeed = 1f;
	}

	// Token: 0x0600045C RID: 1116 RVA: 0x00016779 File Offset: 0x00014979
	public int GetAmount(string powerup)
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId[powerup]];
	}

	// Token: 0x0600045D RID: 1117 RVA: 0x00016792 File Offset: 0x00014992
	public int GetMaxDraculaStacks()
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId["Dracula"]] * this.maxStacksPerDracula;
	}

	// Token: 0x0400041F RID: 1055
	private int[] powerups;

	// Token: 0x04000420 RID: 1056
	public GameObject powerupFx;

	// Token: 0x04000421 RID: 1057
	public AudioClip goodPowerupSfx;

	// Token: 0x04000422 RID: 1058
	private float juiceSpeed = 1f;

	// Token: 0x04000423 RID: 1059
	public static PowerupInventory Instance;

	// Token: 0x04000424 RID: 1060
	private int maxStacksPerDracula = 40;
}
