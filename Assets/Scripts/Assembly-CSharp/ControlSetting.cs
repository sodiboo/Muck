
using TMPro;
using UnityEngine;

// Token: 0x02000013 RID: 19
public class ControlSetting : Setting
{
	// Token: 0x06000066 RID: 102 RVA: 0x00004386 File Offset: 0x00002586
	public void SetSetting(KeyCode k, string actionName)
	{
		this.currentKey = k;
		MonoBehaviour.print("key: " + k);
		this.actionName = actionName;
		this.UpdateSetting();
	}

	// Token: 0x06000067 RID: 103 RVA: 0x000043B1 File Offset: 0x000025B1
	private void UpdateSetting()
	{
		this.keyText.text = (this.currentKey.ToString() ?? "");
	}

	// Token: 0x06000068 RID: 104 RVA: 0x000043D8 File Offset: 0x000025D8
	public void SetKey(KeyCode k)
	{
		this.currentKey = k;
		base.onClick.Invoke();
		this.UpdateSetting();
	}

	// Token: 0x06000069 RID: 105 RVA: 0x000043F2 File Offset: 0x000025F2
	public void StartListening()
	{
		KeyListener.Instance.ListenForKey(this, this.actionName);
	}

	// Token: 0x04000063 RID: 99
	public TextMeshProUGUI keyText;

	// Token: 0x04000064 RID: 100
	public KeyCode currentKey;

	// Token: 0x04000065 RID: 101
	private string actionName;
}
