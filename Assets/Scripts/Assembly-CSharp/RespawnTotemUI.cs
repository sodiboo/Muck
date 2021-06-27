using System;
using TMPro;
using UnityEngine;

public class RespawnTotemUI : MonoBehaviour
{
	public bool active { get; set; }

	private void Awake()
	{
		RespawnTotemUI.Instance = this;
	}

	public void Show()
	{
		this.root.SetActive(true);
		this.respawnPrice.text = string.Concat(this.GetRevivePrice());
		this.Refresh();
		this.active = true;
		Cursor.lockState = CursorLockMode.None;
		Cursor.visible = true;
	}

	public void Hide()
	{
		this.root.SetActive(false);
		this.active = false;
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	public void RequestRevive(int playerId)
	{
		Debug.LogError("trying");
		if (InventoryUI.Instance.GetMoney() < this.GetRevivePrice())
		{
			return;
		}
		PlayerManager playerManager = GameManager.players[playerId];
		if (playerManager == null || playerManager.disconnected || !playerManager.dead)
		{
			return;
		}
		Debug.LogError("sendinging revie");
		ClientSend.RevivePlayer(playerId, -1, false);
	}

	public int GetRevivePrice()
	{
		GameSettings gameSettings = GameManager.gameSettings;
		float num = 1f;
		if (gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			num = 1.2f;
		}
		else if (gameSettings.difficulty == GameSettings.Difficulty.Easy)
		{
			num = 0.8f;
		}
		float num2 = 5f;
		float min = num;
		float num3 = num * (1f + (float)(GameManager.instance.currentDay - 2) / num2);
		num3 = Mathf.Clamp(num3, min, 100f);
		return (int)((float)this.basePrice * num3);
	}

	public void Refresh()
	{
		for (int i = this.nameContainer.childCount - 1; i >= 0; i--)
		{
			Destroy(this.nameContainer.GetChild(i).gameObject);
		}
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (!(playerManager == null) && !(playerManager == null) && !playerManager.disconnected && playerManager.dead)
			{
				Instantiate<GameObject>(this.namePrefab, this.nameContainer).GetComponent<RespawnPrefab>().Set(playerManager.id, InventoryUI.Instance.GetMoney() >= this.GetRevivePrice(), playerManager.username);
			}
		}
	}

	public GameObject namePrefab;

	public Transform nameContainer;

	public GameObject root;

	public TextMeshProUGUI respawnPrice;

	public int basePrice = 50;

	public static RespawnTotemUI Instance;
}
