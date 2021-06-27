using System;
using UnityEngine;
using UnityEngine.UI;

public class EscapeUI : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.backBtn.onClick.Invoke();
			UiSfx.Instance.PlayClick();
		}
	}

	public Button backBtn;
}
