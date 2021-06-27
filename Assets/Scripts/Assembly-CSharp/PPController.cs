using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

// Token: 0x02000074 RID: 116
public class PPController : MonoBehaviour
{
	// Token: 0x06000299 RID: 665 RVA: 0x0000EC24 File Offset: 0x0000CE24
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

	// Token: 0x0600029A RID: 666 RVA: 0x0000ECA4 File Offset: 0x0000CEA4
	public void SetMotionBlur(bool b)
	{
		this.motionBlur.enabled.value = b;
	}

	// Token: 0x0600029B RID: 667 RVA: 0x0000ECB8 File Offset: 0x0000CEB8
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

	// Token: 0x0600029C RID: 668 RVA: 0x0000ED2F File Offset: 0x0000CF2F
	public void SetAO(bool b)
	{
		this.ao.enabled.value = b;
		this.chromaticAberration.fastMode.value = !b;
	}

	// Token: 0x0600029D RID: 669 RVA: 0x0000ED58 File Offset: 0x0000CF58
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

	// Token: 0x0600029E RID: 670 RVA: 0x0000EDB3 File Offset: 0x0000CFB3
	public void Reset()
	{
		this.SetChromaticAberration(0f);
	}

	// Token: 0x040002B3 RID: 691
	private MotionBlur motionBlur;

	// Token: 0x040002B4 RID: 692
	private Bloom bloom;

	// Token: 0x040002B5 RID: 693
	private AmbientOcclusion ao;

	// Token: 0x040002B6 RID: 694
	private ChromaticAberration chromaticAberration;

	// Token: 0x040002B7 RID: 695
	private PostProcessProfile profile;

	// Token: 0x040002B8 RID: 696
	public static PPController Instance;
}
