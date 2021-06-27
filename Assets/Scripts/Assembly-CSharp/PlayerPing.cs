using System;
using TMPro;
using UnityEngine;

// Token: 0x02000079 RID: 121
public class PlayerPing : MonoBehaviour
{
	// Token: 0x060002AE RID: 686 RVA: 0x0000EF3C File Offset: 0x0000D13C
	private void Awake()
	{
		this.desiredScale = 1f;
		base.transform.localScale = Vector3.zero;
		Invoke(nameof(HidePing), 5f);
	}

	// Token: 0x060002AF RID: 687 RVA: 0x0000EF69 File Offset: 0x0000D169
	public void SetPing(string username, string item)
	{
		this.pingText.text = username + "\n<size=75>" + item;
	}

	// Token: 0x060002B0 RID: 688 RVA: 0x0000EF84 File Offset: 0x0000D184
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

	// Token: 0x060002B1 RID: 689 RVA: 0x0000F00C File Offset: 0x0000D20C
	private void HidePing()
	{
		this.desiredScale = 0f;
	}

	// Token: 0x040002C2 RID: 706
	private float desiredScale;

	// Token: 0x040002C3 RID: 707
	private float localScale;

	// Token: 0x040002C4 RID: 708
	public TextMeshProUGUI pingText;
}
