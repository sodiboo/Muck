using System;
using UnityEngine;

// Token: 0x02000017 RID: 23
public class ChestSfx : MonoBehaviour
{
	// Token: 0x06000094 RID: 148 RVA: 0x00004F54 File Offset: 0x00003154
	private void Awake()
	{
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x06000095 RID: 149 RVA: 0x00004F62 File Offset: 0x00003162
	public void OpenChest()
	{
		this.audio.clip = this.open;
		this.audio.Play();
	}

	// Token: 0x06000096 RID: 150 RVA: 0x00004F80 File Offset: 0x00003180
	public void CloseChest()
	{
		this.audio.clip = this.close;
		this.audio.Play();
	}

	// Token: 0x04000097 RID: 151
	public AudioClip open;

	// Token: 0x04000098 RID: 152
	public AudioClip close;

	// Token: 0x04000099 RID: 153
	private AudioSource audio;
}
