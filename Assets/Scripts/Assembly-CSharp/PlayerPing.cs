using System;
using TMPro;
using UnityEngine;

// Token: 0x0200006A RID: 106
public class PlayerPing : MonoBehaviour
{
	// Token: 0x06000223 RID: 547 RVA: 0x00003A74 File Offset: 0x00001C74
	private void Awake()
	{
		this.desiredScale = 1f;
		base.transform.localScale = Vector3.zero;
		base.Invoke(nameof(HidePing), 5f);
	}

	// Token: 0x06000224 RID: 548 RVA: 0x00003AA1 File Offset: 0x00001CA1
	public void SetPing(string username, string item)
	{
		this.pingText.text = username + "\n<size=75>" + item;
	}

	// Token: 0x06000225 RID: 549 RVA: 0x0000FA40 File Offset: 0x0000DC40
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

	// Token: 0x06000226 RID: 550 RVA: 0x00003ABA File Offset: 0x00001CBA
	private void HidePing()
	{
		this.desiredScale = 0f;
	}

	// Token: 0x04000243 RID: 579
	private float desiredScale;

	// Token: 0x04000244 RID: 580
	private float localScale;

	// Token: 0x04000245 RID: 581
	public TextMeshProUGUI pingText;
}
