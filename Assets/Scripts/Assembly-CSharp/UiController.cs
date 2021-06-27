using System;
using UnityEngine;

public class UiController : MonoBehaviour
{
	private void Awake()
	{
		UiController.Instance = this;
	}

	public void ToggleHud()
	{
		this.hudActive = !this.hudActive;
		this.canvas.enabled = this.hudActive;
	}

	public Canvas canvas;

	public static UiController Instance;

	private bool hudActive = true;
}
