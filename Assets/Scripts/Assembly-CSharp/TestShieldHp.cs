using System;
using UnityEngine;

[ExecuteInEditMode]
public class TestShieldHp : MonoBehaviour
{
	private void Awake()
	{
		this.UpdateBar();
	}

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

	private void Update()
	{
		this.UpdateBar();
	}

	public int maxShield;

	public int maxHp;

	public int hp;

	public int shield;

	private int total;

	private float maxHpScale;

	private float maxShieldScale;

	private float hpRatio;

	private float shieldRatio;

	public RectTransform hpBar;

	public RectTransform shieldBar;
}
