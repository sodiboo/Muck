
using TMPro;
using UnityEngine;

// Token: 0x02000058 RID: 88
public class PlayerLoading : MonoBehaviour
{
	// Token: 0x060001F3 RID: 499 RVA: 0x0000B495 File Offset: 0x00009695
	public void SetStatus(string name, string status)
	{
		this.name.text = name;
		this.status.text = status;
	}

	// Token: 0x060001F4 RID: 500 RVA: 0x0000B4AF File Offset: 0x000096AF
	public void ChangeStatus(string status)
	{
		this.status.text = status;
	}

	// Token: 0x040001F5 RID: 501
	public new TextMeshProUGUI name;

	// Token: 0x040001F6 RID: 502
	public TextMeshProUGUI status;
}
