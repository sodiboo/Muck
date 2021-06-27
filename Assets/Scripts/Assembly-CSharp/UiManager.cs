using System;
using System.Net;
using System.Net.Sockets;
using TMPro;
using UnityEngine;

public class UiManager : MonoBehaviour
{
	private void Awake()
	{
		if (UiManager.instance == null)
		{
			UiManager.instance = this;
			return;
		}
		if (UiManager.instance != this)
		{
			Debug.Log("Instance already exists, destroying object");
			Destroy(this);
		}
	}

	private void Start()
	{
	}

	public void Host()
	{
		int port = int.Parse(this.portField.text);
		LocalClient.instance.port = port;
		NetworkManager.instance.StartServer(port);
		Server.ipAddress = IPAddress.Any;
		MonoBehaviour.print(string.Concat(new object[]
		{
			"hosting server on: ",
			Server.ipAddress,
			" on port: ",
			this.portField.text
		}));
		this.ConnectTest();
	}

	public void ConnectTest()
	{
		foreach (IPAddress ipaddress in Dns.GetHostEntry(Dns.GetHostName()).AddressList)
		{
			if (ipaddress.AddressFamily == AddressFamily.InterNetwork)
			{
				MonoBehaviour.print("ip: " + ipaddress.ToString());
				LocalClient.instance.ConnectToServer(ipaddress.ToString(), "bread");
				this.lobbyCam.SetActive(false);
				return;
			}
		}
		throw new Exception("No network adapters with an IPv4 address in the system!");
	}

	public void ConnectToServer()
	{
		LocalClient.serverOwner = false;
		LocalClient.instance.port = int.Parse(this.portField.text);
		LocalClient.instance.ConnectToServer(this.ipField.text, "bread");
		MonoBehaviour.print("connecting to ip:" + this.ipField.text);
		this.lobbyCam.SetActive(false);
		try
		{
			Color black = Color.black;
		}
		catch (Exception message)
		{
			MonoBehaviour.print(message);
		}
	}

	public void ConnectionSuccessful()
	{
		this.startMenu.SetActive(false);
	}

	public static UiManager instance;

	public GameObject lobbyCam;

	public GameObject startMenu;

	public TMP_InputField usernameField;

	public TMP_InputField ipField;

	public TMP_InputField portField;

	public GameObject server;
}
