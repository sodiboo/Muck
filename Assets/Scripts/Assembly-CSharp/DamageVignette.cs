using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200001C RID: 28
public class DamageVignette : MonoBehaviour
{
	// Token: 0x0600009F RID: 159 RVA: 0x00002981 File Offset: 0x00000B81
	private void Awake()
	{
		DamageVignette.Instance = this;
	}

	// Token: 0x060000A0 RID: 160 RVA: 0x00009924 File Offset: 0x00007B24
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

	// Token: 0x060000A1 RID: 161 RVA: 0x000099F8 File Offset: 0x00007BF8
	public void VignetteHit()
	{
		Color color = this.vignette.color;
		color.a += 0.8f;
		this.vignette.color = color;
	}

	// Token: 0x04000096 RID: 150
	public RawImage vignette;

	// Token: 0x04000097 RID: 151
	public static DamageVignette Instance;
}
