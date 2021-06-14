using System;
using TMPro;
using UnityEngine;

// Token: 0x02000056 RID: 86
public class MenuUI : MonoBehaviour
{
	// Token: 0x060001C4 RID: 452 RVA: 0x000034CE File Offset: 0x000016CE
	private void Start()
	{
		this.lobbyUi.SetActive(false);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		PPController.Instance.Reset();
		this.version.text = "Version" + Application.version;
	}

	// Token: 0x060001C5 RID: 453 RVA: 0x0000350C File Offset: 0x0000170C
	public void StartLobby()
	{
		SteamManager.Instance.StartLobby();
	}

	// Token: 0x060001C6 RID: 454 RVA: 0x00003518 File Offset: 0x00001718
	public void JoinLobby()
	{
		this.lobbyUi.SetActive(true);
		this.mainUi.SetActive(false);
		this.menuCam.Lobby();
	}

	// Token: 0x060001C7 RID: 455 RVA: 0x0000353D File Offset: 0x0000173D
	public void LeaveLobby()
	{
		this.lobbyUi.SetActive(false);
		this.mainUi.SetActive(true);
		this.menuCam.Menu();
	}

	// Token: 0x060001C8 RID: 456 RVA: 0x00003562 File Offset: 0x00001762
	public void LeaveGame()
	{
		SteamManager.Instance.leaveLobby();
		this.startBtn.SetActive(false);
	}

	// Token: 0x060001C9 RID: 457 RVA: 0x0000357A File Offset: 0x0000177A
	public void StartGame()
	{
		SteamLobby.Instance.StartGame();
	}

	// Token: 0x040001D9 RID: 473
	public GameObject startBtn;

	// Token: 0x040001DA RID: 474
	public GameObject lobbyUi;

	// Token: 0x040001DB RID: 475
	public GameObject mainUi;

	// Token: 0x040001DC RID: 476
	public TextMeshProUGUI version;

	// Token: 0x040001DD RID: 477
	public MenuCamera menuCam;
}
