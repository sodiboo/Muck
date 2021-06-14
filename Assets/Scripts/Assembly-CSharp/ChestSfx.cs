using System;
using UnityEngine;

// Token: 0x02000013 RID: 19
public class ChestSfx : MonoBehaviour
{
	// Token: 0x06000064 RID: 100 RVA: 0x000023DE File Offset: 0x000005DE
	private void Awake()
	{
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x06000065 RID: 101 RVA: 0x000023EC File Offset: 0x000005EC
	public void OpenChest()
	{
		this.audio.clip = this.open;
		this.audio.Play();
	}

	// Token: 0x06000066 RID: 102 RVA: 0x0000240A File Offset: 0x0000060A
	public void CloseChest()
	{
		this.audio.clip = this.close;
		this.audio.Play();
	}

	// Token: 0x04000063 RID: 99
	public AudioClip open;

	// Token: 0x04000064 RID: 100
	public AudioClip close;

	// Token: 0x04000065 RID: 101
	private AudioSource audio;
}
