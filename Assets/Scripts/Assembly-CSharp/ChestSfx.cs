
using UnityEngine;

// Token: 0x02000011 RID: 17
public class ChestSfx : MonoBehaviour
{
	// Token: 0x06000060 RID: 96 RVA: 0x00004308 File Offset: 0x00002508
	private void Awake()
	{
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x06000061 RID: 97 RVA: 0x00004316 File Offset: 0x00002516
	public void OpenChest()
	{
		this.audio.clip = this.open;
		this.audio.Play();
	}

	// Token: 0x06000062 RID: 98 RVA: 0x00004334 File Offset: 0x00002534
	public void CloseChest()
	{
		this.audio.clip = this.close;
		this.audio.Play();
	}

	// Token: 0x0400005E RID: 94
	public AudioClip open;

	// Token: 0x0400005F RID: 95
	public AudioClip close;

	// Token: 0x04000060 RID: 96
	private AudioSource audio;
}
