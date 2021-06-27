using System;
using TMPro;
using UnityEngine;

public class InventoryStats : MonoBehaviour
{
	private void OnEnable()
	{
		this.UpdateStats();
	}

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

	public TextMeshProUGUI text;

	public TextMeshProUGUI numbersText;
}
