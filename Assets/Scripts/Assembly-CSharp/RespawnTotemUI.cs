
using TMPro;
using UnityEngine;

// Token: 0x02000068 RID: 104
public class RespawnTotemUI : MonoBehaviour
{
	// Token: 0x1700001F RID: 31
	// (get) Token: 0x06000284 RID: 644 RVA: 0x0000DDD0 File Offset: 0x0000BFD0
	// (set) Token: 0x06000285 RID: 645 RVA: 0x0000DDD8 File Offset: 0x0000BFD8
	public bool active { get; set; }

	// Token: 0x06000286 RID: 646 RVA: 0x0000DDE1 File Offset: 0x0000BFE1
	private void Awake()
	{
		RespawnTotemUI.Instance = this;
	}

	// Token: 0x06000287 RID: 647 RVA: 0x0000DDEC File Offset: 0x0000BFEC
	public void Show()
	{
		this.root.SetActive(true);
		this.respawnPrice.text = string.Concat(this.GetRevivePrice());
		this.Refresh();
		this.active = true;
		Cursor.lockState = CursorLockMode.None;
		Cursor.visible = true;
	}

	// Token: 0x06000288 RID: 648 RVA: 0x0000DE39 File Offset: 0x0000C039
	public void Hide()
	{
		this.root.SetActive(false);
		this.active = false;
		Cursor.lockState = CursorLockMode.Locked;
		Cursor.visible = false;
	}

	// Token: 0x06000289 RID: 649 RVA: 0x0000DE5C File Offset: 0x0000C05C
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

	// Token: 0x0600028A RID: 650 RVA: 0x0000DEC0 File Offset: 0x0000C0C0
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

	// Token: 0x0600028B RID: 651 RVA: 0x0000DF34 File Offset: 0x0000C134
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
			Instantiate(this.namePrefab, this.nameContainer).GetComponent<RespawnPrefab>().Set(playerManager.id, InventoryUI.Instance.GetMoney() >= this.GetRevivePrice(), playerManager.username);
			}
		}
	}

	// Token: 0x0400026F RID: 623
	public GameObject namePrefab;

	// Token: 0x04000270 RID: 624
	public Transform nameContainer;

	// Token: 0x04000271 RID: 625
	public GameObject root;

	// Token: 0x04000273 RID: 627
	public TextMeshProUGUI respawnPrice;

	// Token: 0x04000274 RID: 628
	public int basePrice = 25;

	// Token: 0x04000275 RID: 629
	public static RespawnTotemUI Instance;
}
