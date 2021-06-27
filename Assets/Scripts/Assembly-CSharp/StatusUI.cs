using System;
using TMPro;
using UnityEngine;

// Token: 0x02000119 RID: 281
public class StatusUI : MonoBehaviour
{
	// Token: 0x06000811 RID: 2065 RVA: 0x0002899C File Offset: 0x00026B9C
	private void Start()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
	}

	// Token: 0x06000812 RID: 2066 RVA: 0x000289C0 File Offset: 0x00026BC0
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

	// Token: 0x040007B2 RID: 1970
	public RectTransform hpBar;

	// Token: 0x040007B3 RID: 1971
	public RectTransform shieldBar;

	// Token: 0x040007B4 RID: 1972
	public RectTransform armorBar;

	// Token: 0x040007B5 RID: 1973
	private float hpRatio;

	// Token: 0x040007B6 RID: 1974
	private float shieldRatio;

	// Token: 0x040007B7 RID: 1975
	public Transform hungerBar;

	// Token: 0x040007B8 RID: 1976
	public Transform staminaBar;

	// Token: 0x040007B9 RID: 1977
	public TextMeshProUGUI hpText;

	// Token: 0x040007BA RID: 1978
	private float currentHp;

	// Token: 0x040007BB RID: 1979
	private PlayerStatus playerStatus;

	// Token: 0x040007BC RID: 1980
	private float speed = 10f;
}
