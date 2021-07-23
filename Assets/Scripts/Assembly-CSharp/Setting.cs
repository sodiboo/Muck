using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

public class Setting : MonoBehaviour
{
    public class ButtonClickedEvent : UnityEvent
    {
    }

    public int currentSetting;

    [FormerlySerializedAs("onClick")]
    [SerializeField]
    public ButtonClickedEvent m_OnClick = new ButtonClickedEvent();

    public ButtonClickedEvent onClick
    {
        get
        {
            return m_OnClick;
        }
        set
        {
            m_OnClick = value;
        }
    }
}
