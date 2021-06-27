using System;
using TMPro;
using UnityEngine;

// Token: 0x02000052 RID: 82
public class InventoryStats : MonoBehaviour
{
	// Token: 0x060001CD RID: 461 RVA: 0x0000B4F0 File Offset: 0x000096F0
	private void OnEnable()
	{
		this.UpdateStats();
	}

	// Token: 0x060001CE RID: 462 RVA: 0x0000B4F8 File Offset: 0x000096F8
	private void UpdateStats()
	{
		int maxHp = PlayerStatus.Instance.maxHp;
		int maxShield = PlayerStatus.Instance.maxShield;
		int num = (int)(100f * PlayerStatus.Instance.GetArmorRatio());
		int num2 = -100 + (int)(100f * PowerupInventory.Instance.GetStrengthMultiplier(null));
		float num3 = (float)((int)(100f * PowerupInventory.Instance.GetCritChance(null)));
		int num4 = -100 + (int)(100f * PowerupInventory.Instance.GetAttackSpeedMultiplier(null));
		int num5 = -100 + (int)(100f * PowerupInventory.Instance.GetSpeedMultiplier(null));
		int num6 = this.FindMaxHit();
		this.text.text = "HP\nShield\nArmor\nStrength\nCritical%\nAttack Speed\nSpeed\nMax Hit";
		this.numbersText.text = string.Format("{0}\n{1}\n{2}\n{3}\n{4}%\n{5}\n{6}\n{7}", new object[]
		{
			maxHp,
			maxShield,
			num,
			num2,
			num3,
			num4,
			num5,
			num6
		});
	}

	// Token: 0x060001CF RID: 463 RVA: 0x0000B608 File Offset: 0x00009808
	private int FindMaxHit()
	{
		InventoryItem currentItem = Hotbar.Instance.currentItem;
		int num;
		if (currentItem == null)
		{
			num = 1;
		}
		else
		{
			num = currentItem.attackDamage;
		}
		return (int)((float)num * PowerupCalculations.Instance.GetMaxMultiplier().damageMultiplier);
	}

	// Token: 0x040001E9 RID: 489
	public TextMeshProUGUI text;

	// Token: 0x040001EA RID: 490
	public TextMeshProUGUI numbersText;
}
