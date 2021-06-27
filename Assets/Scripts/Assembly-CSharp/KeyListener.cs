using System;
using TMPro;
using UnityEngine;

// Token: 0x0200005A RID: 90
public class KeyListener : MonoBehaviour
{
	// Token: 0x06000202 RID: 514 RVA: 0x0000C5A1 File Offset: 0x0000A7A1
	private void Awake()
	{
		KeyListener.Instance = this;
		this.overlay.SetActive(false);
	}

	// Token: 0x06000203 RID: 515 RVA: 0x0000C5B5 File Offset: 0x0000A7B5
	public void ListenForKey(ControlSetting listener, string actionName)
	{
		this.alertText.text = "Press any key for\n\"" + actionName + "\"\n\n<i><size=60%>...escape to go back";
		this.currentlyChanging = listener;
		this.overlay.SetActive(true);
	}

	// Token: 0x06000204 RID: 516 RVA: 0x0000C5E8 File Offset: 0x0000A7E8
	private void Update()
	{
		if (!this.overlay.activeInHierarchy)
		{
			return;
		}
		MonoBehaviour.print("listenign");
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.CloseListener();
			return;
		}
		foreach (object obj in Enum.GetValues(typeof(KeyCode)))
		{
			KeyCode key = (KeyCode)obj;
			if (Input.GetKey(key))
			{
				this.currentlyChanging.SetKey(key);
				this.CloseListener();
				break;
			}
		}
	}

	// Token: 0x06000205 RID: 517 RVA: 0x0000C688 File Offset: 0x0000A888
	private void CloseListener()
	{
		this.overlay.SetActive(false);
		this.currentlyChanging = null;
		UiSfx.Instance.PlayClick();
	}

	// Token: 0x04000219 RID: 537
	public ControlSetting currentlyChanging;

	// Token: 0x0400021A RID: 538
	public TextMeshProUGUI alertText;

	// Token: 0x0400021B RID: 539
	public GameObject overlay;

	// Token: 0x0400021C RID: 540
	public static KeyListener Instance;
}
