using System;
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x0200004C RID: 76
public class JoinLobbyBtn : MonoBehaviour
{
	// Token: 0x06000195 RID: 405 RVA: 0x0000E450 File Offset: 0x0000C650
	public void JoinLobby()
	{
		ulong value;
		if (ulong.TryParse(this.inputField.text, out value))
		{
			Lobby lobby = new Lobby(value);
			SteamManager.Instance.JoinLobby(lobby);
			return;
		}
		StatusMessage.Instance.DisplayMessage("Couldn't find lobby. Make sure it's a valid lobbyID from someone");
	}

	// Token: 0x040001A6 RID: 422
	public TMP_InputField inputField;
}
