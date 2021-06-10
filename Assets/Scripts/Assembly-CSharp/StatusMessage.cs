
using TMPro;
using UnityEngine;

// Token: 0x020000E9 RID: 233
public class StatusMessage : MonoBehaviour
{
	// Token: 0x060006CA RID: 1738 RVA: 0x0002204B File Offset: 0x0002024B
	private void Awake()
	{
		StatusMessage.Instance = this;
		this.defaultScale = this.status.transform.localScale;
	}

	// Token: 0x060006CB RID: 1739 RVA: 0x00022069 File Offset: 0x00020269
	private void Update()
	{
		this.status.transform.localScale = Vector3.Lerp(this.status.transform.localScale, this.defaultScale, Time.deltaTime * 25f);
	}

	// Token: 0x060006CC RID: 1740 RVA: 0x000220A1 File Offset: 0x000202A1
	public void DisplayMessage(string message)
	{
		this.status.transform.parent.gameObject.SetActive(true);
		this.status.transform.localScale = Vector3.zero;
		this.statusText.text = message;
	}

	// Token: 0x060006CD RID: 1741 RVA: 0x000220DF File Offset: 0x000202DF
	public void OkayDokay()
	{
		this.status.transform.parent.gameObject.SetActive(false);
	}

	// Token: 0x04000669 RID: 1641
	public TextMeshProUGUI statusText;

	// Token: 0x0400066A RID: 1642
	public GameObject status;

	// Token: 0x0400066B RID: 1643
	private Vector3 defaultScale;

	// Token: 0x0400066C RID: 1644
	public static StatusMessage Instance;
}
