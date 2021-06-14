using System;
using TMPro;
using UnityEngine;

// Token: 0x02000138 RID: 312
public class StatusMessage : MonoBehaviour
{
	// Token: 0x0600077D RID: 1917 RVA: 0x00006ECF File Offset: 0x000050CF
	private void Awake()
	{
		StatusMessage.Instance = this;
		this.defaultScale = this.status.transform.localScale;
	}

	// Token: 0x0600077E RID: 1918 RVA: 0x00006EED File Offset: 0x000050ED
	private void Update()
	{
		this.status.transform.localScale = Vector3.Lerp(this.status.transform.localScale, this.defaultScale, Time.deltaTime * 25f);
	}

	// Token: 0x0600077F RID: 1919 RVA: 0x00006F25 File Offset: 0x00005125
	public void DisplayMessage(string message)
	{
		this.status.transform.parent.gameObject.SetActive(true);
		this.status.transform.localScale = Vector3.zero;
		this.statusText.text = message;
	}

	// Token: 0x06000780 RID: 1920 RVA: 0x00006F63 File Offset: 0x00005163
	public void OkayDokay()
	{
		this.status.transform.parent.gameObject.SetActive(false);
	}

	// Token: 0x040007BB RID: 1979
	public TextMeshProUGUI statusText;

	// Token: 0x040007BC RID: 1980
	public GameObject status;

	// Token: 0x040007BD RID: 1981
	private Vector3 defaultScale;

	// Token: 0x040007BE RID: 1982
	public static StatusMessage Instance;
}
