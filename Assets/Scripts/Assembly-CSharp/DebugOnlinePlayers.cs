using System;
using UnityEngine;

// Token: 0x02000022 RID: 34
public class DebugOnlinePlayers : MonoBehaviour
{
	// Token: 0x060000B7 RID: 183 RVA: 0x0000A048 File Offset: 0x00008248
	private void Start()
	{
		GameManager.instance.SpawnPlayer(2, "a", Color.black, new Vector3(0f, 30f, 0f), 50f);
		GameManager.instance.SpawnPlayer(3, "b", Color.black, new Vector3(5f, 30f, 2f), 150f);
	}
}
