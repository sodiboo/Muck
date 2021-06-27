using System;
using TMPro;
using UnityEngine;

public class StatusMessage : MonoBehaviour
{
	private void Awake()
	{
		StatusMessage.Instance = this;
		this.defaultScale = this.status.transform.localScale;
	}

	private void Update()
	{
		this.status.transform.localScale = Vector3.Lerp(this.status.transform.localScale, this.defaultScale, Time.deltaTime * 25f);
	}

	public void DisplayMessage(string message)
	{
		this.status.transform.parent.gameObject.SetActive(true);
		this.status.transform.localScale = Vector3.zero;
		this.statusText.text = message;
	}

	public void OkayDokay()
	{
		this.status.transform.parent.gameObject.SetActive(false);
	}

	public TextMeshProUGUI statusText;

	public GameObject status;

	private Vector3 defaultScale;

	public static StatusMessage Instance;
}
