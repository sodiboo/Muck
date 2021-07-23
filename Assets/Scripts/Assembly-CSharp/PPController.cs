using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class PPController : MonoBehaviour
{
    private MotionBlur motionBlur;

    private Bloom bloom;

    private AmbientOcclusion ao;

    private ChromaticAberration chromaticAberration;

    private PostProcessProfile profile;

    public static PPController Instance;

    private void Awake()
    {
        if ((bool)Instance)
        {
            Object.Destroy(base.gameObject);
            return;
        }
        Instance = this;
        profile = GetComponent<PostProcessVolume>().profile;
        motionBlur = profile.GetSetting<MotionBlur>();
        bloom = profile.GetSetting<Bloom>();
        ao = profile.GetSetting<AmbientOcclusion>();
        chromaticAberration = profile.GetSetting<ChromaticAberration>();
    }

    public void SetMotionBlur(bool b)
    {
        motionBlur.enabled.value = b;
    }

    public void SetBloom(int i)
    {
        switch (i)
        {
        case 0:
            bloom.enabled.value = false;
            break;
        case 1:
            bloom.enabled.value = true;
            bloom.fastMode.value = true;
            break;
        case 2:
            bloom.enabled.value = true;
            bloom.fastMode.value = false;
            break;
        }
    }

    public void SetAO(bool b)
    {
        ao.enabled.value = b;
        chromaticAberration.fastMode.value = !b;
    }

    public void SetChromaticAberration(float f)
    {
        if (f <= 0f)
        {
            chromaticAberration.enabled.value = false;
            return;
        }
        if (!chromaticAberration.enabled)
        {
            chromaticAberration.enabled.value = true;
        }
        chromaticAberration.intensity.value = f;
    }

    public void Reset()
    {
        SetChromaticAberration(0f);
    }
}
