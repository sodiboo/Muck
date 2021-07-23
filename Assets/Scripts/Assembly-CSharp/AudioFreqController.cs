using UnityEngine;

public class AudioFreqController : MonoBehaviour
{
    public AudioLowPassFilter filter;

    private void Update()
    {
        if ((bool)PlayerStatus.Instance)
        {
            float num = 0f;
            if (PlayerStatus.Instance.hp <= 0f)
            {
                num = 1f;
            }
            else
            {
                float num2 = 0.75f;
                int num3 = PlayerStatus.Instance.HpAndShield();
                int num4 = PlayerStatus.Instance.MaxHpAndShield();
                num = (float)num3 / (float)num4;
                num = ((!(num > num2)) ? ((float)num3 / ((float)num4 * num2)) : 1f);
            }
            if (PlayerMovement.Instance.IsUnderWater())
            {
                num = 0.05f;
            }
            filter.cutoffFrequency = Mathf.Lerp(filter.cutoffFrequency, 22000f * num, Time.deltaTime * 8f);
        }
    }
}
