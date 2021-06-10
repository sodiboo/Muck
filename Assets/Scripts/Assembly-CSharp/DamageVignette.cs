
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000018 RID: 24
public class DamageVignette : MonoBehaviour
{
	// Token: 0x06000095 RID: 149 RVA: 0x00004EFF File Offset: 0x000030FF
	private void Awake()
	{
		DamageVignette.Instance = this;
	}

	// Token: 0x06000096 RID: 150 RVA: 0x00004F08 File Offset: 0x00003108
	private void Update()
	{
		if (!PlayerStatus.Instance)
		{
			return;
		}
		float num;
		if (MoveCamera.Instance && MoveCamera.Instance.state == MoveCamera.CameraState.Spectate)
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
			if (num > num2)
			{
				num = 0f;
			}
			else
			{
				num = 1f - (float)num3 / ((float)num4 * num2);
			}
		}
		Color color = this.vignette.color;
		color.a = num;
		this.vignette.color = Color.Lerp(this.vignette.color, color, Time.deltaTime * 12f);
	}

	// Token: 0x06000097 RID: 151 RVA: 0x00004FDC File Offset: 0x000031DC
	public void VignetteHit()
	{
		Color color = this.vignette.color;
		color.a += 0.8f;
		this.vignette.color = color;
	}

	// Token: 0x04000086 RID: 134
	public RawImage vignette;

	// Token: 0x04000087 RID: 135
	public static DamageVignette Instance;
}
