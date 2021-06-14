using System;
using UnityEngine;

// Token: 0x020000D1 RID: 209
public class NetworkManager : MonoBehaviour
{
	// Token: 0x1700003A RID: 58
	// (get) Token: 0x06000536 RID: 1334 RVA: 0x000056E3 File Offset: 0x000038E3
	// (set) Token: 0x06000537 RID: 1335 RVA: 0x000056EA File Offset: 0x000038EA
	public static float Clock { get; set; }

	// Token: 0x1700003B RID: 59
	// (get) Token: 0x06000538 RID: 1336 RVA: 0x000056F2 File Offset: 0x000038F2
	// (set) Token: 0x06000539 RID: 1337 RVA: 0x000056F9 File Offset: 0x000038F9
	public static float CountDown { get; set; }

	// Token: 0x0600053A RID: 1338 RVA: 0x00005701 File Offset: 0x00003901
	private void Update()
	{
		NetworkManager.Clock += Time.deltaTime;
	}

	// Token: 0x0600053B RID: 1339 RVA: 0x00005713 File Offset: 0x00003913
	public int GetSpawnPosition(int id)
	{
		return id;
	}

	// Token: 0x0600053C RID: 1340 RVA: 0x00005716 File Offset: 0x00003916
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

	// Token: 0x0600053D RID: 1341 RVA: 0x00002147 File Offset: 0x00000347
	private void Start()
	{
	}

	// Token: 0x0600053E RID: 1342 RVA: 0x00005749 File Offset: 0x00003949
	public void StartServer(int port)
	{
		Server.Start(40, port);
	}

	// Token: 0x0600053F RID: 1343 RVA: 0x00005753 File Offset: 0x00003953
	private void OnApplicationQuit()
	{
		Server.Stop();
	}

	// Token: 0x06000540 RID: 1344 RVA: 0x0000575A File Offset: 0x0000395A
	public void DestroyPlayer(GameObject g)
	{
	Destroy(g);
	}

	// Token: 0x040004E5 RID: 1253
	public static NetworkManager instance;
}
