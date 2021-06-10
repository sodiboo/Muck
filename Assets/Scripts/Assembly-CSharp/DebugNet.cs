
using System.Collections.Generic;
using Steamworks;
using TMPro;
using UnityEngine;
using UnityEngine.Profiling;
using UnityEngine.SceneManagement;

// Token: 0x020000A4 RID: 164
public class DebugNet : MonoBehaviour
{
	// Token: 0x0600052F RID: 1327 RVA: 0x0001ACC7 File Offset: 0x00018EC7
	private void Start()
	{
		DebugNet.Instance = this;
		base.gameObject.SetActive(false);
		base.InvokeRepeating("BandWidth", 1f, 1f);
	}

	// Token: 0x06000530 RID: 1328 RVA: 0x0001ACF0 File Offset: 0x00018EF0
	public void ToggleConsole()
	{
		base.gameObject.SetActive(!base.gameObject.activeInHierarchy);
	}

	// Token: 0x06000531 RID: 1329 RVA: 0x0001AD0B File Offset: 0x00018F0B
	private void Update()
	{
		this.Fps();
	}

	// Token: 0x06000532 RID: 1330 RVA: 0x0001AD14 File Offset: 0x00018F14
	private void Fps()
	{
		if (this.fpsOn || this.speedOn || this.pingOn || this.bandwidthOn)
		{
			if (!this.fps.gameObject.activeInHierarchy)
			{
				this.fps.gameObject.SetActive(true);
			}
			string text = "";
			this.deltaTime += (Time.unscaledDeltaTime - this.deltaTime) * 0.1f;
			float num = this.deltaTime * 1000f;
			float num2 = 1f / this.deltaTime;
			if (this.fpsOn)
			{
				text += string.Format("{0:0.0} ms ({1:0.} fps)", num, num2);
			}
			if (this.speedOn)
			{
				Vector3 zero = Vector3.zero;
				text = text + "\nm/s: " + string.Format("{0:F1}", new Vector2(zero.x, zero.z).magnitude);
			}
			if (this.pingOn)
			{
				int ping = NetStatus.GetPing();
				string text2 = "<color=";
				if (ping < 60)
				{
					text2 += "\"green\"";
				}
				else if (ping < 100)
				{
					text2 += "\"yellow\"";
				}
				else if (ping >= 100)
				{
					text2 += "\"red\"";
				}
				text += string.Format("\n{0}>ping: {1}ms <color=\"black\">", text2, NetStatus.GetPing());
			}
			if (this.bandwidthOn)
			{
				text = string.Concat(new string[]
				{
					text,
					string.Format("\nbyte up/s:    {0}", this.byteUp),
					string.Format("\nbyte down/s : {0}", this.byteDown),
					string.Format("\npacket up/s : {0}", this.pSent),
					string.Format("\npacket down/s : {0}", this.pReceived)
				});
			}
			text += "<size=70%>";
			foreach (string text3 in DebugNet.r)
			{
			}
			int num3 = 0;
			int num4 = 0;
			foreach (GameObject gameObject in SceneManager.GetActiveScene().GetRootGameObjects())
			{
				num3++;
				if (gameObject.activeInHierarchy)
				{
					num4++;
				}
			}
			text += string.Format("\ngos active: {0} | gos total {1}", num4, num3);
			text += string.Format("\nserver ip:    {0}", Server.ipAddress);
			text += string.Format("\nresources hashmap size: {0}", ResourceManager.Instance.list.Count);
			text += string.Format("\nactive mobs: {0} / {1}", MobManager.Instance.mobs.Count, GameLoop.currentMobCap);
			text += string.Format("\nhp multiplier: {0}", GameManager.instance.MobHpMultiplier());
			text += string.Format("\ndamage multiplier: {0}", GameManager.instance.MobDamageMultiplier());
			uint num5 = Profiler.GetTotalAllocatedMemory() / 1048576U;
			uint num6 = Profiler.GetTotalReservedMemory() / 1048576U;
			uint num7 = Profiler.GetTotalUnusedReservedMemory() / 1048576U;
			text += string.Format("\nramTotal: {0}mb | {1}mb / {2}mb", num5, num6, SystemInfo.systemMemorySize);
			text += string.Format("\nServer host: {0} ({1})", LocalClient.instance.serverHost, new Friend(LocalClient.instance.serverHost.Value).Name);
			text += string.Format("\nMy server id: {0}", LocalClient.instance.myId);
			text += string.Format("\nAm server owner: {0}", LocalClient.serverOwner);
			text += string.Format("Amount of mob zones: {0}", MobZoneManager.Instance.zones.Count);
			this.fps.text = text;
			return;
		}
		if (this.fps.enabled)
		{
			return;
		}
		this.fps.gameObject.SetActive(false);
	}

	// Token: 0x06000533 RID: 1331 RVA: 0x0001B168 File Offset: 0x00019368
	private void BandWidth()
	{
		this.byteUp = (float)ClientSend.bytesSent;
		this.byteDown = (float)LocalClient.byteDown;
		this.pSent = (float)ClientSend.packetsSent;
		this.pReceived = (float)LocalClient.packetsReceived;
		ClientSend.bytesSent = 0;
		ClientSend.packetsSent = 0;
		LocalClient.byteDown = 0;
		LocalClient.packetsReceived = 0;
	}

	// Token: 0x06000534 RID: 1332 RVA: 0x0001B1BD File Offset: 0x000193BD
	private void OpenConsole()
	{
		this.console.gameObject.SetActive(true);
	}

	// Token: 0x06000535 RID: 1333 RVA: 0x0001B1D0 File Offset: 0x000193D0
	private void CloseConsole()
	{
		this.console.gameObject.SetActive(false);
	}

	// Token: 0x0400042F RID: 1071
	public TextMeshProUGUI fps;

	// Token: 0x04000430 RID: 1072
	public GameObject console;

	// Token: 0x04000431 RID: 1073
	private bool fpsOn = true;

	// Token: 0x04000432 RID: 1074
	private bool speedOn = true;

	// Token: 0x04000433 RID: 1075
	private bool pingOn = true;

	// Token: 0x04000434 RID: 1076
	private bool bandwidthOn = true;

	// Token: 0x04000435 RID: 1077
	private float deltaTime;

	// Token: 0x04000436 RID: 1078
	public static List<string> r = new List<string>();

	// Token: 0x04000437 RID: 1079
	public static DebugNet Instance;

	// Token: 0x04000438 RID: 1080
	private float byteUp;

	// Token: 0x04000439 RID: 1081
	private float byteDown;

	// Token: 0x0400043A RID: 1082
	private float pSent;

	// Token: 0x0400043B RID: 1083
	private float pReceived;
}
