using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class BossUI : MonoBehaviour
{
	private void Awake()
	{
		BossUI.Instance = this;
		this.layout.transform.localScale = Vector3.zero;
		this.desiredScale = Vector3.zero;
	}

	public void SetBoss(Mob b)
	{
		if (this.currentBoss != null)
		{
			return;
		}
		this.currentBoss = b;
		this.bossName.text = "";
		if (b.IsBuff())
		{
			TextMeshProUGUI textMeshProUGUI = this.bossName;
			textMeshProUGUI.text += "Buff ";
		}
		TextMeshProUGUI textMeshProUGUI2 = this.bossName;
		textMeshProUGUI2.text += b.GetComponent<Hitable>().entityName;
		Debug.LogError("hitavle entity name: " + b.GetComponent<Hitable>().entityName);
		this.currentHp = 0f;
		this.desiredScale = Vector3.one;
		this.hitableMob = b.GetComponent<HitableMob>();
		this.layout.gameObject.SetActive(true);
		this.layout.localScale = Vector3.zero;
	}

	private void Update()
	{
		if (this.currentBoss == null)
		{
			if (this.layout.gameObject.activeInHierarchy)
			{
				this.layout.gameObject.SetActive(false);
				if (DayCycle.time < 0.5f)
				{
					MusicController.Instance.StopSong(-1f);
				}
			}
			return;
		}
		this.currentHp = Mathf.Lerp(this.currentHp, (float)this.hitableMob.hp, Time.deltaTime * 10f);
		this.hpText.text = Mathf.RoundToInt(this.currentHp) + " / " + this.hitableMob.maxHp;
		float x = (float)this.hitableMob.hp / (float)this.hitableMob.maxHp;
		this.hpBar.transform.localScale = new Vector3(x, 1f, 1f);
		this.layout.transform.localScale = Vector3.Lerp(this.layout.transform.localScale, this.desiredScale, Time.deltaTime * 10f);
	}

	public TextMeshProUGUI bossName;

	public TextMeshProUGUI hpText;

	public RawImage hpBar;

	public Mob currentBoss;

	private HitableMob hitableMob;

	private int desiredHp;

	public Transform layout;

	private Vector3 desiredScale;

	public static BossUI Instance;

	private float currentHp;
}
