using System;
using UnityEngine;

// Token: 0x02000026 RID: 38
public class DebugOnlinePlayers : MonoBehaviour
{
	// Token: 0x060000E9 RID: 233 RVA: 0x000066AC File Offset: 0x000048AC
	private void Start()
	{
		GameManager.instance.SpawnPlayer(2, "a", Color.black, new Vector3(0f, 30f, 0f), 50f);
		GameManager.instance.SpawnPlayer(3, "b", Color.black, new Vector3(5f, 30f, 2f), 150f);
	}
}
