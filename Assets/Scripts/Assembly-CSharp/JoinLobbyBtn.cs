using Steamworks.Data;
using TMPro;
using UnityEngine;

public class JoinLobbyBtn : MonoBehaviour
{
    public TMP_InputField inputField;

    public void JoinLobby()
    {
        if (ulong.TryParse(inputField.text, out var result))
        {
            Lobby lobby = new Lobby(result);
            SteamManager.Instance.JoinLobby(lobby);
        }
        else
        {
            StatusMessage.Instance.DisplayMessage("Couldn't find lobby. Make sure it's a valid lobbyID from someone");
        }
    }
}
