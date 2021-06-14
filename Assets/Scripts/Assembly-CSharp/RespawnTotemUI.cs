using System;
using TMPro;
using UnityEngine;

// Token: 0x0200007D RID: 125
public class RespawnTotemUI : MonoBehaviour
{
	// Token: 0x17000023 RID: 35
	// (get) Token: 0x060002B9 RID: 697 RVA: 0x00004016 File Offset: 0x00002216
	// (set) Token: 0x060002BA RID: 698 RVA: 0x0000401E File Offset: 0x0000221E
	public bool active { get; set; }

	// Token: 0x060002BB RID: 699 RVA: 0x00004027 File Offset: 0x00002227
	private void Awake()
	{
		RespawnTotemUI.Instance = this;
	}

	// Token: 0x060002BC RID: 700 RVA: 0x0001205C File Offset: 0x0001025C
	public void Show()
	{
		this.root.SetActive(true);
		this.respawnPrice.text = string.Concat(this.GetRevivePrice());
		this.Refresh();
		this.active = true;
		Cursor.lockState = CursorLockMode.None;
		Cursor.visible = true;
	}

	// Token: 0x060002BD RID: 701 RVA: 0x0000402F File Offset: 0x0000222F
	public void Hide()
	{
		this.root.SetActive(false);
		this.active = false;
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x060002BE RID: 702 RVA: 0x000120AC File Offset: 0x000102AC
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

	// Token: 0x060002BF RID: 703 RVA: 0x00012110 File Offset: 0x00010310
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

	// Token: 0x060002C0 RID: 704 RVA: 0x00012184 File Offset: 0x00010384
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

	// Token: 0x040002CD RID: 717
	public GameObject namePrefab;

	// Token: 0x040002CE RID: 718
	public Transform nameContainer;

	// Token: 0x040002CF RID: 719
	public GameObject root;

	// Token: 0x040002D1 RID: 721
	public TextMeshProUGUI respawnPrice;

	// Token: 0x040002D2 RID: 722
	public int basePrice = 50;

	// Token: 0x040002D3 RID: 723
	public static RespawnTotemUI Instance;
}
