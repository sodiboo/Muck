using UnityEngine;
using UnityEngine.EventSystems;

public class PowerupInfo : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
    public Powerup powerup { get; set; }

    public void OnPointerEnter(PointerEventData eventData)
    {
        ItemInfo.Instance.SetText(powerup.name + "\n<size=50%><i>" + powerup.description, leftCorner: true);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        ItemInfo.Instance.Fade(0f);
    }
}
