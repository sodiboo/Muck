
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

// Token: 0x020000D7 RID: 215
public class Setting : MonoBehaviour
{
	// Token: 0x1700004A RID: 74
	// (get) Token: 0x0600065F RID: 1631 RVA: 0x00020262 File Offset: 0x0001E462
	// (set) Token: 0x06000660 RID: 1632 RVA: 0x0002026A File Offset: 0x0001E46A
	public Setting.ButtonClickedEvent onClick
	{
		get
		{
			return this.m_OnClick;
		}
		set
		{
			this.m_OnClick = value;
		}
	}

	// Token: 0x040005D7 RID: 1495
	public int currentSetting;

	// Token: 0x040005D8 RID: 1496
	[FormerlySerializedAs("onClick")]
	[SerializeField]
	public Setting.ButtonClickedEvent m_OnClick = new Setting.ButtonClickedEvent();

	// Token: 0x02000134 RID: 308
	public class ButtonClickedEvent : UnityEvent
	{
	}
}
