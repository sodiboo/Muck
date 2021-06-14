using System;
using System.Collections.Generic;
using Steamworks;
using TMPro;
using UnityEngine;
using UnityEngine.Profiling;
using UnityEngine.SceneManagement;

// Token: 0x020000D8 RID: 216
public class DebugNet : MonoBehaviour
{
	// Token: 0x060005BF RID: 1471 RVA: 0x000058E5 File Offset: 0x00003AE5
	private void Start()
	{
		DebugNet.Instance = this;
		base.gameObject.SetActive(false);
		base.InvokeRepeating("BandWidth", 1f, 1f);
	}

	// Token: 0x060005C0 RID: 1472 RVA: 0x0000590E File Offset: 0x00003B0E
	public void ToggleConsole()
	{
		base.gameObject.SetActive(!base.gameObject.activeInHierarchy);
	}

	// Token: 0x060005C1 RID: 1473 RVA: 0x00005929 File Offset: 0x00003B29
	private void Update()
	{
		this.Fps();
	}

	// Token: 0x060005C2 RID: 1474 RVA: 0x0001F118 File Offset: 0x0001D318
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
				Vector3 velocity = PlayerMovement.Instance.GetVelocity();
				text = text + "\nm/s: " + string.Format("{0:F1}", new Vector2(velocity.x, velocity.z).magnitude);
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
			text += string.Format("\nactive mobs: {0}", MobManager.Instance.mobs.Count);
			text += string.Format("\nactive mobs: {0} /  / {1}", MobManager.Instance.GetActiveEnemies(), GameLoop.currentMobCap);
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

	// Token: 0x060005C3 RID: 1475 RVA: 0x0001F590 File Offset: 0x0001D790
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

	// Token: 0x060005C4 RID: 1476 RVA: 0x00005931 File Offset: 0x00003B31
	private void OpenConsole()
	{
		this.console.gameObject.SetActive(true);
	}

	// Token: 0x060005C5 RID: 1477 RVA: 0x00005944 File Offset: 0x00003B44
	private void CloseConsole()
	{
		this.console.gameObject.SetActive(false);
	}

	// Token: 0x0400050C RID: 1292
	public TextMeshProUGUI fps;

	// Token: 0x0400050D RID: 1293
	public GameObject console;

	// Token: 0x0400050E RID: 1294
	private bool fpsOn = true;

	// Token: 0x0400050F RID: 1295
	private bool speedOn = true;

	// Token: 0x04000510 RID: 1296
	private bool pingOn = true;

	// Token: 0x04000511 RID: 1297
	private bool bandwidthOn = true;

	// Token: 0x04000512 RID: 1298
	private float deltaTime;

	// Token: 0x04000513 RID: 1299
	public static List<string> r = new List<string>();

	// Token: 0x04000514 RID: 1300
	public static DebugNet Instance;

	// Token: 0x04000515 RID: 1301
	private float byteUp;

	// Token: 0x04000516 RID: 1302
	private float byteDown;

	// Token: 0x04000517 RID: 1303
	private float pSent;

	// Token: 0x04000518 RID: 1304
	private float pReceived;
}
