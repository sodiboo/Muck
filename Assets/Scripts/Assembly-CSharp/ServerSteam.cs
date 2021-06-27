using System;
using Steamworks;
using TMPro;
using UnityEngine;

// Token: 0x020000FE RID: 254
public class ServerSteam : MonoBehaviour
{
	// Token: 0x06000775 RID: 1909 RVA: 0x000030D7 File Offset: 0x000012D7
	public void HostServer()
	{
	}

	// Token: 0x06000776 RID: 1910 RVA: 0x000262EC File Offset: 0x000244EC
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

	// Token: 0x06000777 RID: 1911 RVA: 0x00026354 File Offset: 0x00024554
	public void HideCamera()
	{
		this.lobbyCamera.SetActive(false);
	}

	// Token: 0x040006FC RID: 1788
	public TMP_InputField steamIdField;

	// Token: 0x040006FD RID: 1789
	public GameObject lobbyCamera;
}
