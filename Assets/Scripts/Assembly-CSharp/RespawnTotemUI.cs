using System;
using TMPro;
using UnityEngine;

// Token: 0x0200008A RID: 138
public class RespawnTotemUI : MonoBehaviour
{
	// Token: 0x17000029 RID: 41
	// (get) Token: 0x06000352 RID: 850 RVA: 0x00012108 File Offset: 0x00010308
	// (set) Token: 0x06000353 RID: 851 RVA: 0x00012110 File Offset: 0x00010310
	public bool active { get; set; }

	// Token: 0x06000354 RID: 852 RVA: 0x00012119 File Offset: 0x00010319
	private void Awake()
	{
		RespawnTotemUI.Instance = this;
	}

	// Token: 0x06000355 RID: 853 RVA: 0x00012124 File Offset: 0x00010324
	public void Show()
	{
		this.root.SetActive(true);
		this.respawnPrice.text = string.Concat(this.GetRevivePrice());
		this.Refresh();
		this.active = true;
		Cursor.lockState = CursorLockMode.None;
		Cursor.visible = true;
	}

	// Token: 0x06000356 RID: 854 RVA: 0x00012171 File Offset: 0x00010371
	public void Hide()
	{
		this.root.SetActive(false);
		this.active = false;
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x06000357 RID: 855 RVA: 0x00012194 File Offset: 0x00010394
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

	// Token: 0x06000358 RID: 856 RVA: 0x000121F8 File Offset: 0x000103F8
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

	// Token: 0x06000359 RID: 857 RVA: 0x0001226C File Offset: 0x0001046C
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

	// Token: 0x04000355 RID: 853
	public GameObject namePrefab;

	// Token: 0x04000356 RID: 854
	public Transform nameContainer;

	// Token: 0x04000357 RID: 855
	public GameObject root;

	// Token: 0x04000359 RID: 857
	public TextMeshProUGUI respawnPrice;

	// Token: 0x0400035A RID: 858
	public int basePrice = 50;

	// Token: 0x0400035B RID: 859
	public static RespawnTotemUI Instance;
}
