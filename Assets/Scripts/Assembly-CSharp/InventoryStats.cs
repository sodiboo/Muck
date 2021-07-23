using TMPro;
using UnityEngine;

public class InventoryStats : MonoBehaviour
{
    public TextMeshProUGUI text;

    public TextMeshProUGUI numbersText;

    private void OnEnable()
    {
        UpdateStats();
    }

    private void UpdateStats()
    {
        int maxHp = PlayerStatus.Instance.maxHp;
        int maxShield = PlayerStatus.Instance.maxShield;
        int num = (int)(100f * PlayerStatus.Instance.GetArmorRatio());
        int num2 = -100 + (int)(100f * PowerupInventory.Instance.GetStrengthMultiplier(null));
        float num3 = (int)(100f * PowerupInventory.Instance.GetCritChance());
        int num4 = -100 + (int)(100f * PowerupInventory.Instance.GetAttackSpeedMultiplier(null));
        int num5 = -100 + (int)(100f * PowerupInventory.Instance.GetSpeedMultiplier(null));
        int num6 = FindMaxHit();
        text.text = "HP\nShield\nArmor\nStrength\nCritical%\nAttack Speed\nSpeed\nMax Hit";
        numbersText.text = $"{maxHp}\n{maxShield}\n{num}\n{num2}\n{num3}%\n{num4}\n{num5}\n{num6}";
    }

    private int FindMaxHit()
    {
        int num = 0;
        InventoryItem currentItem = Hotbar.Instance.currentItem;
        num = ((currentItem == null) ? 1 : currentItem.attackDamage);
        return (int)((float)num * PowerupCalculations.Instance.GetMaxMultiplier().damageMultiplier);
    }
}
