using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class RespawnPrefab : MonoBehaviour
{
	public int playerId { get; set; }

	public void Set(int id, bool active, string username)
	{
		this.playerId = id;
		this.overlay.gameObject.SetActive(!active);
		this.button.enabled = active;
		this.nameText.text = username;
	}

	public void RespawnPlayer()
	{
		Debug.LogError("requesting revive");
		RespawnTotemUI.Instance.RequestRevive(this.playerId);
	}

	public RawImage overlay;

	public Button button;

	public TextMeshProUGUI nameText;
}
