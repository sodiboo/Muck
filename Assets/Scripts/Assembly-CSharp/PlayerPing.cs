using System;
using TMPro;
using UnityEngine;

public class PlayerPing : MonoBehaviour
{
	private void Awake()
	{
		this.desiredScale = 1f;
		base.transform.localScale = Vector3.zero;
		Invoke(nameof(HidePing), 5f);
	}

	public void SetPing(string username, string item)
	{
		this.pingText.text = username + "\n<size=75>" + item;
	}

	private void Update()
	{
		this.localScale = Mathf.Lerp(this.localScale, this.desiredScale, Time.deltaTime * 10f);
		float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
		if (num < 7f)
		{
			num = 7f;
		}
		if (num > 100f)
		{
			num = 100f;
		}
		base.transform.localScale = this.localScale * num * Vector3.one;
	}

	private void HidePing()
	{
		this.desiredScale = 0f;
	}

	private float desiredScale;

	private float localScale;

	public TextMeshProUGUI pingText;
}
