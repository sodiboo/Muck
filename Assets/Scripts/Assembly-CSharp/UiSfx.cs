
using UnityEngine;

// Token: 0x020000FE RID: 254
public class UiSfx : MonoBehaviour
{
	// Token: 0x0600076F RID: 1903 RVA: 0x00024D72 File Offset: 0x00022F72
	private void Awake()
	{
		UiSfx.Instance = this;
	}

	// Token: 0x06000770 RID: 1904 RVA: 0x00024D7C File Offset: 0x00022F7C
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

	// Token: 0x06000771 RID: 1905 RVA: 0x00024DE8 File Offset: 0x00022FE8
	public void PlayPickup()
	{
		this.audio.clip = this.pickupItem;
		this.audio.volume = 0.3f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x06000772 RID: 1906 RVA: 0x00024E3C File Offset: 0x0002303C
	public void PlayArmor()
	{
		this.audio.clip = this.armor;
		this.audio.volume = 0.55f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x06000773 RID: 1907 RVA: 0x00024E90 File Offset: 0x00023090
	public void PlayClick()
	{
		this.audio.clip = this.hover;
		this.audio.volume = 0.65f;
		this.audio.pitch = Random.Range(0.6f, 0.7f);
		this.audio.Play();
	}

	// Token: 0x06000774 RID: 1908 RVA: 0x00024EE4 File Offset: 0x000230E4
	public void PlayTaskComplete()
	{
		this.audio.clip = this.tutorialTask;
		this.audio.volume = 0.35f;
		this.audio.pitch = Random.Range(0.9f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x040006FB RID: 1787
	public AudioSource audio;

	// Token: 0x040006FC RID: 1788
	public AudioClip openInventory;

	// Token: 0x040006FD RID: 1789
	public AudioClip closeInventory;

	// Token: 0x040006FE RID: 1790
	public AudioClip pickupItem;

	// Token: 0x040006FF RID: 1791
	public AudioClip armor;

	// Token: 0x04000700 RID: 1792
	public AudioClip hover;

	// Token: 0x04000701 RID: 1793
	public AudioClip click;

	// Token: 0x04000702 RID: 1794
	public AudioClip tutorialTask;

	// Token: 0x04000703 RID: 1795
	public static UiSfx Instance;
}
