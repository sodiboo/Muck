using System;
using UnityEngine;

// Token: 0x020000C5 RID: 197
public class NetworkManager : MonoBehaviour
{
	// Token: 0x1700003E RID: 62
	// (get) Token: 0x060005AD RID: 1453 RVA: 0x0001D351 File Offset: 0x0001B551
	// (set) Token: 0x060005AE RID: 1454 RVA: 0x0001D358 File Offset: 0x0001B558
	public static float Clock { get; set; }

	// Token: 0x1700003F RID: 63
	// (get) Token: 0x060005AF RID: 1455 RVA: 0x0001D360 File Offset: 0x0001B560
	// (set) Token: 0x060005B0 RID: 1456 RVA: 0x0001D367 File Offset: 0x0001B567
	public static float CountDown { get; set; }

	// Token: 0x060005B1 RID: 1457 RVA: 0x0001D36F File Offset: 0x0001B56F
	private void Update()
	{
		NetworkManager.Clock += Time.deltaTime;
	}

	// Token: 0x060005B2 RID: 1458 RVA: 0x0001D381 File Offset: 0x0001B581
	public int GetSpawnPosition(int id)
	{
		return id;
	}

	// Token: 0x060005B3 RID: 1459 RVA: 0x0001D384 File Offset: 0x0001B584
	private void Awake()
	{
		if (NetworkManager.instance == null)
		{
			NetworkManager.instance = this;
			return;
		}
		if (NetworkManager.instance != this)
		{
			Debug.Log("Instance already exists, destroying object");
			Destroy(this);
		}
	}

	// Token: 0x060005B4 RID: 1460 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Start()
	{
	}

	// Token: 0x060005B5 RID: 1461 RVA: 0x0001D3B7 File Offset: 0x0001B5B7
	public void StartServer(int port)
	{
		Server.Start(40, port);
	}

	// Token: 0x060005B6 RID: 1462 RVA: 0x0001D3C1 File Offset: 0x0001B5C1
	private void OnApplicationQuit()
	{
		Server.Stop();
	}

	// Token: 0x060005B7 RID: 1463 RVA: 0x0001D3C8 File Offset: 0x0001B5C8
	public void DestroyPlayer(GameObject g)
	{
		Destroy(g);
	}

	// Token: 0x04000518 RID: 1304
	public static NetworkManager instance;
}
