using System;
using TMPro;
using UnityEngine;

// Token: 0x02000118 RID: 280
public class StatusMessage : MonoBehaviour
{
	// Token: 0x0600080C RID: 2060 RVA: 0x000288EB File Offset: 0x00026AEB
	private void Awake()
	{
		StatusMessage.Instance = this;
		this.defaultScale = this.status.transform.localScale;
	}

	// Token: 0x0600080D RID: 2061 RVA: 0x00028909 File Offset: 0x00026B09
	private void Update()
	{
		this.status.transform.localScale = Vector3.Lerp(this.status.transform.localScale, this.defaultScale, Time.deltaTime * 25f);
	}

	// Token: 0x0600080E RID: 2062 RVA: 0x00028941 File Offset: 0x00026B41
	public void DisplayMessage(string message)
	{
		this.status.transform.parent.gameObject.SetActive(true);
		this.status.transform.localScale = Vector3.zero;
		this.statusText.text = message;
	}

	// Token: 0x0600080F RID: 2063 RVA: 0x0002897F File Offset: 0x00026B7F
	public void OkayDokay()
	{
		this.status.transform.parent.gameObject.SetActive(false);
	}

	// Token: 0x040007AE RID: 1966
	public TextMeshProUGUI statusText;

	// Token: 0x040007AF RID: 1967
	public GameObject status;

	// Token: 0x040007B0 RID: 1968
	private Vector3 defaultScale;

	// Token: 0x040007B1 RID: 1969
	public static StatusMessage Instance;
}
