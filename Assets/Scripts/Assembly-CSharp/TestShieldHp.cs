using System;
using UnityEngine;

// Token: 0x02000125 RID: 293
[ExecuteInEditMode]
public class TestShieldHp : MonoBehaviour
{
	// Token: 0x06000875 RID: 2165 RVA: 0x0002A54C File Offset: 0x0002874C
	private void Awake()
	{
		this.UpdateBar();
	}

	// Token: 0x06000876 RID: 2166 RVA: 0x0002A554 File Offset: 0x00028754
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

	// Token: 0x06000877 RID: 2167 RVA: 0x0002A54C File Offset: 0x0002874C
	private void Update()
	{
		this.UpdateBar();
	}

	// Token: 0x04000807 RID: 2055
	public int maxShield;

	// Token: 0x04000808 RID: 2056
	public int maxHp;

	// Token: 0x04000809 RID: 2057
	public int hp;

	// Token: 0x0400080A RID: 2058
	public int shield;

	// Token: 0x0400080B RID: 2059
	private int total;

	// Token: 0x0400080C RID: 2060
	private float maxHpScale;

	// Token: 0x0400080D RID: 2061
	private float maxShieldScale;

	// Token: 0x0400080E RID: 2062
	private float hpRatio;

	// Token: 0x0400080F RID: 2063
	private float shieldRatio;

	// Token: 0x04000810 RID: 2064
	public RectTransform hpBar;

	// Token: 0x04000811 RID: 2065
	public RectTransform shieldBar;
}
