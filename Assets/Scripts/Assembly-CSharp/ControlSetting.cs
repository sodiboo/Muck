using System;
using TMPro;
using UnityEngine;

// Token: 0x02000016 RID: 22
public class ControlSetting : Setting
{
	// Token: 0x0600006D RID: 109 RVA: 0x0000245C File Offset: 0x0000065C
	public void SetSetting(KeyCode k, string actionName)
	{
		this.currentKey = k;
		MonoBehaviour.print("key: " + k);
		this.actionName = actionName;
		this.UpdateSetting();
	}

	// Token: 0x0600006E RID: 110 RVA: 0x00002487 File Offset: 0x00000687
	private void UpdateSetting()
	{
		this.keyText.text = (this.currentKey.ToString() ?? "");
	}

	// Token: 0x0600006F RID: 111 RVA: 0x000024AE File Offset: 0x000006AE
	public void SetKey(KeyCode k)
	{
		this.currentKey = k;
		base.onClick.Invoke();
		this.UpdateSetting();
	}

	// Token: 0x06000070 RID: 112 RVA: 0x000024C8 File Offset: 0x000006C8
	public void StartListening()
	{
		KeyListener.Instance.ListenForKey(this, this.actionName);
	}

	// Token: 0x04000071 RID: 113
	public TextMeshProUGUI keyText;

	// Token: 0x04000072 RID: 114
	public KeyCode currentKey;

	// Token: 0x04000073 RID: 115
	private string actionName;
}
