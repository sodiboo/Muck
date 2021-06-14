using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

// Token: 0x02000118 RID: 280
public class Setting : MonoBehaviour
{
	// Token: 0x17000053 RID: 83
	// (get) Token: 0x060006FB RID: 1787 RVA: 0x000066BF File Offset: 0x000048BF
	// (set) Token: 0x060006FC RID: 1788 RVA: 0x000066C7 File Offset: 0x000048C7
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

	// Token: 0x040006F5 RID: 1781
	public int currentSetting;

	// Token: 0x040006F6 RID: 1782
	[FormerlySerializedAs("onClick")]
	[SerializeField]
	public Setting.ButtonClickedEvent m_OnClick = new Setting.ButtonClickedEvent();

	// Token: 0x02000119 RID: 281
	public class ButtonClickedEvent : UnityEvent
	{
	}
}
