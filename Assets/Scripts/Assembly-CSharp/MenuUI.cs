using System;
using TMPro;
using UnityEngine;

// Token: 0x02000064 RID: 100
public class MenuUI : MonoBehaviour
{
	// Token: 0x06000239 RID: 569 RVA: 0x0000D3FF File Offset: 0x0000B5FF
	private void Start()
	{
		this.lobbyUi.SetActive(false);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		PPController.Instance.Reset();
		this.version.text = "Version" + Application.version;
	}

	// Token: 0x0600023A RID: 570 RVA: 0x0000D43D File Offset: 0x0000B63D
	public void StartLobby()
	{
		SteamManager.Instance.StartLobby();
	}

	// Token: 0x0600023B RID: 571 RVA: 0x0000D449 File Offset: 0x0000B649
	public void JoinLobby()
	{
		this.lobbyUi.SetActive(true);
		this.mainUi.SetActive(false);
		this.menuCam.Lobby();
	}

	// Token: 0x0600023C RID: 572 RVA: 0x0000D46E File Offset: 0x0000B66E
	public void LeaveLobby()
	{
		this.lobbyUi.SetActive(false);
		this.mainUi.SetActive(true);
		this.menuCam.Menu();
	}

	// Token: 0x0600023D RID: 573 RVA: 0x0000D493 File Offset: 0x0000B693
	public void LeaveGame()
	{
		SteamManager.Instance.leaveLobby();
		this.startBtn.SetActive(false);
	}

	// Token: 0x0600023E RID: 574 RVA: 0x0000D4AB File Offset: 0x0000B6AB
	public void StartGame()
	{
		SteamLobby.Instance.StartGame();
	}

	// Token: 0x04000256 RID: 598
	public GameObject startBtn;

	// Token: 0x04000257 RID: 599
	public GameObject lobbyUi;

	// Token: 0x04000258 RID: 600
	public GameObject mainUi;

	// Token: 0x04000259 RID: 601
	public TextMeshProUGUI version;

	// Token: 0x0400025A RID: 602
	public MenuCamera menuCam;
}
