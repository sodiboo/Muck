using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

// Token: 0x02000067 RID: 103
public class PPController : MonoBehaviour
{
	// Token: 0x06000212 RID: 530 RVA: 0x0000F7E4 File Offset: 0x0000D9E4
	private void Awake()
	{
		if (PPController.Instance)
		{
		Destroy(base.gameObject);
			return;
		}
		PPController.Instance = this;
		this.profile = base.GetComponent<PostProcessVolume>().profile;
		this.motionBlur = this.profile.GetSetting<MotionBlur>();
		this.bloom = this.profile.GetSetting<Bloom>();
		this.ao = this.profile.GetSetting<AmbientOcclusion>();
		this.chromaticAberration = this.profile.GetSetting<ChromaticAberration>();
	}

	// Token: 0x06000213 RID: 531 RVA: 0x000039AB File Offset: 0x00001BAB
	public void SetMotionBlur(bool b)
	{
		this.motionBlur.enabled.value = b;
	}

	// Token: 0x06000214 RID: 532 RVA: 0x0000F864 File Offset: 0x0000DA64
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

	// Token: 0x06000215 RID: 533 RVA: 0x000039BE File Offset: 0x00001BBE
	public void SetAO(bool b)
	{
		this.ao.enabled.value = b;
		this.chromaticAberration.fastMode.value = !b;
	}

	// Token: 0x06000216 RID: 534 RVA: 0x0000F8DC File Offset: 0x0000DADC
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

	// Token: 0x06000217 RID: 535 RVA: 0x000039E5 File Offset: 0x00001BE5
	public void Reset()
	{
		this.SetChromaticAberration(0f);
	}

	// Token: 0x04000236 RID: 566
	private MotionBlur motionBlur;

	// Token: 0x04000237 RID: 567
	private Bloom bloom;

	// Token: 0x04000238 RID: 568
	private AmbientOcclusion ao;

	// Token: 0x04000239 RID: 569
	private ChromaticAberration chromaticAberration;

	// Token: 0x0400023A RID: 570
	private PostProcessProfile profile;

	// Token: 0x0400023B RID: 571
	public static PPController Instance;
}
