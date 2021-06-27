using System;
using System.Collections.Generic;
using Steamworks;
using TMPro;
using UnityEngine;
using UnityEngine.Profiling;
using UnityEngine.SceneManagement;

// Token: 0x020000CB RID: 203
public class DebugNet : MonoBehaviour
{
	// Token: 0x06000635 RID: 1589 RVA: 0x000207BB File Offset: 0x0001E9BB
	private void Start()
	{
		DebugNet.Instance = this;
		base.gameObject.SetActive(false);
		InvokeRepeating(nameof(BandWidth), 1f, 1f);
	}

	// Token: 0x06000636 RID: 1590 RVA: 0x000207E4 File Offset: 0x0001E9E4
	public void ToggleConsole()
	{
		base.gameObject.SetActive(!base.gameObject.activeInHierarchy);
	}

	// Token: 0x06000637 RID: 1591 RVA: 0x000207FF File Offset: 0x0001E9FF
	private void Update()
	{
		this.Fps();
	}

	// Token: 0x06000638 RID: 1592 RVA: 0x00020808 File Offset: 0x0001EA08
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

	// Token: 0x06000639 RID: 1593 RVA: 0x00020C80 File Offset: 0x0001EE80
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

	// Token: 0x0600063A RID: 1594 RVA: 0x00020CD5 File Offset: 0x0001EED5
	private void OpenConsole()
	{
		this.console.gameObject.SetActive(true);
	}

	// Token: 0x0600063B RID: 1595 RVA: 0x00020CE8 File Offset: 0x0001EEE8
	private void CloseConsole()
	{
		this.console.gameObject.SetActive(false);
	}

	// Token: 0x0400053F RID: 1343
	public TextMeshProUGUI fps;

	// Token: 0x04000540 RID: 1344
	public GameObject console;

	// Token: 0x04000541 RID: 1345
	private bool fpsOn = true;

	// Token: 0x04000542 RID: 1346
	private bool speedOn = true;

	// Token: 0x04000543 RID: 1347
	private bool pingOn = true;

	// Token: 0x04000544 RID: 1348
	private bool bandwidthOn = true;

	// Token: 0x04000545 RID: 1349
	private float deltaTime;

	// Token: 0x04000546 RID: 1350
	public static List<string> r = new List<string>();

	// Token: 0x04000547 RID: 1351
	public static DebugNet Instance;

	// Token: 0x04000548 RID: 1352
	private float byteUp;

	// Token: 0x04000549 RID: 1353
	private float byteDown;

	// Token: 0x0400054A RID: 1354
	private float pSent;

	// Token: 0x0400054B RID: 1355
	private float pReceived;
}
