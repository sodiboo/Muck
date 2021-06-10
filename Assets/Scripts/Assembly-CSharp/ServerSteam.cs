
using Steamworks;
using TMPro;
using UnityEngine;

// Token: 0x020000D6 RID: 214
public class ServerSteam : MonoBehaviour
{
	// Token: 0x0600065B RID: 1627 RVA: 0x0000276E File Offset: 0x0000096E
	public void HostServer()
	{
	}

	// Token: 0x0600065C RID: 1628 RVA: 0x000201EC File Offset: 0x0001E3EC
	public void ConnectToServer()
	{
		if (this.steamIdField.text == "")
		{
			return;
		}
		LocalClient.instance.name = SteamClient.Name;
		MonoBehaviour.print("sending join lobby request to server");
		ClientSend.JoinLobby();
		this.HideCamera();
	}

	// Token: 0x0600065D RID: 1629 RVA: 0x00020254 File Offset: 0x0001E454
	public void HideCamera()
	{
		this.lobbyCamera.SetActive(false);
	}

	// Token: 0x040005D5 RID: 1493
	public TMP_InputField steamIdField;

	// Token: 0x040005D6 RID: 1494
	public GameObject lobbyCamera;
}
