
using UnityEngine;

// Token: 0x0200009E RID: 158
public class NetworkManager : MonoBehaviour
{
	// Token: 0x17000032 RID: 50
	// (get) Token: 0x060004AE RID: 1198 RVA: 0x00017AFC File Offset: 0x00015CFC
	// (set) Token: 0x060004AF RID: 1199 RVA: 0x00017B03 File Offset: 0x00015D03
	public static float Clock { get; set; }

	// Token: 0x17000033 RID: 51
	// (get) Token: 0x060004B0 RID: 1200 RVA: 0x00017B0B File Offset: 0x00015D0B
	// (set) Token: 0x060004B1 RID: 1201 RVA: 0x00017B12 File Offset: 0x00015D12
	public static float CountDown { get; set; }

	// Token: 0x060004B2 RID: 1202 RVA: 0x00017B1A File Offset: 0x00015D1A
	private void Update()
	{
		NetworkManager.Clock += Time.deltaTime;
	}

	// Token: 0x060004B3 RID: 1203 RVA: 0x00017B2C File Offset: 0x00015D2C
	public int GetSpawnPosition(int id)
	{
		return id;
	}

	// Token: 0x060004B4 RID: 1204 RVA: 0x00017B2F File Offset: 0x00015D2F
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

	// Token: 0x060004B5 RID: 1205 RVA: 0x0000276E File Offset: 0x0000096E
	private void Start()
	{
	}

	// Token: 0x060004B6 RID: 1206 RVA: 0x00017B62 File Offset: 0x00015D62
	public void StartServer(int port)
	{
		Server.Start(40, port);
	}

	// Token: 0x060004B7 RID: 1207 RVA: 0x00017B6C File Offset: 0x00015D6C
	private void OnApplicationQuit()
	{
		Server.Stop();
	}

	// Token: 0x060004B8 RID: 1208 RVA: 0x00017B73 File Offset: 0x00015D73
	public void DestroyPlayer(GameObject g)
	{
	Destroy(g);
	}

	// Token: 0x04000409 RID: 1033
	public static NetworkManager instance;
}
