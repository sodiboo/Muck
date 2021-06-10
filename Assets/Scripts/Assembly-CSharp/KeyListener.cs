using System;
using TMPro;
using UnityEngine;

// Token: 0x02000040 RID: 64
public class KeyListener : MonoBehaviour
{
	// Token: 0x06000170 RID: 368 RVA: 0x000099B5 File Offset: 0x00007BB5
	private void Awake()
	{
		KeyListener.Instance = this;
		this.overlay.SetActive(false);
	}

	// Token: 0x06000171 RID: 369 RVA: 0x000099C9 File Offset: 0x00007BC9
	public void ListenForKey(ControlSetting listener, string actionName)
	{
		this.alertText.text = "Press any key for\n\"" + actionName + "\"\n\n<i><size=60%>...escape to go back";
		this.currentlyChanging = listener;
		this.overlay.SetActive(true);
	}

	// Token: 0x06000172 RID: 370 RVA: 0x000099FC File Offset: 0x00007BFC
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

	// Token: 0x06000173 RID: 371 RVA: 0x00009A9C File Offset: 0x00007C9C
	private void CloseListener()
	{
		this.overlay.SetActive(false);
		this.currentlyChanging = null;
		UiSfx.Instance.PlayClick();
	}

	// Token: 0x04000172 RID: 370
	public ControlSetting currentlyChanging;

	// Token: 0x04000173 RID: 371
	public TextMeshProUGUI alertText;

	// Token: 0x04000174 RID: 372
	public GameObject overlay;

	// Token: 0x04000175 RID: 373
	public static KeyListener Instance;
}
