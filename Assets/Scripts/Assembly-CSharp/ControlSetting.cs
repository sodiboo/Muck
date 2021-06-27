using System;
using TMPro;
using UnityEngine;

// Token: 0x0200001A RID: 26
public class ControlSetting : Setting
{
	// Token: 0x0600009D RID: 157 RVA: 0x000050F1 File Offset: 0x000032F1
	public void SetSetting(KeyCode k, string actionName)
	{
		this.currentKey = k;
		MonoBehaviour.print("key: " + k);
		this.actionName = actionName;
		this.UpdateSetting();
	}

	// Token: 0x0600009E RID: 158 RVA: 0x0000511C File Offset: 0x0000331C
	private void UpdateSetting()
	{
		this.keyText.text = (this.currentKey.ToString() ?? "");
	}

	// Token: 0x0600009F RID: 159 RVA: 0x00005143 File Offset: 0x00003343
	public void SetKey(KeyCode k)
	{
		this.currentKey = k;
		base.onClick.Invoke();
		this.UpdateSetting();
	}

	// Token: 0x060000A0 RID: 160 RVA: 0x0000515D File Offset: 0x0000335D
	public void StartListening()
	{
		KeyListener.Instance.ListenForKey(this, this.actionName);
	}

	// Token: 0x040000A5 RID: 165
	public TextMeshProUGUI keyText;

	// Token: 0x040000A6 RID: 166
	public KeyCode currentKey;

	// Token: 0x040000A7 RID: 167
	private string actionName;
}
