using System;
using System.Net;
using System.Net.Sockets;
using TMPro;
using UnityEngine;

// Token: 0x020000C1 RID: 193
public class UiManager : MonoBehaviour
{
	// Token: 0x06000599 RID: 1433 RVA: 0x0001CAAC File Offset: 0x0001ACAC
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

	// Token: 0x0600059A RID: 1434 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Start()
	{
	}

	// Token: 0x0600059B RID: 1435 RVA: 0x0001CAE0 File Offset: 0x0001ACE0
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

	// Token: 0x0600059C RID: 1436 RVA: 0x0001CB5C File Offset: 0x0001AD5C
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

	// Token: 0x0600059D RID: 1437 RVA: 0x0001CBD8 File Offset: 0x0001ADD8
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

	// Token: 0x0600059E RID: 1438 RVA: 0x0001CC64 File Offset: 0x0001AE64
	public void ConnectionSuccessful()
	{
		this.startMenu.SetActive(false);
	}

	// Token: 0x040004FC RID: 1276
	public static UiManager instance;

	// Token: 0x040004FD RID: 1277
	public GameObject lobbyCam;

	// Token: 0x040004FE RID: 1278
	public GameObject startMenu;

	// Token: 0x040004FF RID: 1279
	public TMP_InputField usernameField;

	// Token: 0x04000500 RID: 1280
	public TMP_InputField ipField;

	// Token: 0x04000501 RID: 1281
	public TMP_InputField portField;

	// Token: 0x04000502 RID: 1282
	public GameObject server;
}
