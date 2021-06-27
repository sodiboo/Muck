using System;
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x02000059 RID: 89
public class JoinLobbyBtn : MonoBehaviour
{
	// Token: 0x06000200 RID: 512 RVA: 0x0000C558 File Offset: 0x0000A758
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

	// Token: 0x04000218 RID: 536
	public TMP_InputField inputField;
}
