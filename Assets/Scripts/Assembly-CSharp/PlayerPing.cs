
using TMPro;
using UnityEngine;

// Token: 0x02000059 RID: 89
public class PlayerPing : MonoBehaviour
{
	// Token: 0x060001F6 RID: 502 RVA: 0x0000B4BD File Offset: 0x000096BD
	private void Awake()
	{
		this.desiredScale = 1f;
		base.transform.localScale = Vector3.zero;
		base.Invoke("HidePing", 5f);
	}

	// Token: 0x060001F7 RID: 503 RVA: 0x0000B4EA File Offset: 0x000096EA
	public void SetPing(string username, string item)
	{
		this.pingText.text = username + "\n<size=75>" + item;
	}

	// Token: 0x060001F8 RID: 504 RVA: 0x0000B504 File Offset: 0x00009704
	private void Update()
	{
		this.localScale = Mathf.Lerp(this.localScale, this.desiredScale, Time.deltaTime * 10f);
		float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
		if (num < 7f)
		{
			num = 7f;
		}
		if (num > 100f)
		{
			num = 100f;
		}
		base.transform.localScale = this.localScale * num * Vector3.one;
	}

	// Token: 0x060001F9 RID: 505 RVA: 0x0000B58C File Offset: 0x0000978C
	private void HidePing()
	{
		this.desiredScale = 0f;
	}

	// Token: 0x040001F7 RID: 503
	private float desiredScale;

	// Token: 0x040001F8 RID: 504
	private float localScale;

	// Token: 0x040001F9 RID: 505
	public TextMeshProUGUI pingText;
}
