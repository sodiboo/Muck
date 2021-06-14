using JetBrains.Annotations;
using UnityEngine;

// Token: 0x020000A0 RID: 160
public class PowerupInventory : MonoBehaviour
{
	// Token: 0x06000399 RID: 921 RVA: 0x00004928 File Offset: 0x00002B28
	private void Awake()
	{
		PowerupInventory.Instance = this;
	}

	// Token: 0x0600039A RID: 922 RVA: 0x00004930 File Offset: 0x00002B30
	private void Start()
	{
		this.powerups = new int[ItemManager.Instance.allPowerups.Count];
	}

	// Token: 0x0600039B RID: 923 RVA: 0x00014D7C File Offset: 0x00012F7C
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

	// Token: 0x0600039C RID: 924 RVA: 0x0000494C File Offset: 0x00002B4C
	public float GetDefenseMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Danis Milk"]], 0.1f, 40f);
	}

	// Token: 0x0600039D RID: 925 RVA: 0x00014EB8 File Offset: 0x000130B8
	public static float CumulativeDistribution(int amount, float scaleSpeed, float maxValue)
	{
		float f = 2.71828f;
		return (1f - Mathf.Pow(f, (float)(-(float)amount) * scaleSpeed)) * maxValue;
	}

	// Token: 0x0600039E RID: 926 RVA: 0x00014EE0 File Offset: 0x000130E0
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

	// Token: 0x0600039F RID: 927 RVA: 0x0000497E File Offset: 0x00002B7E
	public int GetExtraDamage([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 0;
	}

	// Token: 0x060003A0 RID: 928 RVA: 0x00014F80 File Offset: 0x00013180
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

	// Token: 0x060003A1 RID: 929 RVA: 0x00014FE8 File Offset: 0x000131E8
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

	// Token: 0x060003A2 RID: 930 RVA: 0x00015044 File Offset: 0x00013244
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

	// Token: 0x060003A3 RID: 931 RVA: 0x0001507C File Offset: 0x0001327C
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

	// Token: 0x060003A4 RID: 932 RVA: 0x000150DC File Offset: 0x000132DC
	public float GetLootMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		int amount = playerPowerups[ItemManager.Instance.stringToPowerupId["Piggybank"]];
		return 1f + PowerupInventory.CumulativeDistribution(amount, 0.15f, 1.25f);
	}

	// Token: 0x060003A5 RID: 933 RVA: 0x00015124 File Offset: 0x00013324
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

	// Token: 0x060003A6 RID: 934 RVA: 0x0001518C File Offset: 0x0001338C
	public float GetSniperScopeDamageMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Sniper Scope"]], 0.3f, 70f);
		return 1f + num;
	}

	// Token: 0x060003A7 RID: 935 RVA: 0x000151D4 File Offset: 0x000133D4
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

	// Token: 0x060003A8 RID: 936 RVA: 0x00015250 File Offset: 0x00013450
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

	// Token: 0x060003A9 RID: 937 RVA: 0x0000498C File Offset: 0x00002B8C
	public int GetHpIncreasePerKill([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Dracula"]];
	}

	// Token: 0x060003AA RID: 938 RVA: 0x00015284 File Offset: 0x00013484
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

	// Token: 0x060003AB RID: 939 RVA: 0x000152B8 File Offset: 0x000134B8
	public float GetHungerMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Spooo Bean"]], 0.2f, 0.5f);
		return 1f - num;
	}

	// Token: 0x060003AC RID: 940 RVA: 0x00015300 File Offset: 0x00013500
	public float GetJuiceMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Juice"]], 0.3f, 1f);
		return 1f + num;
	}

	// Token: 0x060003AD RID: 941 RVA: 0x00015348 File Offset: 0x00013548
	public float GetRobinMultiplier([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Robin Hood Hat"]], 0.06f, 2f);
		return 1f + num;
	}

	// Token: 0x060003AE RID: 942 RVA: 0x00015390 File Offset: 0x00013590
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

	// Token: 0x060003AF RID: 943 RVA: 0x0001540C File Offset: 0x0001360C
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

	// Token: 0x060003B0 RID: 944 RVA: 0x00015478 File Offset: 0x00013678
	public float GetAdrenalineBoost([CanBeNull] int[] playerPowerups)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Adrenaline"]], 1f, 2f);
		return 1f + num;
	}

	// Token: 0x060003B1 RID: 945 RVA: 0x000049AF File Offset: 0x00002BAF
	public int GetMaxHpAndShield(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return 100 + this.GetHpMultiplier(playerPowerups) + this.GetShield(playerPowerups);
	}

	// Token: 0x060003B2 RID: 946 RVA: 0x000154C0 File Offset: 0x000136C0
	public float GetCritChance(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Horseshoe"]], 0.08f, 0.9f);
		return 0.1f + num;
	}

	// Token: 0x060003B3 RID: 947 RVA: 0x00015508 File Offset: 0x00013708
	public float GetJumpMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		float num = PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Jetpack"]], 0.075f, 2.5f);
		return 1f + num;
	}

	// Token: 0x060003B4 RID: 948 RVA: 0x000049CE File Offset: 0x00002BCE
	public int GetExtraJumps(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return playerPowerups[ItemManager.Instance.stringToPowerupId["Janniks Frog"]];
	}

	// Token: 0x060003B5 RID: 949 RVA: 0x00015550 File Offset: 0x00013750
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

	// Token: 0x060003B6 RID: 950 RVA: 0x000155A0 File Offset: 0x000137A0
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

	// Token: 0x060003B7 RID: 951 RVA: 0x000049F1 File Offset: 0x00002BF1
	public float GetLifestealMultiplier(int[] playerPowerups = null)
	{
		if (playerPowerups == null)
		{
			playerPowerups = this.powerups;
		}
		return PowerupInventory.CumulativeDistribution(playerPowerups[ItemManager.Instance.stringToPowerupId["Crimson Dagger"]], 0.1f, 0.5f);
	}

	// Token: 0x060003B8 RID: 952 RVA: 0x00004A23 File Offset: 0x00002C23
	public float GetDamageMultiplier()
	{
		return 1f;
	}

	// Token: 0x060003B9 RID: 953 RVA: 0x000155FC File Offset: 0x000137FC
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

	// Token: 0x060003BA RID: 954 RVA: 0x00004A2A File Offset: 0x00002C2A
	private void StopJuice()
	{
		this.juiceSpeed = 1f;
	}

	// Token: 0x060003BB RID: 955 RVA: 0x00004A37 File Offset: 0x00002C37
	public int GetAmount(string powerup)
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId[powerup]];
	}

	// Token: 0x060003BC RID: 956 RVA: 0x00004A50 File Offset: 0x00002C50
	public int GetMaxDraculaStacks()
	{
		return this.powerups[ItemManager.Instance.stringToPowerupId["Dracula"]] * this.maxStacksPerDracula;
	}

	// Token: 0x040003B2 RID: 946
	private int[] powerups;

	// Token: 0x040003B3 RID: 947
	public GameObject powerupFx;

	// Token: 0x040003B4 RID: 948
	public AudioClip goodPowerupSfx;

	// Token: 0x040003B5 RID: 949
	private float juiceSpeed = 1f;

	// Token: 0x040003B6 RID: 950
	public static PowerupInventory Instance;

	// Token: 0x040003B7 RID: 951
	private int maxStacksPerDracula = 50;
}
