using System;
using UnityEngine;

// Token: 0x02000149 RID: 329
[ExecuteInEditMode]
public class TestShieldHp : MonoBehaviour
{
	// Token: 0x060007ED RID: 2029 RVA: 0x00007364 File Offset: 0x00005564
	private void Awake()
	{
		this.UpdateBar();
	}

	// Token: 0x060007EE RID: 2030 RVA: 0x0002701C File Offset: 0x0002521C
	private void UpdateBar()
	{
		this.total = this.maxShield + this.maxHp;
		this.maxHpScale = (float)this.maxHp / (float)this.total;
		this.maxShieldScale = (float)this.maxShield / (float)this.total;
		if (this.maxHp == 0)
		{
			this.hpRatio = 0f;
		}
		else
		{
			this.hpRatio = (float)this.hp / (float)this.maxHp;
		}
		if (this.maxShield == 0)
		{
			this.shieldRatio = 0f;
		}
		else
		{
			this.shieldRatio = (float)this.shield / (float)this.maxShield;
		}
		this.hpBar.transform.localScale = new Vector3(this.maxHpScale * this.hpRatio, 1f, 1f);
		this.shieldBar.transform.localScale = new Vector3(this.maxShieldScale * this.shieldRatio, 1f, 1f);
	}

	// Token: 0x060007EF RID: 2031 RVA: 0x00007364 File Offset: 0x00005564
	private void Update()
	{
		this.UpdateBar();
	}

	// Token: 0x04000828 RID: 2088
	public int maxShield;

	// Token: 0x04000829 RID: 2089
	public int maxHp;

	// Token: 0x0400082A RID: 2090
	public int hp;

	// Token: 0x0400082B RID: 2091
	public int shield;

	// Token: 0x0400082C RID: 2092
	private int total;

	// Token: 0x0400082D RID: 2093
	private float maxHpScale;

	// Token: 0x0400082E RID: 2094
	private float maxShieldScale;

	// Token: 0x0400082F RID: 2095
	private float hpRatio;

	// Token: 0x04000830 RID: 2096
	private float shieldRatio;

	// Token: 0x04000831 RID: 2097
	public RectTransform hpBar;

	// Token: 0x04000832 RID: 2098
	public RectTransform shieldBar;
}
