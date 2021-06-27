using System;
using Steamworks.Data;
using TMPro;
using UnityEngine;

public class JoinLobbyBtn : MonoBehaviour
{
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

	public TMP_InputField inputField;
}
