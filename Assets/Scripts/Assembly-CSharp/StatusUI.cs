
using TMPro;
using UnityEngine;

// Token: 0x020000EA RID: 234
public class StatusUI : MonoBehaviour
{
	// Token: 0x060006CF RID: 1743 RVA: 0x000220FC File Offset: 0x000202FC
	private void Start()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
	}

	// Token: 0x060006D0 RID: 1744 RVA: 0x00022120 File Offset: 0x00020320
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

	// Token: 0x0400066D RID: 1645
	public RectTransform hpBar;

	// Token: 0x0400066E RID: 1646
	public RectTransform shieldBar;

	// Token: 0x0400066F RID: 1647
	public RectTransform armorBar;

	// Token: 0x04000670 RID: 1648
	private float hpRatio;

	// Token: 0x04000671 RID: 1649
	private float shieldRatio;

	// Token: 0x04000672 RID: 1650
	public Transform hungerBar;

	// Token: 0x04000673 RID: 1651
	public Transform staminaBar;

	// Token: 0x04000674 RID: 1652
	public TextMeshProUGUI hpText;

	// Token: 0x04000675 RID: 1653
	private float currentHp;

	// Token: 0x04000676 RID: 1654
	private PlayerStatus playerStatus;

	// Token: 0x04000677 RID: 1655
	private float speed = 10f;
}
