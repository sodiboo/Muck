using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

// Token: 0x020000FF RID: 255
public class Setting : MonoBehaviour
{
	// Token: 0x1700005A RID: 90
	// (get) Token: 0x06000779 RID: 1913 RVA: 0x00026362 File Offset: 0x00024562
	// (set) Token: 0x0600077A RID: 1914 RVA: 0x0002636A File Offset: 0x0002456A
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

	// Token: 0x040006FE RID: 1790
	public int currentSetting;

	// Token: 0x040006FF RID: 1791
	[FormerlySerializedAs("onClick")]
	[SerializeField]
	public Setting.ButtonClickedEvent m_OnClick = new Setting.ButtonClickedEvent();

	// Token: 0x02000175 RID: 373
	public class ButtonClickedEvent : UnityEvent
	{
	}
}
