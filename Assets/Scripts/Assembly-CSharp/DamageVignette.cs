using UnityEngine;
using UnityEngine.UI;

public class DamageVignette : MonoBehaviour
{
    public RawImage vignette;

    public static DamageVignette Instance;

    private void Awake()
    {
        Instance = this;
    }

    private void Update()
    {
        if ((bool)PlayerStatus.Instance)
        {
            float num = 0f;
            if (((bool)MoveCamera.Instance && MoveCamera.Instance.state == MoveCamera.CameraState.Spectate) || MoveCamera.Instance.state == MoveCamera.CameraState.Freecam)
            {
                num = 0f;
            }
            else if (PlayerStatus.Instance.hp <= 0f)
            {
                num = 1f;
            }
            else
            {
                float num2 = 0.75f;
                int num3 = PlayerStatus.Instance.HpAndShield();
                int num4 = PlayerStatus.Instance.MaxHpAndShield();
                num = (float)num3 / (float)num4;
                num = ((!(num > num2)) ? (1f - (float)num3 / ((float)num4 * num2)) : 0f);
            }
            Color color = vignette.color;
            color.a = num;
            vignette.color = Color.Lerp(vignette.color, color, Time.deltaTime * 12f);
        }
    }

    public void VignetteHit()
    {
        Color color = vignette.color;
        color.a += 0.8f;
        vignette.color = color;
    }
}
