using System;
using Steamworks;
using TMPro;
using UnityEngine;

public class ServerSteam : MonoBehaviour
{
	public void HostServer()
	{
	}

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

	public void HideCamera()
	{
		this.lobbyCamera.SetActive(false);
	}

	public TMP_InputField steamIdField;

	public GameObject lobbyCamera;
}
