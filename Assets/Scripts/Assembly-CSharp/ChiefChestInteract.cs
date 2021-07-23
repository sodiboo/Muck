using UnityEngine;

public class ChiefChestInteract : ChestInteract
{
    public bool alreadyOpened;

    public int mobZoneId;

    protected override void WhenOpened()
    {
        if (alreadyOpened)
        {
            return;
        }
        alreadyOpened = true;
        foreach (GameObject entity in MobZoneManager.Instance.zones[mobZoneId].entities)
        {
            entity.GetComponent<WoodmanBehaviour>().MakeAggressive(first: false);
        }
        if ((bool)AchievementManager.Instance)
        {
            AchievementManager.Instance.OpenChiefChest();
        }
    }
}
