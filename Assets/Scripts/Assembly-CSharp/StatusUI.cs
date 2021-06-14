using System;
using TMPro;
using UnityEngine;

// Token: 0x02000139 RID: 313
public class StatusUI : MonoBehaviour
{
	// Token: 0x06000782 RID: 1922 RVA: 0x00006F80 File Offset: 0x00005180
	private void Start()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
	}

	// Token: 0x06000783 RID: 1923 RVA: 0x000252C0 File Offset: 0x000234C0
	private void Update()
	{
		if (!(this.playerStatus == null))
		{
			this.currentHp = Mathf.Lerp(this.currentHp, PlayerStatus.Instance.hp + PlayerStatus.Instance.shield, Time.deltaTime * 3f);
			this.hpText.text = Mathf.Round(this.currentHp) + " / " + (PlayerStatus.Instance.maxHp + PlayerStatus.Instance.maxShield);
			float x = Mathf.Lerp(this.hpBar.localScale.x, this.playerStatus.GetHpRatio(), Time.deltaTime * this.speed);
			this.hpBar.localScale = new Vector3(x, 1f, 1f);
			float x2 = Mathf.Lerp(this.shieldBar.localScale.x, this.playerStatus.GetShieldRatio(), Time.deltaTime * this.speed);
			this.shieldBar.localScale = new Vector3(x2, 1f, 1f);
			float x3 = Mathf.Lerp(this.hungerBar.localScale.x, this.playerStatus.GetHungerRatio(), Time.deltaTime * this.speed);
			this.hungerBar.localScale = new Vector3(x3, 1f, 1f);
			float x4 = Mathf.Lerp(this.staminaBar.localScale.x, this.playerStatus.GetStaminaRatio(), Time.deltaTime * this.speed);
			this.staminaBar.localScale = new Vector3(x4, 1f, 1f);
			float x5 = Mathf.Lerp(this.armorBar.localScale.x, this.playerStatus.GetArmorRatio(), Time.deltaTime * this.speed);
			this.armorBar.localScale = new Vector3(x5, 1f, 1f);
			return;
		}
		if (PlayerMovement.Instance == null)
		{
			return;
		}
		this.playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
	}

	// Token: 0x040007BF RID: 1983
	public RectTransform hpBar;

	// Token: 0x040007C0 RID: 1984
	public RectTransform shieldBar;

	// Token: 0x040007C1 RID: 1985
	public RectTransform armorBar;

	// Token: 0x040007C2 RID: 1986
	private float hpRatio;

	// Token: 0x040007C3 RID: 1987
	private float shieldRatio;

	// Token: 0x040007C4 RID: 1988
	public Transform hungerBar;

	// Token: 0x040007C5 RID: 1989
	public Transform staminaBar;

	// Token: 0x040007C6 RID: 1990
	public TextMeshProUGUI hpText;

	// Token: 0x040007C7 RID: 1991
	private float currentHp;

	// Token: 0x040007C8 RID: 1992
	private PlayerStatus playerStatus;

	// Token: 0x040007C9 RID: 1993
	private float speed = 10f;
}
