using System;
using TMPro;
using UnityEngine;

public class PlayerLoading : MonoBehaviour
{
	public void SetStatus(string name, string status)
	{
		this.name.text = name;
		this.status.text = status;
	}

	public void ChangeStatus(string status)
	{
		this.status.text = status;
	}

	public new TextMeshProUGUI name;

	public TextMeshProUGUI status;
}
