using System;
using TMPro;
using UnityEngine;

public class GravePing : MonoBehaviour
{
	private void Awake()
	{
		this.child = base.transform.GetChild(0).gameObject;
		this.grave = base.transform.root.GetComponentInChildren<GraveInteract>();
	}

	public void SetPing(string name)
	{
		this.pingText.text = string.Format("Revive {0} ({1}", this.grave.username, this.grave.timeLeft);
	}

	private void Update()
	{
		if (DayCycle.time <= 0.5f)
		{
			this.child.SetActive(true);
			string str = "";
			if (this.grave.timeLeft > 0f)
			{
				str = string.Format("({0})", (int)this.grave.timeLeft);
			}
			this.pingText.text = "Revive " + this.grave.username + " " + str;
			float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
			if (num < 5f)
			{
				num = 0f;
			}
			if (num > 5000f)
			{
				num = 5000f;
			}
			base.transform.localScale = this.defaultScale * num * Vector3.one;
			return;
		}
		this.child.SetActive(false);
	}

	public TextMeshProUGUI pingText;

	private float defaultScale = 0.4f;

	private GraveInteract grave;

	private GameObject child;
}
