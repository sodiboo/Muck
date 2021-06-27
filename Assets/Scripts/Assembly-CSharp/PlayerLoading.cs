using System;
using TMPro;
using UnityEngine;

// Token: 0x02000078 RID: 120
public class PlayerLoading : MonoBehaviour
{
	// Token: 0x060002AB RID: 683 RVA: 0x0000EF14 File Offset: 0x0000D114
	public void SetStatus(string name, string status)
	{
		this.name.text = name;
		this.status.text = status;
	}

	// Token: 0x060002AC RID: 684 RVA: 0x0000EF2E File Offset: 0x0000D12E
	public void ChangeStatus(string status)
	{
		this.status.text = status;
	}

	// Token: 0x040002C0 RID: 704
	public new TextMeshProUGUI name;

	// Token: 0x040002C1 RID: 705
	public TextMeshProUGUI status;
}
