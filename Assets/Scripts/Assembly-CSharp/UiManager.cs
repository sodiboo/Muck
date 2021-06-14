using System;
using System.Net;
using System.Net.Sockets;
using TMPro;
using UnityEngine;

// Token: 0x020000C9 RID: 201
public class UiManager : MonoBehaviour
{
	// Token: 0x06000513 RID: 1299 RVA: 0x000055C6 File Offset: 0x000037C6
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

	// Token: 0x06000514 RID: 1300 RVA: 0x00002147 File Offset: 0x00000347
	private void Start()
	{
	}

	// Token: 0x06000515 RID: 1301 RVA: 0x0001B448 File Offset: 0x00019648
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

	// Token: 0x06000516 RID: 1302 RVA: 0x0001B4C4 File Offset: 0x000196C4
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

	// Token: 0x06000517 RID: 1303 RVA: 0x0001B540 File Offset: 0x00019740
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

	// Token: 0x06000518 RID: 1304 RVA: 0x000055F9 File Offset: 0x000037F9
	public void ConnectionSuccessful()
	{
		this.startMenu.SetActive(false);
	}

	// Token: 0x040004BE RID: 1214
	public static UiManager instance;

	// Token: 0x040004BF RID: 1215
	public GameObject lobbyCam;

	// Token: 0x040004C0 RID: 1216
	public GameObject startMenu;

	// Token: 0x040004C1 RID: 1217
	public TMP_InputField usernameField;

	// Token: 0x040004C2 RID: 1218
	public TMP_InputField ipField;

	// Token: 0x040004C3 RID: 1219
	public TMP_InputField portField;

	// Token: 0x040004C4 RID: 1220
	public GameObject server;
}
