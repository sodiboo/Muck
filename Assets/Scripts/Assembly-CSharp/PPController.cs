using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class PPController : MonoBehaviour
{
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

	public void SetMotionBlur(bool b)
	{
		this.motionBlur.enabled.value = b;
	}

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

	public void SetAO(bool b)
	{
		this.ao.enabled.value = b;
		this.chromaticAberration.fastMode.value = !b;
	}

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

	public void Reset()
	{
		this.SetChromaticAberration(0f);
	}

	private MotionBlur motionBlur;

	private Bloom bloom;

	private AmbientOcclusion ao;

	private ChromaticAberration chromaticAberration;

	private PostProcessProfile profile;

	public static PPController Instance;
}
