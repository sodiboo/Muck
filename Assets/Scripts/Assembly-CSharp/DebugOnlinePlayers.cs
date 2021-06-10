
using UnityEngine;

// Token: 0x0200001C RID: 28
public class DebugOnlinePlayers : MonoBehaviour
{
	// Token: 0x060000AB RID: 171 RVA: 0x00005720 File Offset: 0x00003920
	private void Start()
	{
		GameManager.instance.SpawnPlayer(2, "a", Color.black, new Vector3(0f, 30f, 0f), 50f);
		GameManager.instance.SpawnPlayer(3, "b", Color.black, new Vector3(5f, 30f, 2f), 150f);
	}
}
