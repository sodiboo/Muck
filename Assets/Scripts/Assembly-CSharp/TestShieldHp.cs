
using UnityEngine;

// Token: 0x020000F5 RID: 245
[ExecuteInEditMode]
public class TestShieldHp : MonoBehaviour
{
	// Token: 0x06000731 RID: 1841 RVA: 0x00023C6C File Offset: 0x00021E6C
	private void Awake()
	{
		this.UpdateBar();
	}

	// Token: 0x06000732 RID: 1842 RVA: 0x00023C74 File Offset: 0x00021E74
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

	// Token: 0x06000733 RID: 1843 RVA: 0x00023C6C File Offset: 0x00021E6C
	private void Update()
	{
		this.UpdateBar();
	}

	// Token: 0x040006C2 RID: 1730
	public int maxShield;

	// Token: 0x040006C3 RID: 1731
	public int maxHp;

	// Token: 0x040006C4 RID: 1732
	public int hp;

	// Token: 0x040006C5 RID: 1733
	public int shield;

	// Token: 0x040006C6 RID: 1734
	private int total;

	// Token: 0x040006C7 RID: 1735
	private float maxHpScale;

	// Token: 0x040006C8 RID: 1736
	private float maxShieldScale;

	// Token: 0x040006C9 RID: 1737
	private float hpRatio;

	// Token: 0x040006CA RID: 1738
	private float shieldRatio;

	// Token: 0x040006CB RID: 1739
	public RectTransform hpBar;

	// Token: 0x040006CC RID: 1740
	public RectTransform shieldBar;
}
