using UnityEngine;

// Token: 0x0200012F RID: 303
public class UiSfx : MonoBehaviour
{
	// Token: 0x060008B6 RID: 2230 RVA: 0x0002B692 File Offset: 0x00029892
	private void Awake()
	{
		UiSfx.Instance = this;
	}

	// Token: 0x060008B7 RID: 2231 RVA: 0x0002B69C File Offset: 0x0002989C
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

	// Token: 0x060008B8 RID: 2232 RVA: 0x0002B708 File Offset: 0x00029908
	public void PlayPickup()
	{
		this.audio.clip = this.pickupItem;
		this.audio.volume = 0.3f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x060008B9 RID: 2233 RVA: 0x0002B75C File Offset: 0x0002995C
	public void PlayArmor()
	{
		this.audio.clip = this.armor;
		this.audio.volume = 0.55f;
		this.audio.pitch = Random.Range(0.8f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x060008BA RID: 2234 RVA: 0x0002B7B0 File Offset: 0x000299B0
	public void PlayClick()
	{
		this.audio.clip = this.hover;
		this.audio.volume = 0.65f;
		this.audio.pitch = Random.Range(0.6f, 0.7f);
		this.audio.Play();
	}

	// Token: 0x060008BB RID: 2235 RVA: 0x0002B804 File Offset: 0x00029A04
	public void PlayTaskComplete()
	{
		this.audio.clip = this.tutorialTask;
		this.audio.volume = 0.35f;
		this.audio.pitch = Random.Range(0.9f, 1.2f);
		this.audio.Play();
	}

	// Token: 0x04000843 RID: 2115
	public AudioSource audio;

	// Token: 0x04000844 RID: 2116
	public AudioClip openInventory;

	// Token: 0x04000845 RID: 2117
	public AudioClip closeInventory;

	// Token: 0x04000846 RID: 2118
	public AudioClip pickupItem;

	// Token: 0x04000847 RID: 2119
	public AudioClip armor;

	// Token: 0x04000848 RID: 2120
	public AudioClip hover;

	// Token: 0x04000849 RID: 2121
	public AudioClip click;

	// Token: 0x0400084A RID: 2122
	public AudioClip tutorialTask;

	// Token: 0x0400084B RID: 2123
	public static UiSfx Instance;
}
