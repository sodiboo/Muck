using System;
using UnityEngine;

// Token: 0x0200002A RID: 42
public class Dragon : MonoBehaviour
{
	// Token: 0x060000F7 RID: 247 RVA: 0x00006943 File Offset: 0x00004B43
	private void Awake()
	{
		Dragon.Instance = this;
		base.transform.rotation = Quaternion.LookRotation(Vector3.up);
	}

	// Token: 0x060000F8 RID: 248 RVA: 0x00006960 File Offset: 0x00004B60
	private void Start()
	{
		MusicController.Instance.StopSong(0.5f);
	}

	// Token: 0x060000F9 RID: 249 RVA: 0x00006971 File Offset: 0x00004B71
	public void PlayWingFlap()
	{
		this.wingFlap.Randomize(0f);
	}

	// Token: 0x060000FA RID: 250 RVA: 0x00006984 File Offset: 0x00004B84
	private void OnDestroy()
	{
		Debug.LogError("Game is over lol");
		Instantiate<GameObject>(this.roar, base.transform.position, Quaternion.identity);
		if (LocalClient.serverOwner)
		{
			GameManager.instance.GameOver(-3, 8f);
			ServerSend.GameOver(-2);
		}
	}

	// Token: 0x040000FB RID: 251
	public RandomSfx wingFlap;

	// Token: 0x040000FC RID: 252
	public GameObject roar;

	// Token: 0x040000FD RID: 253
	public static Dragon Instance;
}
