using System;
using UnityEngine;

// Token: 0x020000FC RID: 252
public class SendToBossUi : MonoBehaviour
{
	// Token: 0x06000771 RID: 1905 RVA: 0x000262BC File Offset: 0x000244BC
	private void Awake()
	{
		Mob component = base.GetComponent<Mob>();
		if (this.forceUI)
		{
			BossUI.Instance.SetBoss(component);
		}
	}

	// Token: 0x040006F9 RID: 1785
	public bool forceUI;
}
