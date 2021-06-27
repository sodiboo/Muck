using System;
using TMPro;
using UnityEngine;

// Token: 0x02000072 RID: 114
public class ObjectivePing : MonoBehaviour
{
	// Token: 0x06000285 RID: 645 RVA: 0x0000E56D File Offset: 0x0000C76D
	private void Awake()
	{
		base.transform.parent = null;
	}

	// Token: 0x06000286 RID: 646 RVA: 0x0000E57B File Offset: 0x0000C77B
	public void SetText(string s)
	{
		this.text.text = s;
	}

	// Token: 0x06000287 RID: 647 RVA: 0x0000E58C File Offset: 0x0000C78C
	private void Update()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
		if (num < 5f)
		{
			num = 0f;
		}
		if (num > 5000f)
		{
			num = 5000f;
		}
		base.transform.localScale = this.defaultScale * num * Vector3.one;
	}

	// Token: 0x0400029D RID: 669
	public TextMeshProUGUI text;

	// Token: 0x0400029E RID: 670
	private float defaultScale = 0.4f;
}
