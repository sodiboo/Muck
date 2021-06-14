using System;
using Steamworks;
using TMPro;
using UnityEngine;

// Token: 0x02000117 RID: 279
public class ServerSteam : MonoBehaviour
{
	// Token: 0x060006F7 RID: 1783 RVA: 0x00002147 File Offset: 0x00000347
	public void HostServer()
	{
	}

	// Token: 0x060006F8 RID: 1784 RVA: 0x00023998 File Offset: 0x00021B98
	public void ConnectToServer()
	{
		if (this.steamIdField.text == "")
		{
			return;
		}
		LocalClient.instance.name = SteamClient.Name;
// 		default(SteamId).Value = ulong.Parse(this.steamIdField.text);
		MonoBehaviour.print("sending join lobby request to server");
		ClientSend.JoinLobby();
		this.HideCamera();
	}

	// Token: 0x060006F9 RID: 1785 RVA: 0x000066B1 File Offset: 0x000048B1
	public void HideCamera()
	{
		this.lobbyCamera.SetActive(false);
	}

	// Token: 0x040006F3 RID: 1779
	public TMP_InputField steamIdField;

	// Token: 0x040006F4 RID: 1780
	public GameObject lobbyCamera;
}
