using UnityEngine;

// Token: 0x02000155 RID: 341
public class UiSfx : MonoBehaviour
{
	// Token: 0x0600082E RID: 2094 RVA: 0x000075B8 File Offset: 0x000057B8
	private void Awake()
	{
		UiSfx.Instance = this;
	}

	// Token: 0x0600082F RID: 2095 RVA: 0x00027EE0 File Offset: 0x000260E0
	public void PlayInventory(bool open)
	{
		if (open)
		{
			this.audio.clip = this.openInventory;
		}
		else
		{
			this.audio.clip = this.closeInventory;
		}
		this.audio.volume = 0.1f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x06000830 RID: 2096 RVA: 0x00027F4C File Offset: 0x0002614C
	public void PlayPickup()
	{
		this.audio.clip = this.pickupItem;
		this.audio.volume = 0.3f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x06000831 RID: 2097 RVA: 0x00027FA0 File Offset: 0x000261A0
	public void PlayArmor()
	{
		this.audio.clip = this.armor;
		this.audio.volume = 0.55f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x06000832 RID: 2098 RVA: 0x00027FF4 File Offset: 0x000261F4
	public void PlayClick()
	{
		this.audio.clip = this.hover;
		this.audio.volume = 0.65f;
		this.audio.pitch = Random.Range(0.6f, 0.7f);
		this.audio.Play();
	}

	// Token: 0x06000833 RID: 2099 RVA: 0x00028048 File Offset: 0x00026248
	public void PlayTaskComplete()
	{
		this.audio.clip = this.tutorialTask;
		this.audio.volume = 0.35f;
		this.audio.pitch = Random.Range(0.9f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x0400086E RID: 2158
	public AudioSource audio;

	// Token: 0x0400086F RID: 2159
	public AudioClip openInventory;

	// Token: 0x04000870 RID: 2160
	public AudioClip closeInventory;

	// Token: 0x04000871 RID: 2161
	public AudioClip pickupItem;

	// Token: 0x04000872 RID: 2162
	public AudioClip armor;

	// Token: 0x04000873 RID: 2163
	public AudioClip hover;

	// Token: 0x04000874 RID: 2164
	public AudioClip click;

	// Token: 0x04000875 RID: 2165
	public AudioClip tutorialTask;

	// Token: 0x04000876 RID: 2166
	public static UiSfx Instance;
}
