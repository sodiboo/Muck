
using TMPro;
using UnityEngine;

// Token: 0x02000038 RID: 56
public class InventoryStats : MonoBehaviour
{
	// Token: 0x0600013C RID: 316 RVA: 0x00008998 File Offset: 0x00006B98
	private void OnEnable()
	{
		this.UpdateStats();
	}

	// Token: 0x0600013D RID: 317 RVA: 0x000089A0 File Offset: 0x00006BA0
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

	// Token: 0x0600013E RID: 318 RVA: 0x00008AB0 File Offset: 0x00006CB0
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

	// Token: 0x04000142 RID: 322
	public TextMeshProUGUI text;

	// Token: 0x04000143 RID: 323
	public TextMeshProUGUI numbersText;
}
