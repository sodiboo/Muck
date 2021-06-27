using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000020 RID: 32
public class DamageVignette : MonoBehaviour
{
	// Token: 0x060000D1 RID: 209 RVA: 0x00005E1B File Offset: 0x0000401B
	private void Awake()
	{
		DamageVignette.Instance = this;
	}

	// Token: 0x060000D2 RID: 210 RVA: 0x00005E24 File Offset: 0x00004024
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

	// Token: 0x060000D3 RID: 211 RVA: 0x00005EF8 File Offset: 0x000040F8
	public void VignetteHit()
	{
		Color color = this.vignette.color;
		color.a += 0.8f;
		this.vignette.color = color;
	}

	// Token: 0x040000CB RID: 203
	public RawImage vignette;

	// Token: 0x040000CC RID: 204
	public static DamageVignette Instance;
}
