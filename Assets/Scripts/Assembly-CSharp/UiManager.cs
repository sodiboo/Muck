using System;
using System.Net;
using System.Net.Sockets;
using TMPro;
using UnityEngine;

// Token: 0x0200009A RID: 154
public class UiManager : MonoBehaviour
{
	// Token: 0x0600049C RID: 1180 RVA: 0x000173A0 File Offset: 0x000155A0
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

	// Token: 0x0600049D RID: 1181 RVA: 0x0000276E File Offset: 0x0000096E
	private void Start()
	{
	}

	// Token: 0x0600049E RID: 1182 RVA: 0x000173D4 File Offset: 0x000155D4
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

	// Token: 0x0600049F RID: 1183 RVA: 0x00017450 File Offset: 0x00015650
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

	// Token: 0x060004A0 RID: 1184 RVA: 0x000174CC File Offset: 0x000156CC
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

	// Token: 0x060004A1 RID: 1185 RVA: 0x00017558 File Offset: 0x00015758
	public void ConnectionSuccessful()
	{
		this.startMenu.SetActive(false);
	}

	// Token: 0x040003ED RID: 1005
	public static UiManager instance;

	// Token: 0x040003EE RID: 1006
	public GameObject lobbyCam;

	// Token: 0x040003EF RID: 1007
	public GameObject startMenu;

	// Token: 0x040003F0 RID: 1008
	public TMP_InputField usernameField;

	// Token: 0x040003F1 RID: 1009
	public TMP_InputField ipField;

	// Token: 0x040003F2 RID: 1010
	public TMP_InputField portField;

	// Token: 0x040003F3 RID: 1011
	public GameObject server;
}
