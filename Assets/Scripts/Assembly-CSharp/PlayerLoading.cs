using System;
using TMPro;
using UnityEngine;

// Token: 0x02000069 RID: 105
public class PlayerLoading : MonoBehaviour
{
	// Token: 0x06000220 RID: 544 RVA: 0x00003A4C File Offset: 0x00001C4C
	public void SetStatus(string name, string status)
	{
		this.name.text = name;
		this.status.text = status;
	}

	// Token: 0x06000221 RID: 545 RVA: 0x00003A66 File Offset: 0x00001C66
	public void ChangeStatus(string status)
	{
		this.status.text = status;
	}

	// Token: 0x04000241 RID: 577
	public new TextMeshProUGUI name;

	// Token: 0x04000242 RID: 578
	public TextMeshProUGUI status;
}
