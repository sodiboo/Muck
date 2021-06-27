using System;
using TMPro;
using UnityEngine;

public class StatusUI : MonoBehaviour
{
	public void Awake() {
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) gameObject.SetActive(false);
	}

	private void Start()
	{
		if (!PlayerMovement.Instance)
		{
			return;
		}
		this.playerStatus = PlayerMovement.Instance.gameObject.GetComponent<PlayerStatus>();
	}

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

	public RectTransform hpBar;

	public RectTransform shieldBar;

	public RectTransform armorBar;

	private float hpRatio;

	private float shieldRatio;

	public Transform hungerBar;

	public Transform staminaBar;

	public TextMeshProUGUI hpText;

	private float currentHp;

	private PlayerStatus playerStatus;

	private float speed = 10f;
}
