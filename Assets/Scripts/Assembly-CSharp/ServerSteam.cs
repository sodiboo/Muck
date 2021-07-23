using Steamworks;
using TMPro;
using UnityEngine;

public class ServerSteam : MonoBehaviour
{
    public TMP_InputField steamIdField;

    public GameObject lobbyCamera;

    public void HostServer()
    {
    }

    public void ConnectToServer()
    {
        if (!(steamIdField.text == ""))
        {
            LocalClient.instance.name = SteamClient.Name;
            SteamId steamId = default(SteamId);
            steamId.Value = ulong.Parse(steamIdField.text);
            MonoBehaviour.print("sending join lobby request to server");
            ClientSend.JoinLobby();
            HideCamera();
        }
    }

    public void HideCamera()
    {
        lobbyCamera.SetActive(value: false);
    }
}
