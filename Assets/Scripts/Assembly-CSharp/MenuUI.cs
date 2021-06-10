
using TMPro;
using UnityEngine;

// Token: 0x02000048 RID: 72
public class MenuUI : MonoBehaviour
{
	// Token: 0x0600019B RID: 411 RVA: 0x0000A2A7 File Offset: 0x000084A7
	private void Start()
	{
		this.lobbyUi.SetActive(false);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		PPController.Instance.Reset();
		this.version.text = "Version" + Application.version;
	}

	// Token: 0x0600019C RID: 412 RVA: 0x0000A2E5 File Offset: 0x000084E5
	public void StartLobby()
	{
		SteamManager.Instance.StartLobby();
	}

	// Token: 0x0600019D RID: 413 RVA: 0x0000A2F1 File Offset: 0x000084F1
	public void JoinLobby()
	{
		this.lobbyUi.SetActive(true);
		this.mainUi.SetActive(false);
		this.menuCam.Lobby();
	}

	// Token: 0x0600019E RID: 414 RVA: 0x0000A316 File Offset: 0x00008516
	public void LeaveLobby()
	{
		this.lobbyUi.SetActive(false);
		this.mainUi.SetActive(true);
		this.menuCam.Menu();
	}

	// Token: 0x0600019F RID: 415 RVA: 0x0000A33B File Offset: 0x0000853B
	public void LeaveGame()
	{
		SteamManager.Instance.leaveLobby();
		this.startBtn.SetActive(false);
	}

	// Token: 0x060001A0 RID: 416 RVA: 0x0000A353 File Offset: 0x00008553
	public void StartGame()
	{
		SteamLobby.Instance.StartGame();
	}

	// Token: 0x0400019D RID: 413
	public GameObject startBtn;

	// Token: 0x0400019E RID: 414
	public GameObject lobbyUi;

	// Token: 0x0400019F RID: 415
	public GameObject mainUi;

	// Token: 0x040001A0 RID: 416
	public TextMeshProUGUI version;

	// Token: 0x040001A1 RID: 417
	public MenuCamera menuCam;
}
