using System;
using TMPro;
using UnityEngine;

// Token: 0x0200004D RID: 77
public class KeyListener : MonoBehaviour
{
	// Token: 0x06000197 RID: 407 RVA: 0x0000330C File Offset: 0x0000150C
	private void Awake()
	{
		KeyListener.Instance = this;
		this.overlay.SetActive(false);
	}

	// Token: 0x06000198 RID: 408 RVA: 0x00003320 File Offset: 0x00001520
	public void ListenForKey(ControlSetting listener, string actionName)
	{
		this.alertText.text = "Press any key for\n\"" + actionName + "\"\n\n<i><size=60%>...escape to go back";
		this.currentlyChanging = listener;
		this.overlay.SetActive(true);
	}

	// Token: 0x06000199 RID: 409 RVA: 0x0000E49C File Offset: 0x0000C69C
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

	// Token: 0x0600019A RID: 410 RVA: 0x00003350 File Offset: 0x00001550
	private void CloseListener()
	{
		this.overlay.SetActive(false);
		this.currentlyChanging = null;
		UiSfx.Instance.PlayClick();
	}

	// Token: 0x040001A7 RID: 423
	public ControlSetting currentlyChanging;

	// Token: 0x040001A8 RID: 424
	public TextMeshProUGUI alertText;

	// Token: 0x040001A9 RID: 425
	public GameObject overlay;

	// Token: 0x040001AA RID: 426
	public static KeyListener Instance;
}
