
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x0200003F RID: 63
public class JoinLobbyBtn : MonoBehaviour
{
	// Token: 0x0600016E RID: 366 RVA: 0x0000996C File Offset: 0x00007B6C
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

	// Token: 0x04000171 RID: 369
	public TMP_InputField inputField;
}
