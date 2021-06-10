
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

// Token: 0x02000056 RID: 86
public class PPController : MonoBehaviour
{
	// Token: 0x060001E5 RID: 485 RVA: 0x0000B1D8 File Offset: 0x000093D8
	private void Awake()
	{
		PPController.Instance = this;
		this.profile = base.GetComponent<PostProcessVolume>().profile;
		this.motionBlur = this.profile.GetSetting<MotionBlur>();
		this.bloom = this.profile.GetSetting<Bloom>();
		this.ao = this.profile.GetSetting<AmbientOcclusion>();
		this.chromaticAberration = this.profile.GetSetting<ChromaticAberration>();
	}

	// Token: 0x060001E6 RID: 486 RVA: 0x0000B240 File Offset: 0x00009440
	public void SetMotionBlur(bool b)
	{
		this.motionBlur.enabled.value = b;
	}

	// Token: 0x060001E7 RID: 487 RVA: 0x0000B254 File Offset: 0x00009454
	public void SetBloom(int i)
	{
		switch (i)
		{
		case 0:
			this.bloom.enabled.value = false;
			return;
		case 1:
			this.bloom.enabled.value = true;
			this.bloom.fastMode.value = true;
			return;
		case 2:
			this.bloom.enabled.value = true;
			this.bloom.fastMode.value = false;
			return;
		default:
			return;
		}
	}

	// Token: 0x060001E8 RID: 488 RVA: 0x0000B2CB File Offset: 0x000094CB
	public void SetAO(bool b)
	{
		this.ao.enabled.value = b;
		this.chromaticAberration.fastMode.value = !b;
	}

	// Token: 0x060001E9 RID: 489 RVA: 0x0000B2F4 File Offset: 0x000094F4
	public void SetChromaticAberration(float f)
	{
		if (f <= 0f)
		{
			this.chromaticAberration.enabled.value = false;
			return;
		}
		if (!this.chromaticAberration.enabled)
		{
			this.chromaticAberration.enabled.value = true;
		}
		this.chromaticAberration.intensity.value = f;
	}

	// Token: 0x060001EA RID: 490 RVA: 0x0000B34F File Offset: 0x0000954F
	public void Reset()
	{
		this.SetChromaticAberration(0f);
	}

	// Token: 0x040001EA RID: 490
	private MotionBlur motionBlur;

	// Token: 0x040001EB RID: 491
	private Bloom bloom;

	// Token: 0x040001EC RID: 492
	private AmbientOcclusion ao;

	// Token: 0x040001ED RID: 493
	private ChromaticAberration chromaticAberration;

	// Token: 0x040001EE RID: 494
	private PostProcessProfile profile;

	// Token: 0x040001EF RID: 495
	public static PPController Instance;
}
